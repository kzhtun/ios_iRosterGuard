//
//  JobListViewController.swift
//  iRosterGuard
//
//  Created by Kyaw Zin Htun on 02/10/2020.
//

import UIKit

class JobListViewController: UIViewController {
    let App = UIApplication.shared.delegate as! AppDelegate
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    var siteList = [SiteDetail]()
  
    @IBOutlet weak var MainTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        
      //  self.MainTableView.register(SiteTableViewCell.nib(), forCellReuseIdentifier: SiteTableViewCell.indentifier)
        self.MainTableView.delegate = self
        self.MainTableView.dataSource = self
    //    self.MainTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        callGuardJobListBySite()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.MainTableView.sectionHeaderHeight = UITableView.automaticDimension
        self.MainTableView.estimatedSectionHeaderHeight = 25
        
        self.MainTableView.sectionFooterHeight = UITableView.automaticDimension
        self.MainTableView.estimatedSectionFooterHeight = 25
        
        
       
    }
    
    
    private func callGuardJobListBySite(){
        // showLoading()
        
        Router.sharedInstance().GuardJobList(sDate: "09-14-2020", eDate: "09-20-2020", guardCode: App.GUARD_ID, type: "SITE",  success:  {
            (successObject) in
            
            if( successObject.responsemessage?.uppercased() == "SUCCESS"){
                self.view.makeToast("Fetching Job List Success ")
                self.siteList = successObject.SiteDetails!
                
                self.MainTableView.reloadData()
                
            }else{ // open Message List Screen
                self.view.makeToast("INVALID")
            }
            
            print(successObject)
            
            
        }, failure: {
            (failureObject) in
            print(failureObject as Any)
        })
        
    }
    
    private func resutlReformat(){
        for i in 0 ..< siteList.count{
            
        }
    }
  
}

extension JobListViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell") as! HeaderTableViewCell
        
        cell.configure(siteName: siteList[section].sitename, siteAddress: siteList[section].JobDetails[0].address)
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FooterTableViewCell") as! FooterTableViewCell
        
        
       // cell.configure(siteName: siteList[section].sitename, siteAddress: siteList[section].JobDetails[0].address)
        
        return cell
    }
    
   
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return siteList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
       return siteList[section].JobDetails.count + 1 // for header row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    }
    
    
}


