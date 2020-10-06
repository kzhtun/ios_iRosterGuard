//
//  MenuTableViewCell.swift
//  iRosterGuard
//
//  Created by Kyaw Zin Htun on 06/10/2020.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var mIcon: UIImageView!
    @IBOutlet weak var mMenu: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(icon: String, menuName: String){
     
        mIcon.image = UIImage(named:icon)
        mMenu.text = menuName
    }

}
