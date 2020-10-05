//
//  ItemListTableViewCell.swift
//  iRosterGuard
//
//  Created by Kyaw Zin Htun on 05/10/2020.
//

import UIKit

class ItemListTableViewCell: UITableViewCell {


    @IBOutlet weak var mDate: UILabel!
    @IBOutlet weak var mStatus: UILabel!
    @IBOutlet weak var mShift: UILabel!
    @IBOutlet weak var mShiftDesc: UILabel!
    @IBOutlet weak var mPos: UILabel!
    @IBOutlet weak var mPosDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    public func configure(date: String, status: String,  shift: String,  shiftDesc: String, pos: String, posDesc: String ){
        
        
        // receiving format
        let format = DateFormatter()
        format.dateFormat = "M/d/yyyy hh:mm:ss a"
        format.timeZone = .some(TimeZone(abbreviation: "UTC+08")!)

        // display format
        let displayDate = format.date(from: date)
        format.dateFormat = "dd-MMM-yyyy, E"
        
        if(status.uppercased()=="PENDING"){
            mStatus.textColor = UIColor(hex: "#FF0000FF")
        }else{
            mStatus.textColor = UIColor(hex: "#3C8D00FF")
        }
        
        mDate.text = format.string(from: displayDate!)
        mStatus.text = status.uppercased()
        mPos.text = pos.uppercased()
        mPosDesc.text = posDesc
        mShift.text = shift
        mShiftDesc.text = shiftDesc
       
    }
}

//extension UIColor {
//    public convenience init?(hex: String) {
//        let r, g, b, a: CGFloat
//
//        if hex.hasPrefix("#") {
//            let start = hex.index(hex.startIndex, offsetBy: 1)
//            let hexColor = String(hex[start...])
//
//            if hexColor.count == 8 {
//                let scanner = Scanner(string: hexColor)
//                var hexNumber: UInt64 = 0
//
//                if scanner.scanHexInt64(&hexNumber) {
//                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
//                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
//                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
//                    a = CGFloat(hexNumber & 0x000000ff) / 255
//
//                    self.init(red: r, green: g, blue: b, alpha: a)
//                    return
//                }
//            }
//        }
//
//        return nil
//    }
//}
