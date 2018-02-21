//
//  APIModel.swift
//  Agent Payzan
//
//  Created by Nani Mac on 10/10/17.
//  Copyright © 2017 Naveen. All rights reserved.
//

import UIKit
import SVProgressHUD


//var appDelegate = AppDelegate()

class APIModel: NSObject {
    
    static let sharedInstance = APIModel()
    
    let responseParser = ParsingModelClass.sharedInstance
    
    
    let content_type = "application/json; charset=utf-8"
    
    var reachability: Reachability?
    
    private func isConnectionEshtablished() -> Bool {
        
       reachability = Reachability.init()!
 
        let networkStatus: Int = reachability!.currentReachabilityStatus.hashValue
        setupReachability(hostName: "google.com", useClosures: true)
        return (networkStatus != 0)
    }
    
    func setupReachability(hostName: String?, useClosures: Bool) {
        
        let reachability = hostName == nil ? Reachability() : Reachability(hostname: hostName!)
        self.reachability = reachability
        
        if useClosures {
            reachability?.whenReachable = { reachability in
                DispatchQueue.main.async {
                    
                    print("Network is reachable")
                    // Reachable
                }
            }
            reachability?.whenUnreachable = { reachability in
                DispatchQueue.main.async {
                    
                    print("Network is not reachable")
                    // Non Reachable
                }
            }
        }
    }
    
// MARK: -  Post Request
    
    
    
    func postRequest(_ viewController : UIViewController, withUrl urlPath: String, parameters: Dictionary<String, Any>, successBlock: @escaping ( _ requestDataModel : Dictionary <String, Any>) -> Void, failureBlock: @escaping (_ failureMessage: String) -> Void)
    {
       
        if isConnectionEshtablished(){
            
        viewController.showHud(SVHUDMESSAGE)
            
            do {
                
                
                let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted)
                
                if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                    print(JSONString)
                    
                    if let jsonData1 = JSONString.data(using: String.Encoding.utf8, allowLossyConversion: false)
                    {
                        print(jsonData1)
                
                let request = NSMutableURLRequest(url: NSURL(string: urlPath)! as URL)
                request.addValue(content_type, forHTTPHeaderField: "Content-Type")
                request.addValue(content_type, forHTTPHeaderField: "Accept")
                //// request.setValue(api_key, forHTTPHeaderField: "api_key")
//              request.setValue("Keep-Alive", forHTTPHeaderField: "Connection")
                request.setValue("application/json", forHTTPHeaderField: "Accept")
                request.httpMethod = "POST"
                        
                let defaults = UserDefaults.standard
                        
            if let authToken = defaults.string(forKey: KAccessToken) {
                            
            request.setValue("Bearer" + " " + authToken,forHTTPHeaderField: "Authorization")
                
                request.httpBody = jsonData1
                
                let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
                    
                    if(response != nil){
                        
                        let statusCode = (response as! HTTPURLResponse).statusCode
                        print("statusCode:\(statusCode)")
                        
                        if statusCode == 401 {
                            
                            viewController.hideHUD()
                       failureBlock("unAuthorized")
//                            Utilities.sharedInstance.alertWithOkButtonAction(vc: viewController, alertTitle: "app.Alert".localize(), messege: "app.YoursessionhasbeentimedoutPleaseloginagain".localize(), clickAction: {
//                                
//                                let LoginNav : UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginNav") as! UINavigationController
//                                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                                appDelegate.window?.rootViewController = LoginNav
//                                
//                                return
//
//                            })
                           
                           
                        }

                        else {
                        do
                        {
                            
                            if let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers ) as? NSDictionary {
                                
                                if let isSuccess = json["IsSuccess"] as? Bool{
                                    
                                    if(isSuccess == true){
                                        DispatchQueue.main.async {
                                            
                                            print(json)
                                            
                                            successBlock(json as! Dictionary<String, AnyObject>)
                                            viewController.hideHUD()
                                        }
                                    }
                                    else if (isSuccess == false){
                                        
                                        if Utilities.sharedInstance.isObjectNull(json as AnyObject?) {
                                            
                                            if let failureMessage = json["EndUserMessage"] as? String{
                                                
                                                DispatchQueue.main.async {
                                                    failureBlock(failureMessage)
                                                    
                                                    //self.ShowError(viewController, message: statusMessage)
                                                }
                                            }
                                        }
                                        
                                        viewController.hideHUD()
                                    }
                                    
                                    else  {
                                        
                                        if Utilities.sharedInstance.isObjectNull(json as AnyObject?) {
                                            
                                            if let failureMessage = json["EndUserMessage"] as? String{
                                                
                                                DispatchQueue.main.async {
                                                    failureBlock(failureMessage)
                                                    
                                                    //self.ShowError(viewController, message: statusMessage)
                                                }
                                            }
                                        }
                                        
                                        viewController.hideHUD()
                                    }

                                }
                          }
                            
                        }
                        catch let catchError as NSError {
                            
                            DispatchQueue.main.async {
//                                failureBlock(catchError.localizedDescription)
                                
                                Utilities.sharedInstance.alertWithOkButtonAction(vc: viewController, alertTitle: "app.Warning".localize(), messege: "app.Servererror".localize(), clickAction: {
                                    
                                    
                                })
                                
                                print(catchError.localizedDescription)
                                viewController.hideHUD()
                                // self.ShowError(viewController, message: catchError.localizedDescription)
                            }
                        }
                        
                    }
                    }
                    else{
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(errorDescription)
                                
                                Utilities.sharedInstance.alertWithOkButtonAction(vc: viewController, alertTitle: "app.Alert".localize(), messege: "app.Therequesttimeout ".localize(), clickAction: {
                                    
                                })
                                
                                viewController.hideHUD()
                                //self.ShowError(viewController, message: errorDescription)
                            }
                        }
                    }
                    
                    
                    
                })
                task.resume()
                        }
        }
    }
            }
            catch {
                print("parsing error")
                viewController.hideHUD()
            }
  
    }
        
       else {
        
        Utilities.sharedInstance.alertWithOkButtonAction(vc: viewController, alertTitle: "app.Warning".localize(), messege: "app.PleaseCheckInternet".localize(), clickAction: {
            })
        }
    
    }
    

