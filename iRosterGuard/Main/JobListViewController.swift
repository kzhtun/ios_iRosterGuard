//
//  JobListViewController.swift
//  iRosterGuard
//
//  Created by Kyaw Zin Htun on 02/10/2020.
//

import UIKit
import LMCSideMenu

class JobListViewController: UIViewController, LMCSideMenuCenterControllerProtocol {
    let App = UIApplication.shared.delegate as! AppDelegate
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var interactor: MenuTransitionInteractor = MenuTransitionInteractor()
    
  
    var sDateString: String!
    var eDateString: String!
    var sDate: Date!
    var eDate: Date!
    var selectDate: Date!
    var isGroup: Bool = true
    
    var siteList = [SiteDetail]()
    var groupList = [SiteDetail]()
    var separatedList = [SiteDetail]()
    var refreshControl = UIRefreshControl()
    
   
    @IBOutlet weak var btnListType: UIButton!
    @IBOutlet weak var MainTableView: UITableView!
    @IBOutlet weak var mTitle: UILabel!
    @IBOutlet weak var mSubTitle: UILabel!
    
    
    @IBAction func menuOnClick(_ sender: Any) {
        presentLeftMenu()
    }
    
    @IBAction func btnListTypeOnClick(_ sender: Any) {
      
        if(isGroup){
            btnListType.setImage(UIImage(named: "ic_group"), for: .normal)
            siteList = groupList
        }else{
            btnListType.setImage(UIImage(named: "ic_list"), for: .normal)
            siteList = separatedList
        }

        isGroup = !isGroup
        print("isGroup: \(isGroup)")
        
        if(self.isGroup){
            self.siteList = self.groupList
        }else{
            self.siteList = self.separatedList
        }
        
        MainTableView.reloadData()
    }
    
    @IBAction func btnPrevOnClick(_ sender: Any) {
       var dateComponent = DateComponents()
        dateComponent.day = -7
        selectDate = Calendar.current.date(byAdding: dateComponent, to: selectDate)
        callGuardJobListBySite(date: selectDate)
        
        MainTableView.tableHeaderView = nil
    }
    
    @IBAction func btnNextOnClick(_ sender: Any) {
      
        var dateComponent = DateComponents()
        dateComponent.day = 7
        selectDate = Calendar.current.date(byAdding: dateComponent, to: selectDate)
        callGuardJobListBySite(date: selectDate)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        mTitle.textColor = UIColor.white
        mSubTitle.textColor = UIColor.white
       
        self.MainTableView.delegate = self
        self.MainTableView.dataSource = self
        //    self.MainTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        if(isGroup){
            btnListType.setImage(UIImage(named: "ic_group"), for: .normal)
        }else{
            btnListType.setImage(UIImage(named: "ic_list"), for: .normal)
        }
        
        if(selectDate == nil){
            selectDate = Date()
        }
        callGuardJobListBySite(date: selectDate)
    }
    
    func calculateDates(date: Date){
        presentLeftMenu()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menuController = storyboard?.instantiateViewController(withIdentifier: String(describing: MenuController.self)) as! MenuController
        
        //Setup menu
        setupMenu(leftMenu: menuController, rightMenu: nil)
        
        //enable screen edge gestures if needed
        enableLeftMenuGesture()
        
        self.MainTableView.sectionHeaderHeight = UITableView.automaticDimension
        self.MainTableView.estimatedSectionHeaderHeight = 25
        
        self.MainTableView.sectionFooterHeight = UITableView.automaticDimension
        self.MainTableView.estimatedSectionFooterHeight = 25
        

       
      //  self.MainTableView.separatorColor = self.MainTableView.backgroundColor
        
        // pull to refresh
        
 //       refreshControl.tintColor = UIColor.init(hex: "#3366CCFF")
        
//        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.init(hex: "#3366CCFF")]
//        let attributedTitle = NSAttributedString(string: "Refreshing ...", attributes: attributes)
//
//        refreshControl.attributedTitle = attributedTitle
//
//        // refreshControl.attributedTitle = NSAttributedString(string: "Refreshing ...")
//        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
//        MainTableView.addSubview(refreshControl)
        
        
        //enable screen edge gestures if needed
        enableLeftMenuGesture()
       
    }
    
    
    @objc
    func refresh(_ sender: AnyObject) {
      callGuardJobListBySite(date: selectDate)
    }
    
    private func callGuardJobListBySite(date: Date){
        self.siteList.removeAll()
        
        // calculate dates
        let format = DateFormatter()
        format.timeZone = .some(TimeZone(abbreviation: "UTC+08")!)
        format.dateFormat = "MM-dd-yyyy"
        
        let now = convertDateToLocalTime(selectDate)
        sDate = convertDateToLocalTime(now.startOfWeek!)
        eDate = convertDateToLocalTime(now.endOfWeek!)
        sDateString =  format.string(from: sDate )
        eDateString =  format.string(from: eDate )
        
        format.dateFormat = "dd MMM"
        mSubTitle.text = "\(format.string(from: sDate )) ~ \(format.string(from: eDate ))".uppercased()
        
        //        print("Select Date : \(selectDate)")
        //        print("Select sDate : \(sDate)")
        //        print("Select eDate : \(eDate)")
        
        Router.sharedInstance().GuardJobList(sDate: sDateString, eDate: eDateString, guardCode: App.GUARD_ID, type: "SITE",  success:  {
            (successObject) in
            
            if( successObject.responsemessage?.uppercased() == "SUCCESS"){
                if(successObject.SiteDetails!.count > 0){
                    
                    self.groupList = successObject.SiteDetails!
                    self.separatedList = self.refectorSiteList(jobList: successObject.SiteDetails!)
                    
                    if(self.isGroup){
                        self.siteList = self.groupList
                    }else{
                        self.siteList = self.separatedList
                    }
                    
                }
                
                self.view.makeToast("Fetching Job List Success ")
                
            }else{ // open Message List Screen
                self.view.makeToast(successObject.responsemessage)
            }
            
            self.MainTableView.reloadData()
           // self.refreshControl.endRefreshing()
            
        }, failure: {
            (failureObject) in
            print(failureObject as Any)
        })
    }
    
    func refectorSiteList(jobList: [SiteDetail]) -> [SiteDetail]{
        var tmpSiteList = [SiteDetail]()
        var tmpJobList = [JobDetail]()
        
        for i in 0 ..< jobList.count{
            for j in 0 ..< jobList[i].JobDetails.count{
                tmpJobList.append(jobList[i].JobDetails[j])
                
                tmpSiteList.append(SiteDetail.init(JobDetails: tmpJobList, sitename: tmpJobList[0].sitename))
                
                tmpJobList.removeAll()
            }
        }
        
        return tmpSiteList
    }

}



