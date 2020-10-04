//
//  SiteTableViewCell.swift
//  iRosterGuard
//
//  Created by Kyaw Zin Htun on 03/10/2020.
//

import UIKit

class SiteTableViewCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource  {
   
    static let indentifier = "SiteTableViewCell"
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var mSiteName: UILabel!
    @IBOutlet weak var mAddress: UILabel!
    @IBOutlet weak var JobTableView: UITableView!
    
    static func nib()-> UINib{
        return UINib(nibName: "SiteTableViewCell", bundle: nil)
    }
    
    public func configure<D: UITableViewDelegate & UITableViewDataSource>(siteName: String, siteAddress: String, dataSourceDelegate: D){
        
        mSiteName.text = siteName
        mAddress.text = siteAddress
       
//        self.JobTableView.register(JobTableViewCell.nib(), forCellReuseIdentifier: JobTableViewCell.indentifier)
//        self.JobTableView.delegate = dataSourceDelegate
//        self.JobTableView.dataSource = dataSourceDelegate
       
        self.JobTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "JobTableViewCell", for: indexPath) as! JobTableViewCell
        return cell
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    override func draw(_ rect: CGRect) {
//           super.draw(rect)
//           //Set containerView drop shadow
//        
//   //   containerView.layer.backgroundColor = UIColor.white.cgColor
//             containerView.layer.cornerRadius = 8
//               containerView.layer.borderWidth = 0.5
//              containerView.layer.borderColor = UIColor.white.cgColor
//        containerView.layer.shadowColor = UIColor.lightGray.cgColor
//               containerView.layer.shadowRadius = 8
//        containerView.layer.shadowOpacity = 0.5
//        containerView.layer.shadowOffset = CGSize(width:0.5, height: 0.5)
//               containerView.layer.shadowPath = UIBezierPath(rect: containerView.bounds).cgPath
//         
//       }

    
}