// MARK: - Get Request
    
    
    
    func getRequest(_ viewController : UIViewController, withUrl urlPath: String,successBlock: @escaping ( _ requestDataModel : Dictionary <String, AnyObject>) -> Void, failureBlock: @escaping (_ failureMessage: String) -> Void)
    {
        if isConnectionEshtablished() {
            
        viewController.showHud(SVHUDMESSAGE)
        
        let request = NSMutableURLRequest(url: NSURL(string: urlPath)! as URL)
        request.addValue(content_type, forHTTPHeaderField: "Content-Type")
        request.addValue(content_type, forHTTPHeaderField: "Accept")
        //// request.setValue(api_key, forHTTPHeaderField: "api_key")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("Keep-Alive", forHTTPHeaderField: "Connection")
        request.httpMethod = "GET"
            
            let defaults = UserDefaults.standard
        
    if let authToken = defaults.string(forKey: KAccessToken) {
                
    request.setValue("Bearer" + " " + authToken,forHTTPHeaderField: "Authorization")
                
       
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {(data, response, error) in
            
            if(response != nil){
            
//                if error != nil
//                {
//                    
//                    viewController.hideHUD()
//                    print("error=\(String(describing: error))")
//                    Utilities.sharedInstance.alertWithOkButtonAction(vc: viewController, alertTitle: "Alert", messege: "The request time out ", clickAction: {
//                        
//                    })
//                    
//                    return
//                    
//                }
                
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("statusCode:\(statusCode)")
                
                if statusCode == 401 {
                    
                    viewController.hideHUD()
                    
                   Utilities.sharedInstance.alertWithOkButtonAction(vc: viewController, alertTitle: "app.Alert".localize(), messege: "app.YoursessionhasbeentimedoutPleaseloginagain".localize(), clickAction: {
                    
                    let LoginNav : UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginNav") as! UINavigationController
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.window?.rootViewController = LoginNav
                    
                    return
                    
                    })
                }
               
                else {
               
            do
            {

                if let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers ) as? NSDictionary {

                    
                    if let isSucsess = json["IsSuccess"] as? Bool{
                    
                        if isSucsess == true {
                        
                            DispatchQueue.main.async {
                                
                                successBlock(json as! Dictionary<String, AnyObject>)
                                viewController.hideHUD()
                                
                            }

                        }
                    
                    else if isSucsess == false{

                        if Utilities.sharedInstance.isObjectNull(json as AnyObject?) {
                            
                            if let failureMessage = json["EndUserMessage"] as? String{
                                
                                DispatchQueue.main.async {
//                                    failureBlock(failureMessage)
                                    //self.ShowError(viewController, message: statusMessage)
                                    
                                    Utilities.sharedInstance.alertWithOkButtonAction(vc: viewController, alertTitle: "app.Warning".localize(), messege: failureMessage, clickAction: {
                                        
                                        
                                    })
                                }
                            }
                        }
                      
                            viewController.hideHUD()
                    }
                    
                }
                
                    
                }
                
            } catch let catchError as NSError {
                
                DispatchQueue.main.async {
//                    failureBlock(catchError.localizedDescription)
                    
                    Utilities.sharedInstance.alertWithOkButtonAction(vc: viewController, alertTitle: "Warning", messege: "Server error", clickAction: {
                        
                        
                    })
                    
                    print(catchError.localizedDescription)
                   // self.ShowError(viewController, message: catchError.localizedDescription)
                }
                
                              viewController.hideHUD()
            }
            }
            
        }
            else {
            
            if let errorDescription = error?.localizedDescription {
                
                DispatchQueue.main.async {
                    failureBlock(errorDescription)
                    Utilities.sharedInstance.alertWithOkButtonAction(vc: viewController, alertTitle: "app.Alert".localize(), messege: "app.Therequesttimeout".localize(), clickAction: {
                        
                    })
                    
                    return
                    //self.ShowError(viewController, message: errorDescription)
                }
                
                viewController.hideHUD()
                
            }
        }
            
           
        
        
        
    }
            
    task.resume()
        }
}
    else {
        
            Utilities.sharedInstance.alertWithOkButtonAction(vc: viewController, alertTitle: "app.Warning".localize(), messege: "app.PleaseCheckInternet".localize(), clickAction: {
            })
            

        }
    
    
    }
    
    
    func postLoginRequest(_ viewController : UIViewController, withUrl urlPath: String, parameters: Dictionary<String, Any>, successBlock: @escaping ( _ requestDataModel : Dictionary <String, Any>) -> Void, failureBlock: @escaping (_ failureMessage: String) -> Void)
    {
        
        if isConnectionEshtablished(){
            
            viewController.showHud(SVHUDMESSAGE)
            
            do {
                
                
                let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted)
                
                if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                    print(JSONString)
                    
                    if let jsonData1 = JSONString.data(using: String.Encoding.utf8, allowLossyConversion: false)
                    {
                        print(jsonData1)
                        
                        let request = NSMutableURLRequest(url: NSURL(string: urlPath)! as URL)
                        request.addValue(content_type, forHTTPHeaderField: "Content-Type")
                        request.addValue(content_type, forHTTPHeaderField: "Accept")
                        //// request.setValue(api_key, forHTTPHeaderField: "api_key")
                        //              request.setValue("Keep-Alive", forHTTPHeaderField: "Connection")
                        request.setValue("application/json", forHTTPHeaderField: "Accept")
                        request.httpMethod = "POST"
                        
                        request.httpBody = jsonData1
                        
                        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
                            
                            if(response != nil){
                                do
                                {
                                    
                                    if let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers ) as? NSDictionary {
                                        
                                        if let isSuccess = json["IsSuccess"] as? Bool{
                                            
                                            if(isSuccess == true){
                                                DispatchQueue.main.async {
                                                    
                                                    print(json)
                                                    
                                                    successBlock(json as! Dictionary<String, AnyObject>)
                                                    viewController.hideHUD()
                                                }
                                            }
                                            else if (isSuccess == false){
                                                
                                                if Utilities.sharedInstance.isObjectNull(json as AnyObject?) {
                                                    
                                                    if let failureMessage = json["EndUserMessage"] as? String{
                                                        
                                                        DispatchQueue.main.async {
                                                            failureBlock(failureMessage)
                                                            
                                                            //self.ShowError(viewController, message: statusMessage)
                                                        }
                                                    }
                                                }
                                                
                                                viewController.hideHUD()
                                            }
                                                
                                            else  {
                                                
                                                if Utilities.sharedInstance.isObjectNull(json as AnyObject?) {
                                                    
                                                    if let failureMessage = json["EndUserMessage"] as? String{
                                                        
                                                        DispatchQueue.main.async {
                                                            failureBlock(failureMessage)
                                                            
                                                            //self.ShowError(viewController, message: statusMessage)
                                                        }
                                                    }
                                                }
                                                
                                                viewController.hideHUD()
                                            }
                                            
                                        }
                                    }
                                    
                                }
                                catch let catchError as NSError {
                                    
                                    DispatchQueue.main.async {
                                        //                                failureBlock(catchError.localizedDescription)
                                        
                                        Utilities.sharedInstance.alertWithOkButtonAction(vc: viewController, alertTitle: "app.Warning".localize(), messege: "app.Servererror".localize(), clickAction: {
                                            
                                            
                                        })
                                        
                                        print(catchError.localizedDescription)
                                        viewController.hideHUD()
                                        // self.ShowError(viewController, message: catchError.localizedDescription)
                                    }
                                }
                                
                                
                            }
                            else{
                                
                                
                                if let errorDescription = error?.localizedDescription {
                                    
                                    DispatchQueue.main.async {
                                        failureBlock(errorDescription)
                                        
                                        Utilities.sharedInstance.alertWithOkButtonAction(vc: viewController, alertTitle: "app.Alert".localize(), messege: "app.Therequesttimeout".localize(), clickAction: {
                                            
                                        })
                                        
                                        viewController.hideHUD()
                                        //self.ShowError(viewController, message: errorDescription)
                                    }
                                }
                            }
                            
                            
                            
                        })
                        task.resume()
                        
                    }
                }
            }
            catch {
                print("parsing error")
                viewController.hideHUD()
            }
            
        }
            
        else {
            
            Utilities.sharedInstance.alertWithOkButtonAction(vc: viewController, alertTitle: "app.Warning".localize(), messege: "app.PleaseCheckInternet".localize(), clickAction: {
            })
        }
        
    }

}


extension UIViewController {
    
    func showHud(_ message: String) {
        SVProgressHUD.show(withStatus: message)
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setBackgroundColor(UIColor.lightGray)
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func hideHUD() {
        SVProgressHUD.dismiss()
        UIApplication.shared.endIgnoringInteractionEvents()
        
    }
    
}
    

   