// MARK: Extension
extension JobListViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell") as! HeaderTableViewCell
        
        cell.configure(siteName: siteList[section].sitename, siteAddress: siteList[section].JobDetails[0].address)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FooterTableViewCell") as! FooterTableViewCell
        return cell
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var sectionCount = 0
        
        if(siteList.count == 0){
            // no data
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.MainTableView.bounds.size.width, height: self.MainTableView.bounds.size.height))
                    noDataLabel.text = "No Data Available"
            noDataLabel.textColor = UIColor(hex: "#AAAAAAFF")
            noDataLabel.textAlignment = NSTextAlignment.center
                    self.MainTableView.backgroundView = noDataLabel
            
            sectionCount = 0

        }else{
            self.MainTableView.backgroundView = nil
            sectionCount = siteList.count
        }
        
        return sectionCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return siteList[section].JobDetails.count + (isGroup ? 1 : 0) // for header row when group by site
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(isGroup){
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as! ItemTableViewCell
            
            if(indexPath.row == 0){
                cell.configuretHeader()
            }else{
                let i = indexPath.row - 1
                
                cell.configure(sr: String(i+1),
                               date: siteList[indexPath.section].JobDetails[i].jobdate,
                               position: siteList[indexPath.section].JobDetails[i].GuardGrade,
                               status: siteList[indexPath.section].JobDetails[i].status
                )
            }
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemListTableViewCell", for: indexPath) as! ItemListTableViewCell
            
           
            let i = indexPath.row
            let jobDetail = siteList[indexPath.section].JobDetails[i] as JobDetail
            
            cell.configure(date: jobDetail.jobdate,
                           status: jobDetail.status,
                           shift: jobDetail.SiteShift,
                           shiftDesc:"\(jobDetail.starttime)~\(jobDetail.endtime)",
                           pos: jobDetail.GuardGrade, posDesc: jobDetail.GuardGradeDesc)
            
            return cell
        }
        
        
    }
    
    
}


extension UITableView {

    func addTopBounceAreaView(color: UIColor = .white) {
        var frame = UIScreen.main.bounds
        frame.origin.y = -frame.size.height

        let view = UIView(frame: frame)
        view.backgroundColor = color

        self.addSubview(view)
    }
}


extension Date {
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let startDay = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 1, to: startDay)
    }
    
    var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let startDay = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 7, to: startDay)
    }
}

func convertDateToLocalTime(_ date: Date) -> Date {
    let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: date))
    return Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: date)!
    
    
    
    //    let now = convertDateToLocalTime(Date())
    //
    //    let startWeek = convertDateToLocalTime(now.startOfWeek!)
    //    let endWeek = convertDateToLocalTime(now.endOfWeek!)
    //
    //    print("Local time is: \(now)")
    //
    //    print("Start of week is: \(startWeek)")
    //    print("End of week is: \(endWeek)")
}



