//
//  HeaderTableViewCell.swift
//  iRosterGuard
//
//  Created by Kyaw Zin Htun on 04/10/2020.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mSiteName: UILabel!
    @IBOutlet weak var mSiteAddress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(siteName: String, siteAddress: String){
    
        mSiteName.text = siteName
        mSiteAddress.text = siteAddress
        
    }
    

}
