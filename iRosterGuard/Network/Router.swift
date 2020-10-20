//
//  Router.swift
//  iRosterGuard
//
//  Created by Kyaw Zin Htun on 27/09/2020.
//

import Foundation
import Alamofire

class Router{
    let App = UIApplication.shared.delegate as! AppDelegate
    static var instance: Router?
    let baseURL = "http://info121.sytes.net/restapimetropolis/MyLimoService.svc/"
    
    
    //  @GET("validateuser/{guardcode},{password},{isNFC},{fcmToken},{secretkey},{mobilekey}")
    //     @GET("getUserProfile/{guardId},{secretkey},{mobileKey}")
    //     @GET("UpdatePassword/{guardId},{password},{secretkey},{mobileKey}")
    //     @GET("getGuardJobs/{sDate},{eDate},{guardId},{secretkey},{mobileKey}")
    
    
    func ValidateUser(guardCode: String, password: String, iNFC: String, fcmToken: String,
                      success: @escaping (_ responseObject: ResponseObject) -> Void, failure: @escaping (_ error: String) -> Void){
        
        let url = String(format: "%@%@/%@,%@,%@,%@,%@,%@", baseURL, "validateuser", guardCode, password, iNFC, fcmToken, getSecretKey(), getMobileKey())
        
        AF.request(url, method: .get)
            .response{
                (response) in
                
                guard let data = response.data else{
                    print("ValidateUser Success, No Data")
                    return
                }
                do{
                    let objRes = try JSONDecoder().decode(ResponseObject.self, from: data)
                    
                    success(objRes)
                    
                    print("ValidateUser Success")
                }catch{
                    failure("ValidateUser Failed")
                }
            }
    }
    
   
    func GuardJobList(sDate: String, eDate: String, guardCode: String, type: String,
                      success: @escaping (_ responseObject: ResponseObject) -> Void, failure: @escaping (_ error: String) -> Void){
        
        let headers: HTTPHeaders = [
            "driver": self.App.GUARD_ID,
            "token": self.App.AUT_TOKEN
        ]
        
        
        let url = String(format: "%@%@/%@,%@,%@,%@,%@,%@", baseURL, "getGuardJobs",
                         sDate, eDate,
                         guardCode, type, getSecretKey(), getMobileKey())
        
        AF.request(url, method: .get, headers: headers)
            .response{
                (response) in
                
                guard let data = response.data else{
                    print("GuardJobList Success, No Data")
                    return
                }
                do{
                    let objRes = try JSONDecoder().decode(ResponseObject.self, from: data)
                    
                    success(objRes)
                    
                    print("GuardJobList Success")
                }catch{
                    failure("GuardJobList Failed")
                }
            }
    }
    
  
 
    func GerUserProfile(guardId: String,
                      success: @escaping (_ responseObject: ResponseObject) -> Void, failure: @escaping (_ error: String) -> Void){
        
        let headers: HTTPHeaders = [
            "driver": self.App.GUARD_ID,
            "token": self.App.AUT_TOKEN
        ]
    
        let url = String(format: "%@%@/%@,%@,%@", baseURL, "getUserProfile",
                         guardId, getSecretKey(), getMobileKey())
        
        AF.request(url, method: .get, headers: headers)
            .response{
                (response) in
                
                guard let data = response.data else{
                    print("GerUserProfile Success, No Data")
                    return
                }
                do{
                    let objRes = try JSONDecoder().decode(ResponseObject.self, from: data)
                    
                    success(objRes)
                    
                    print("GerUserProfile Success")
                }catch{
                    failure("GerUserProfile Failed")
                }
            }
    }
    
    //     @GET("UpdatePassword/{guardId},{password},{secretkey},{mobileKey}")
    func UpdatePassword(guardId: String, password: String,
                      success: @escaping (_ responseObject: ResponseObject) -> Void, failure: @escaping (_ error: String) -> Void){
        
        let headers: HTTPHeaders = [
            "driver": self.App.GUARD_ID,
            "token": self.App.AUT_TOKEN
        ]
    
        let url = String(format: "%@%@/%@,%@,%@,%@", baseURL, "UpdatePassword",
                         guardId, password, getSecretKey(), getMobileKey())
        
        AF.request(url, method: .get, headers: headers)
            .response{
                (response) in
               
                guard let data = response.data else{
                    print("Update Password Success, No Data")
                    return
                }
                
                do{
                    let objRes = try JSONDecoder().decode(ResponseObject.self, from: data)
                    
                    success(objRes)
                    
                    print("Update Password Success")
                }catch{
                    failure("Update Password Failed")
                }
            }
    }
    
    
    static func sharedInstance() -> Router {
        if self.instance == nil {
            self.instance = Router()
        }
        return self.instance!
    }
    
}

