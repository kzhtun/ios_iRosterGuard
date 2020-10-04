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
    let baseURL = "http://info121.sytes.net:84/restapimetropolis/MyLimoService.svc/"
    
    
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
    
    // http://info121.sytes.net:84/restapimetropolis/MyLimoService.svc/getGuardJobs/09-14-2020,09-20-2020,zTEST001,WEEK,info12101102020,chcchwhwhct
    func GuardJobList(sDate: String, eDate: String, guardCode: String, type: String,
                      success: @escaping (_ responseObject: ResponseObject) -> Void, failure: @escaping (_ error: String) -> Void){
        
        let headers: HTTPHeaders = [
            "driver": self.App.GUARD_ID,
            "token": self.App.AUT_TOKEN
        ]
        
        
        let url = String(format: "%@%@/%@,%@,%@,%@,%@,%@", baseURL, "getGuardJobs",
                         "09-14-2020","09-20-2020",
                         guardCode, "SITE", getSecretKey(), getMobileKey())
        
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
    
    
    
    static func sharedInstance() -> Router {
        if self.instance == nil {
            self.instance = Router()
        }
        return self.instance!
    }
    
}
//    // @GET("unregisterdevice/{deviceId},{secretKey},{mobileKey}")
//    func UnRegisterDevice(deviceId: String,
//    success: @escaping (_ responseObject: ResponseObject) -> Void, failure: @escaping (_ error: String) -> Void){
//
//        let headers: HTTPHeaders = [
//                  "driver": getDeviceID(),
//                  "token": self.App.AUT_TOKEN
//              ]
//
//        let url = String(format: "%@%@/%@,%@,%@", baseURL, "unregisterdevice", deviceId, getSecretKey(), getMobileKey())
//
//        AF.request(url, headers: headers)
//            .response{
//                (responseData) in
//                guard let data = responseData.data else {return}
//                do{
//                    let objRes = try JSONDecoder().decode(ResponseObject.self, from: data)
//
//                    success(objRes)
//
//                    print("UnRegisterDevice Success")
//                }catch{
//                    failure("UnRegisterDevice Failed")
//                }
//        }
//    }
