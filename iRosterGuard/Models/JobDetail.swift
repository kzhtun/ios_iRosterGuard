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
    
    internal init(GuardGrade: String, GuardGradeDesc: String, JobCode: String, SiteShift: String, address: String, attendancecode: String, attendancename: String, cluster: String, endtime: String, globalshift: String, jobdate: String, jobno: String, sitecode: String, sitename: String, starttime: String, status: String) {
        self.GuardGrade = GuardGrade
        self.GuardGradeDesc = GuardGradeDesc
        self.JobCode = JobCode
        self.SiteShift = SiteShift
        self.address = address
        self.attendancecode = attendancecode
        self.attendancename = attendancename
        self.cluster = cluster
        self.endtime = endtime
        self.globalshift = globalshift
        self.jobdate = jobdate
        self.jobno = jobno
        self.sitecode = sitecode
        self.sitename = sitename
        self.starttime = starttime
        self.status = status
    }
  
}
