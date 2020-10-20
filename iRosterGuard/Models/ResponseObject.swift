//
//  ResponseObject.swift
//  iRosterGuard
//
//  Created by Kyaw Zin Htun on 27/09/2020.
//

import Foundation


struct ResponseObject: Codable {
    var IsUnderMaintenance: String?
    var JobDetails: String?
    var LevelDetails: String?
    var LevelNotCheckedDetails: String?
    
    var MessageDetails: String?
    var ProfileDetails: [ProfileDetail]?
 
    var RoundsDetails: String?
    let SiteDetails: [SiteDetail]?
    var UnitDetails: String?
    var UserHP: String?
    var Version: String?
    var lastlogin: String?
    var responsemessage: String?
    var status: String?
    var token: String?
    
    
//    var IsUnderMaintenance: String?
//    var LevelDetails: String?
//    var LevelNotCheckedDetails: String?
//    let MessageDetails: [MessageDetail]?
//    var ProfileDetails: [ProfileDetail]?
//    var RoundsDetails: String?
//    var UnitDetails: String?
//    var UserHP: String?
//    var Version: String?
//    var lastlogin: String?
//    var responsemessage: String?
//    var status: String?
//    var token: String?
   
}
