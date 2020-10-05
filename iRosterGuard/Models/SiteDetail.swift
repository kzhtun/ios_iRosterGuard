//
//  SiteDetails.swift
//  iRosterGuard
//
//  Created by Kyaw Zin Htun on 27/09/2020.
//

import Foundation

struct SiteDetail: Codable {
    
    
    var JobDetails: [JobDetail]
    var sitename: String
    
    internal init(JobDetails: [JobDetail], sitename: String) {
        self.JobDetails = JobDetails
        self.sitename = sitename
    }
    
  
}
