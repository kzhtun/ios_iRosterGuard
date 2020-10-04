//
//  FooterTableViewCell.swift
//  iRosterGuard
//
//  Created by Kyaw Zin Htun on 04/10/2020.
//

import UIKit

class FooterTableViewCell: UITableViewCell {

    @IBOutlet weak var mSubmit: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        mSubmit.backgroundColor = UIColor.init(cgColor: #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1))
        mSubmit.titleLabel?.textColor = UIColor.white
        mSubmit.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
