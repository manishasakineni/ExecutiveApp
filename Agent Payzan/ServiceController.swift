//
//  ServiceController.swift
//  PayZan
//
//  Created by CalibrageMac02 on 09/10/17.
//  Copyright © 2017 CalibrageMac02. All rights reserved.
//

import Foundation
import UIKit

let reachability = Reachability()!
//var appDelegate = AppDelegate()

var appDelegate = AppDelegate()

var serviceController  = ServiceController()

class ServiceController: NSObject {
    
    let content_type = "application/json; charset=utf-8"
    var userDetailsDoictionary   = LoginParamsAPIModel()
    var accesTokenStr:String = ""
    var tokenTypeStr:String = ""
    var refreshToken : String = ""
    var tokensDetails   = LoginParamsAPIModel()
    
    var rolesDictionary = LoginParamsAPIModel()


    
// MARK: -  GET Request
    
    func requestGETURL(_ viewController : UIViewController, strURL:String,success:@escaping(_ _result:AnyObject)->Void,failure:@escaping(_ _error:String) -> Void) {
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        if appDelegate.checkInternetConnectivity() == false
        {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
//            appDelegate.window?.makeToast(kNetworkStatusMessage, duration: kToastDuration, position: CSToastPositionBottom)
            
            Utilities.sharedInstance.alertWithOkButtonAction(vc: viewController, alertTitle: "app.Warning".localize(), messege: "app.Pleasecheckyourinternetconnection!".localize(), clickAction: {
                
                
            })
            return
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true

        
        viewController.showHud(SVHUDMESSAGE)
        
        let request = NSMutableURLRequest(url: NSURL(string: strURL)! as URL)
        request.addValue(content_type, forHTTPHeaderField: "Content-Type")
        request.addValue(content_type, forHTTPHeaderField: "Accept")
        //// request.setValue(api_key, forHTTPHeaderField: "api_key")
//        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        request.setValue("Keep-Alive", forHTTPHeaderField: "Connection")
        request.httpMethod = "GET"
        
        let defaults = UserDefaults.standard
        
        if let authToken : String = defaults.value(forKey: KAccessToken) as? String {
            
           request.setValue("Bearer" + " " + authToken,forHTTPHeaderField: "Authorization")
            
            
        
//        request.setValue(KTokenType + " " + KAccessToken,forHTTPHeaderField: "Authorization")
        
//        let task = URLSession.shared.dataTask(with:strURL as URL){(data,response,error) in
//            DispatchQueue.main.async(){
        
        let task = URLSession.shared.dataTask(with:request as URLRequest){(data,response,error) in
            DispatchQueue.main.async(){
                
                
                viewController.hideHUD()

                let statusCode = (response as! HTTPURLResponse).statusCode
                print("statusCode:\(statusCode)")
                
                if statusCode == 401 {
                    
                    viewController.hideHUD()
                    
                    failure("unAuthorized")
                    
//                    Utilities.sharedInstance.alertWithOkButtonAction(vc: viewController, alertTitle: "app.Alert".localize(), messege: "app.YoursessionhasbeentimedoutPleaseloginagain".localize(), clickAction: {
//                    
//                    let LoginNav : UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginNav") as! UINavigationController
//                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                    appDelegate.window?.rootViewController = LoginNav
//                        
//                    })
                }
                 else if error != nil {
                    
                    viewController.hideHUD()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
//                    failure(error! as NSError)
                    
                    Utilities.sharedInstance.alertWithOkButtonAction(vc: viewController, alertTitle: "app.Warning".localize(), messege: kRequestTimedOutMessage, clickAction: {
                        
                        
                    })
                    return
                    
                }
                    
                else {
                    
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                    do{
                        viewController.hideHUD()
                        let parsedData = try JSONSerialization.jsonObject(with:data!,options:.mutableContainers) as![String:Any]
                        print(parsedData)
                        success(parsedData as AnyObject)
                    }
                    catch{
                        print("error=\(error)")
                        viewController.hideHUD()
                        Utilities.sharedInstance.alertWithOkButtonAction(vc: viewController, alertTitle: "app.Warning".localize(), messege: kRequestTimedOutMessage, clickAction: {
                            
                            
                        })
                        return
                    }
                    
                }
                
                
            }
        }
        task.resume()
    }
        
        
    }
    
    
    
    
    
    
  func requestDELETEURL(_ viewController : UIViewController, strURL:String,success:@escaping(_ _result:AnyObject)->Void,failure:@escaping(_ _error:String) -> Void) {
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        if appDelegate.checkInternetConnectivity() == false
        {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            //            appDelegate.window?.makeToast(kNetworkStatusMessage, duration: kToastDuration, position: CSToastPositionBottom)
            
            Utilities.sharedInstance.alertWithOkButtonAction(vc: viewController, alertTitle: "app.Warning".localize(), messege: "app.Pleasecheckyourinternetconnection!".localize(), clickAction: {
                
                
            })
            return
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        //        MBProgressHUD.hide(for:appDelegate.window,animated:true)
        //        MBProgressHUD.showAdded(to:appDelegate.window,animated:true)
        
        viewController.showHud(SVHUDMESSAGE)
        
        
        let request = NSMutableURLRequest(url: NSURL(string: strURL)! as URL)
        request.addValue(content_type, forHTTPHeaderField: "Content-Type")
        request.addValue(content_type, forHTTPHeaderField: "Accept")
        //// request.setValue(api_key, forHTTPHeaderField: "api_key")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("Keep-Alive", forHTTPHeaderField: "Connection")
        request.httpMethod = "DELETE"
        
//        let task = URLSession.shared.dataTask(with: request as URLRequest)
//        {(data, response, error) in
    
    let defaults = UserDefaults.standard
    
    if let authToken = defaults.string(forKey: KAccessToken) {
        
        request.setValue("Bearer" + " " + authToken,forHTTPHeaderField: "Authorization")
    
        
        let task = URLSession.shared.dataTask(with:request as URLRequest){(data,response,error) in
            DispatchQueue.main.async(){
                //                MBProgressHUD.hide(for:appDelegate.window,animated:true)
                viewController.hideHUD()
                
                let statusCode = (response as! HTTPURLResponse).statusCode
                
                print("statusCode:\(statusCode)")
                
                if statusCode == 401 {
                    
                    viewController.hideHUD()
                    
                    failure("unAuthorized")
//                    Utilities.sharedInstance.alertWithOkButtonAction(vc: viewController, alertTitle: "app.Alert".localize(), messege: "app.YoursessionhasbeentimedoutPleaseloginagain".localize(), clickAction: {
//                    
//                    let LoginNav : UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginNav") as! UINavigationController
//                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                        
//                    appDelegate.window?.rootViewController = LoginNav
//                        
//                    })
                }
                else if error != nil
                {
                    viewController.hideHUD()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
//                    failure(error! as NSError)
                    
                    Utilities.sharedInstance.alertWithOkButtonAction(vc: viewController, alertTitle: "app.Warning".localize(), messege: kRequestTimedOutMessage, clickAction: {
                        
                        
                    })
                    return
                    
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                    do{
                        viewController.hideHUD()
                        let parsedData = try JSONSerialization.jsonObject(with:data!,options:.mutableContainers) as![String:Any]
                        print(parsedData)
                        success(parsedData as AnyObject)
                    }
                    catch{
                        print("error=\(error)")
                        viewController.hideHUD()
                        Utilities.sharedInstance.alertWithOkButtonAction(vc: viewController, alertTitle: "app.Warning".localize(), messege: kRequestTimedOutMessage, clickAction: {
                            
                            
                        })
                        return
                    }
                    
                }
                
                
            }
        }
        task.resume()
    }
    }
    
    
    func requestPOSTURL(_ viewController : UIViewController, strURL:NSString,postParams:NSDictionary,postHeaders:NSDictionary,successHandler:@escaping(_ _result:Any)->Void,failureHandler:@escaping (_ _error:String)->Void) -> Void {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        if appDelegate.checkInternetConnectivity() == false {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false

// appDelegate.window?.makeToast(kNetworkStatusMessage,duration:kToastDuration,position:CSToastPositionBottom)
            
            Utilities.sharedInstance.alertWithOkButtonAction(vc: viewController, alertTitle: "app.Warning".localize(), messege: "app.Pleasecheckyourinternetconnection!".localize(), clickAction: {
                
                
            })
            return
        }
//        MBProgressHUD.hide(for:appDelegate.window,animated:true)
//        MBProgressHUD.showAdded(to:appDelegate.window,animated:true)
        viewController.showHud(SVHUDMESSAGE)
        
        let urlStr:NSString = strURL.addingPercentEscapes(using:String.Encoding.utf8.rawValue)! as NSString
        let url: NSURL = NSURL(string: urlStr as String)!
        
        let request:NSMutableURLRequest = NSMutableURLRequest(url:url as URL)
        request.httpMethod = "POST"
        request.addValue("application/json",forHTTPHeaderField:"Content-Type")
        request.addValue("application/json",forHTTPHeaderField:"Accept")
        
//        if postHeaders["Authorization"] != nil  {
//            request.addValue(postHeaders[KAccessToken] as! String, forHTTPHeaderField: KAccessToken)
//            request.addValue(postHeaders[KTokenType + " " + KAccessToken] as! String, forHTTPHeaderField: "Authorization")
//            
//            request.setValue(KTokenType + " " + KAccessToken,forHTTPHeaderField: "Authorization")
//            
//        }
            let defaults = UserDefaults.standard
        
        if let authToken = defaults.string(forKey: KAccessToken) {
            
            request.setValue("Bearer" + " " + authToken,forHTTPHeaderField: "Authorization")
        
        do {
            let data = try! JSONSerialization.data(withJSONObject:postParams, options:.prettyPrinted)
            let dataString = String(data: data, encoding: String.Encoding.utf8)!
            
            let headerData = try! JSONSerialization.data(withJSONObject:postHeaders, options:.prettyPrinted)
            let headerDataString = String(data: headerData, encoding: String.Encoding.utf8)!
            
            print("Request Url :\(url)")
            print("Request Header Data :\(headerDataString)")
            print("Request Data : \(dataString)")
            
            request.httpBody = data
            // do other stuff on success
            
        }
        catch {
            DispatchQueue.main.async(){
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
//                MBProgressHUD.hide(for: appDelegate.window, animated: true)
                viewController.hideHUD()
                print("JSON serialization failed:  \(error)")
                
                Utilities.sharedInstance.alertWithOkButtonAction(vc: viewController, alertTitle: "app.Warning".localize(), messege: error.localizedDescription, clickAction: {
                    
                    
                })
            }
        }
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {(data, response, error) in
            
            DispatchQueue.main.async(){
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
//                MBProgressHUD.hide(for: appDelegate.window, animated: true)
                viewController.hideHUD()
                
                let statusCode = (response as! HTTPURLResponse).statusCode
                
                
                print("statusCode:\(statusCode)")
                
                if statusCode == 401 {
                    
                    failureHandler("unAuthorized")
                    
                    
                    
//                    let LoginNav : UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginNav") as! UINavigationController
//                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                    appDelegate.window?.rootViewController = LoginNav
                }
               else if error != nil
                {
                    print("error=\(String(describing: error))")
//                    appDelegate.window?.makeToast(kRequestTimedOutMessage, duration:kToastDuration , position:CSToastPositionCenter)
                    
                    Utilities.sharedInstance.alertWithOkButtonAction(vc: viewController, alertTitle: "app.Warning".localize(), messege: kRequestTimedOutMessage, clickAction: {
                        
                        
                    })
                    return
                    
                }
                
                else {
      
                    
                do {
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options:.mutableContainers) as! [String:Any]
                    print(parsedData)
                    successHandler(parsedData as AnyObject)
                    
               
                    
                } catch let error as NSError {
                    
                    print("error=\(error)")
                    
                    Utilities.sharedInstance.alertWithOkButtonAction(vc: viewController, alertTitle: "app.Warning".localize(), messege: kRequestTimedOutMessage, clickAction: {
                        
                        
                    })
                    return
                }
            }
            }
        }
        task.resume()
        }
    }
    
    

    
//    func refreshTokenForLogin(_ viewController : UIViewController, successHandler:@escaping(_ _result:Any)->Void,failureHandler:(_ _error:String)->Void) -> Void {
//        appDelegate = UIApplication.shared.delegate as! AppDelegate
//        
//      
//        
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//        if appDelegate.checkInternetConnectivity() == false {
//            UIApplication.shared.isNetworkActivityIndicatorVisible = false
//            
//            
//            
//            // appDelegate.window?.makeToast(kNetworkStatusMessage,duration:kToastDuration,position:CSToastPositionBottom)
//            
//            Utilities.sharedInstance.alertWithOkButtonAction(vc: viewController, alertTitle: "app.Warning".localize(), messege: "app.Pleasecheckyourinternetconnection!".localize(), clickAction: {
//                
//                
//            })
//            return
//        }
//        //        MBProgressHUD.hide(for:appDelegate.window,animated:true)
//        //        MBProgressHUD.showAdded(to:appDelegate.window,animated:true)
//        viewController.showHud(SVHUDMESSAGE)
//        
//        let refreshToken : String = UserDefaults.standard.value(forKey: "ArefreshToken") as! String
//        
//      print(refreshToken)
//        
//        let postParams = ["clientId": "payzan.mobile",
//                          "clientSecret": "PayZan!@",
//                          "RefreshToken": refreshToken ] as Dictionary<String, AnyObject>
//        let strURL = REFRESHTOKEN_API
//        
//        let postHeaders = ["":"","":""] as NSDictionary
//        
//        let urlStr:NSString = strURL.addingPercentEscapes(using:String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as NSString
//        let url: NSURL = NSURL(string: urlStr as String)!
//        
//        let request:NSMutableURLRequest = NSMutableURLRequest(url:url as URL)
//        request.httpMethod = "POST"
//        request.addValue("application/json",forHTTPHeaderField:"Content-Type")
//        request.addValue("application/json",forHTTPHeaderField:"Accept")
//        
//        //        if postHeaders["Authorization"] != nil  {
//        //            request.addValue(postHeaders[KAccessToken] as! String, forHTTPHeaderField: KAccessToken)
//        //            request.addValue(postHeaders[KTokenType + " " + KAccessToken] as! String, forHTTPHeaderField: "Authorization")
//        //
//        //            request.setValue(KTokenType + " " + KAccessToken,forHTTPHeaderField: "Authorization")
//        //
//        //        }
//        let defaults = UserDefaults.standard
//        
//        if let authToken = defaults.string(forKey: KAccessToken) {
//            
//            request.setValue("Bearer" + " " + authToken,forHTTPHeaderField: "Authorization")
//            
//            do {
//                viewController.hideHUD()
//                
//                let data = try! JSONSerialization.data(withJSONObject:postParams, options:.prettyPrinted)
//                let dataString = String(data: data, encoding: String.Encoding.utf8)!
//                
//                let headerData = try! JSONSerialization.data(withJSONObject:postHeaders, options:.prettyPrinted)
//                let headerDataString = String(data: headerData, encoding: String.Encoding.utf8)!
//                
//                print("Request Url :\(url)")
//                print("Request Header Data :\(headerDataString)")
//                print("Request Data : \(dataString)")
//                
//                request.httpBody = data
//                // do other stuff on success
//                
//            }
//            catch {
//                DispatchQueue.main.async(){
//                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
//                    //                MBProgressHUD.hide(for: appDelegate.window, animated: true)
//                    viewController.hideHUD()
//                    print("JSON serialization failed:  \(error)")
//                    
//                    Utilities.sharedInstance.alertWithOkButtonAction(vc: viewController, alertTitle: "app.Warning".localize(), messege: error.localizedDescription, clickAction: {
//                        
//                        
//                    })
//                }
//            }
//            
//            let task = URLSession.shared.dataTask(with: request as URLRequest) {(data, response, error) in
//                
//                DispatchQueue.main.async(){
//                    
//                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
//                    
//                    //                MBProgressHUD.hide(for: appDelegate.window, animated: true)
//                    viewController.hideHUD()
//                    
//                    let statusCode = (response as! HTTPURLResponse).statusCode
//                    print("statusCode:\(statusCode)")
//                    
//                    if statusCode == 401 {
//                        
//                        viewController.hideHUD()
//                        let LoginNav : UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginNav") as! UINavigationController
//                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                        appDelegate.window?.rootViewController = LoginNav
//                    }
//                    else if error != nil
//                    {
//                        viewController.hideHUD()
//                        print("error=\(String(describing: error))")
//                        //                    appDelegate.window?.makeToast(kRequestTimedOutMessage, duration:kToastDuration , position:CSToastPositionCenter)
//                        
//                        Utilities.sharedInstance.alertWithOkButtonAction(vc: viewController, alertTitle: "app.Warning".localize(), messege: kRequestTimedOutMessage, clickAction: {
//                            
//                            
//                        })
//                        return
//                        
//                    }
//                        
//                    else {
//                        
//                        
//                        do {
//                            viewController.hideHUD()
//                            let parsedData = try JSONSerialization.jsonObject(with: data!, options:.mutableContainers) as! [String:Any]
//                            print(parsedData)
//                            successHandler(parsedData as AnyObject)
//            
//                            
//                            let respVO:RefreshTokenVo = Mapper().map(JSONObject: result)!
//                            
//                            let isSuccess = respVO.IsSuccess
//                            
//                            if isSuccess == true {
//                                
//                                let refreshTokenID = respVO.Result?.RefreshToken
//                                
//                                let accessToken = respVO.Result?.AccessToken
//                                
//                               
//                                
//                                 UserDefaults.standard.set(refreshTokenID, forKey: ArefreshToken)
//                                 UserDefaults.standard.set(accessToken, forKey: KAccessToken)
//                               
//                                
//                                UserDefaults.standard.synchronize()
//                                
//                            
//                        
//                            }
//                            
//                        } catch let error as NSError {
//                            
//                            print("error=\(error)")
//                            viewController.hideHUD()
//                            Utilities.sharedInstance.alertWithOkButtonAction(vc: viewController, alertTitle: "app.Warning".localize(), messege: kRequestTimedOutMessage, clickAction: {
//                                
//                                
//                            })
//                            return
//                        }
//                    }
//                }
//            }
//            task.resume()
//        }
//    }
//    
// 

    func refreshTokenForLogin(_ viewController : UIViewController,successHandler:@escaping( _ result:Any)->Void,failureHandler:( _ error:NSError)->Void) -> Void {
        
        if(appDelegate.checkInternetConnectivity()){ 
            
            if let refreshToken : String = (UserDefaults.standard.value(forKey: ArefreshToken) as? String){
            
            let refreshParams = ["clientId"     : "payzan.mobile",
                                 "clientSecret" : "PayZan!@",
                                 "RefreshToken" : refreshToken] as NSDictionary
            
            print("refreshParams:\(refreshParams)")
            
            
            let dictHeaders = ["":"","":""] as NSDictionary
            
            //        let dictHeaders = [accessToken:UserDefaults.standard.value(forKey: accessToken)as! String,"":""] as NSDictionary
            
            serviceController.requestPOSTURL(viewController, strURL: REFRESHTOKEN_API as NSString, postParams: refreshParams, postHeaders: dictHeaders, successHandler:{(result) in
                DispatchQueue.main.async()
                    {
                        
                        print("result:\(result)")
                        
                        let respVO:RefreshTokenVo = Mapper().map(JSONObject: result)!
                        
                        let isSuccess = respVO.IsSuccess
                        
                        if isSuccess == true {
                            
                            let refreshTokenID = respVO.Result?.RefreshToken
                            
                            let accessTokenn = respVO.Result?.AccessToken
                            
                            let defaults = UserDefaults.standard
                            
                            defaults.set(accessTokenn, forKey: KAccessToken)
                            defaults.set (refreshTokenID, forKey: ArefreshToken)
                            
                            UserDefaults.standard.synchronize()
                            
                            print("refreshTokenID:\(String(describing: refreshTokenID))")
                            
                            successHandler("Test" as AnyObject)
                            
                        }
                        else {
                            
                        Utilities.sharedInstance.goToLoginScreen()
                            
//                            if(appDelegate.checkInternetConnectivity()){
//                                
//                                
//                                let userName = UserDefaults.standard.value(forKey: AuserName)
//                                let password = UserDefaults.standard.value(forKey: "password")
//                                
//                                let params = ["clientId"     : "payzan.mobile",
//                                              "clientSecret" : "PayZan!@",
//                                              "scope"        : "offline_access",
//                                              "userName"     :  userName,
//                                              "password"     :  "Abcd@123"] as Dictionary<String, AnyObject>
//                                
//                                print("parms:\(params)")
//                                
//                               APIModel().postLoginRequest(viewController, withUrl: LOGIN_API , parameters: params as Dictionary<String, AnyObject> , successBlock: { (json) in
//                                
//                                UserDefaults.standard.set(self.userDetailsDoictionary.userName, forKey: AuserName)
//                                UserDefaults.standard.set(self.accesTokenStr, forKey: KAccessToken)
//                                UserDefaults.standard.set(self.tokenTypeStr, forKey: KTokenType)
//                                UserDefaults.standard.set(self.userDetailsDoictionary.id, forKey: AId)
//                                UserDefaults.standard.set(self.userDetailsDoictionary.phoneNumber, forKey: AmobileNumber)
//                                UserDefaults.standard.set(self.userDetailsDoictionary.email, forKey: Aemail)
//                                UserDefaults.standard.set(self.refreshToken, forKey: ArefreshToken)
//                                
//                                UserDefaults.standard.set(self.userDetailsDoictionary.expiresIn, forKey: AExpiresIn)
//                                
//                                UserDefaults.standard.synchronize()
//                                }){
//                                    
//                                    (failureMessage) in
//                                    
//                                    Utilities.sharedInstance.alertWithOkButtonAction(vc: viewController, alertTitle: "app.Warning".localize(), messege: failureMessage, clickAction: {
//                                        
//                                    })
//                                    
//                                    //                    print("fail: \(failureMessage)")
//                                    
//                                }
//                                
//                                
//                                
//                                
//                                
//                                 }
//                            else {
//                                
//                                Utilities.sharedInstance.alertWithOkButtonAction(vc: viewController, alertTitle: "app.Warning".localize(), messege: "app.Pleasecheckyourinternetconnection!".localize(), clickAction: {
//                                    
//                                    
//                                })
//                                
//                            }
  
                         
                            
                            
                        }
                        
                }
            },
                                             
            failureHandler: {(error) in
                
                
              Utilities.sharedInstance.goToLoginScreen()
                
            })
            
            
            
            }
            
          else {

            Utilities.sharedInstance.alertWithOkButtonAction(vc: viewController, alertTitle: "app.Alert".localize(), messege: "app.Pleaseloginintoyourpayzanaccount".localize(), clickAction: {
                
                let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginNav") as! UINavigationController
               
               let appDelegate = UIApplication.shared.delegate as! AppDelegate
               
               appDelegate.window?.rootViewController = rootController
              
           })
            
            
            }
        }
            
    
            
        else {
            
            Utilities.sharedInstance.alertWithOkButtonAction(vc: viewController, alertTitle: "app.Alert".localize(), messege: "app.Pleasecheckyourinternetconnection!", clickAction: {
                
                
                
            })
            
        }
        
    }
    
    
    
    
    
    //MARK: -  Parsing Login Json data
    
    
   
    
}
