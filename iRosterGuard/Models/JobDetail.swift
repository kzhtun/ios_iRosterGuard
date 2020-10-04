//
//  JobDetails.swift
//  iRosterGuard
//
//  Created by Kyaw Zin Htun on 27/09/2020.
//

import Foundation

struct JobDetail: Codable {
    var GuardGrade: String
    var GuardGradeDesc: String
    var JobCode: String
    var SiteShift: String
    var address: String
    var attendancecode: String
    var attendancename: String
    var cluster: String
    var endtime: String
    var globalshift: String
    var jobdate: String
    var jobno: String
    var sitecode: String
    var sitename: String
    var starttime: String
    var status: String
  
}
