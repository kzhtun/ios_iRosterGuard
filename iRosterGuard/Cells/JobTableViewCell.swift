//
//  JobTableViewCell.swift
//  iRosterGuard
//
//  Created by Kyaw Zin Htun on 04/10/2020.
//

import UIKit

class JobTableViewCell: UITableViewCell {
    static let indentifier = "JobTableViewCell"
    
    static func nib()-> UINib{
        return UINib(nibName: "JobTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
