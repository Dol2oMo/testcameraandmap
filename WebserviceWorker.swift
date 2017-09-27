//
//  WebserviceWorker.swift
//  jsonAlmofire
//
//  Created by MC-MG57035 on 9/12/2560 BE.
//  Copyright © 2560 Dol2oMo. All rights reserved.
//

import UIKit
import Alamofire


enum ContentWorkerMode {
    case contentprovince
    case contentdistrict
    case contentsubdistrict
    case contenttypecar
    case contentmes_register
}


@objc protocol WebServiceWorkerdelegate:class {
    
    @objc optional func finishedWorker(worker:WebserviceWorker ,result:AnyObject)
    @objc optional func failedWorker(worker:WebserviceWorker ,result:Any)
}

class WebserviceWorker: NSObject {
    
    var delegates:WebServiceWorkerdelegate?
    var requestClassDelegate:WebServiceWorkerdelegate?
    
    
    var mode:ContentWorkerMode?
    
    func requestMethodservice(Requestmesthod:String ,URLString:String ,Parameters:[String:AnyObject]? ,workerMode:ContentWorkerMode, isAuthorization:Bool) {
        if Requestmesthod.isEmpty == false && URLString.isEmpty == false {
            
            //            var operation  = RequestoperationManag()
            
            mode = workerMode
            
            var request = URLRequest(url:URL(string:URLString)!)
            request.timeoutInterval = 20
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            if isAuthorization {
                request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")  // the
                request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
                
                //                let boundary = generateBoundaryString()
                //                request.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
            }
            
            
            if Requestmesthod == "POST" {
                request.httpMethod = "POST"
                //                let params = ["7542":"book_id" ,"352":"user_id" , "ios":"platform" ,"1245asdasdasdsda":"mac_address"] as NSDictionary
                
                var bodyData = ""
                for (key,value) in Parameters!{
                    
                    if let encodedKey = (key as AnyObject).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
                        if let encodedValue = (value as AnyObject).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
                            if bodyData == nil
                            {
                                continue
                            }
                            else
                            {
                                if bodyData == "" {
                                    
                                }
                                else{
                                    bodyData += "&"
                                }
                            }
                            bodyData += encodedKey + "=" + encodedValue
                        }
                    }
                }
                
                request.httpBody = bodyData.data(using: .utf8)
                
//                let task = URLSession.shared.dataTask(with: request, completionHandler: {datas, response, error -> Void in
//                    guard let data = datas, error == nil else {                                                // check for fundamental networking error
//                        print("error=\(String(describing: error))")
//                        self.requestFailedWithOperation(error:error)
//                        return
//                    }
//                    
//                    if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
//                        print("statusCode should be 200, but is \(httpStatus.statusCode)")
//                        //                        print("response = \(String(describing: response))")
//                    }
//                    else{
//                        //                        let responseString = String(data: data, encoding: .utf8)
//                        //                        print("responseString = \(String(describing: responseString))")
//                        
//                        self.requestFinishedWithJSON(data: data)
//                    }
//                })
//                task.resume()
                
                let task = Alamofire.request(request).responseJSON(completionHandler: {
                    responds in
                    print(responds.result.value)
                })
                
                
            }
                
            else if Requestmesthod == "GET" {
                let task = URLSession.shared.dataTask(with: request, completionHandler: {datas, response, error -> Void in
                    guard let data = datas, error == nil else {                                                 // check for fundamental networking error
                        print("error=\(String(describing: error))")
                        self.requestFailedWithOperation(error:error)
                        return
                    }
                    
                    if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                        print("statusCode should be 200, but is \(httpStatus.statusCode)")
                        //                        print("response = \(String(describing: response))")
                    }
                    else{
                        
                        //                    let responseString = String(data: data, encoding: .utf8)
                        //                    print("responseString = \(String(describing: responseString))")
                        
                        
                        self.requestFinishedWithJSON(data: data)
                    }
                })
                
                task.resume()
                
            }
        }
    }
    
    func requestWithMethod(requestMethod:String ,urlString:String ,workerMode:ContentWorkerMode){
        let params:[String:AnyObject]? = nil
        self.requestMethodservice(Requestmesthod: requestMethod, URLString: urlString, Parameters: params ,workerMode:workerMode , isAuthorization: false)
    }
    
    func requestWithMethod(requestMethod:String ,urlString:String ,Parameter:[String:AnyObject] , workerMode:ContentWorkerMode) {
        self.requestMethodservice(Requestmesthod: requestMethod, URLString: urlString, Parameters: Parameter ,workerMode: workerMode ,isAuthorization: false)
    }
    
    func testjson(){
        let params = [ "book_id":"9532",
                       "user_id":"532",
                       "platform":"ios",
                       "mac_address":"sdasd23512sdasd2224"]
        self.requestMethodservice(Requestmesthod: "POST", URLString: "https://www.mbookstore.com/webservice_v1/public/service/book", Parameters: params as [String : AnyObject], workerMode:.contentmes_register, isAuthorization: false)

    }
    
    
    
    func requestFailedWithOperation(error:Error?){
        
    }
    
    func requestFinishedWithJSON(data:Any){
        
    }

}
