//
//  NetworkServiceHandler.swift
//  Networking
//
//  Created by Sateesh Y on 30/11/16.
//  Copyright © 2016 Sateesh Y. All rights reserved.
//

import UIKit
//import AFNetworking
//import SVProgressHUD

class NetworkServiceHandler: NSObject {
    
    
    /*
    
    static let sharedInstance = NetworkServiceHandler()
    let responseParser = NetworkResponseParser.sharedInstance
    var reachability: Reachability?
    var authorizationHeaderKey = "Authorization"
    
    //MARK: - AFNetworking Manager
    private func isConnectionEshtablished() -> Bool {
        
        reachability = reachability.init()!
        let networkStatus: Int = reachability!.currentReachabilityStatus.hashValue
        setupReachability(hostName: "google.com", useClosures: true)
        return (networkStatus != 0)
    }
    
    func setupReachability(hostName: String?, useClosures: Bool) {
        
        let reachability = hostName == nil ? Reachability() : self.reachability(hostname: hostName!)
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
    
    private func networkSharedInstance(_ urlString : String) -> NSMutableURLRequest? {
        
        if isConnectionEshtablished() {
            
            let tokenType = Utilities.getTokenType()
            let accessToken = Utilities.getAccessToken()
            
            let request = NSMutableURLRequest(url: NSURL(string: urlString)! as URL)
            
            request.timeoutInterval = kTimeOutInterval
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue(tokenType + " " + accessToken,forHTTPHeaderField: "Authorization")
            
            return request
            
        } else {
            
            // Show Network Error
            ShowNetworkError()
        }
        
        return nil
    }
    
    func reachabilityChanged(note: NSNotification) {
        
        let reachability = note.object as! Reachability
        
        if reachability.isReachable {
            if reachability.isReachableViaWiFi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
        } else {
            print("Network not reachable")
        }
    }
    
    
    //MARK: - -----------------------------------------
    //MARK:   >>>>>>>>>>> PHASE I <<<<<<<<<<<<
    //MARK:   -----------------------------------------
    
    //MARK: - User Login API
    
    
    
    
    
    func loginInWith(username: String, password: String, viewController: UIViewController, successBlock: @escaping (_ loginModel : LoginModel) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
        
        if isConnectionEshtablished() {
            
            viewController.showHud(kLoading)
            
            let request = NSMutableURLRequest(url: NSURL(string: BASE_SIGNIN_URL)! as URL)
            request.timeoutInterval = kTimeOutInterval
            request.httpMethod = "POST"
            request.addValue("text/html", forHTTPHeaderField: "Content-Type")
            request.addValue("text/html", forHTTPHeaderField: "Accept")
            
            let modelName = UIDevice.current.modelName
            
            var deviceID = ""
            
            if let deviceid = UserDefaults.standard.value(forKey: kDeviceID){
                deviceID = deviceid as! String
            }
            
            let systemVersion = UIDevice.current.systemVersion
            
            let httpBody = "grant_type=password&username=" + username + "&password=" + password + "&device_id=" + deviceID + "&device_name=" + modelName + "&device_os=iOS" + systemVersion
            
            request.httpBody = httpBody.data(using: String.Encoding.utf8)
            let session = URLSession.shared
            
            let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
                
                
                
                guard error == nil else {
                   
                    
                    if let errorDescription = error?.localizedDescription {
                        
                        DispatchQueue.main.async {
                             failureBlock(true)
                            self.ShowError(viewController, message: errorDescription)
                        }
                    }
                    return
                }
                
                guard let data = data else {
                    return
                }
                
                // Checking here Response
                if response != nil {
                    
                    viewController.hideHUD()
                    
                    
                    do {
                        //create json object from data
                        
                        if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                            DispatchQueue.main.async {
                                let loginModel = NetworkResponseParser.sharedInstance.parseLoginResponse(json)
                                
                                if loginModel.error != "" {
                                    
                                    failureBlock(true)
                                    self.ShowError(viewController, message: loginModel.errorDescription)
                                    
                                } else {
                                    
                                    successBlock(loginModel)
                                }
                            }
                            
                            
                        }
                        
                    } catch let catchError as NSError {
                        
                        DispatchQueue.main.async {
                            failureBlock(true)
                            self.ShowError(viewController, message: catchError.localizedDescription)
                        }
                    }
                    
                    
                }else{
                    
                    
                    
                    if let errorDescription = error?.localizedDescription {
                        
                        DispatchQueue.main.async {
                            failureBlock(true)
                            self.ShowError(viewController, message: errorDescription)
                        }
                    }
                }
                
            })
            
            task.resume()
            
            
        } else {
            
            ShowError()
        }
    }
    
    
    
    //MARK: - POST API
    
    func postRequest(_ viewController: UIViewController,url : String, parameters: Dictionary<String,Any>, successBlock: @escaping (_ message: String , _ count : Int) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
        
        if isConnectionEshtablished() {
            
            do {
                
                viewController.showHud(kLoading)
                
                let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                
                // create post request
                let endpoint: String = BASE_URL + url
                
                let session = URLSession.shared
                
                let request = networkSharedInstance(endpoint)
                
                request?.httpMethod = "POST"
                
                request?.httpBody = jsonData
                
                let task = session.dataTask(with: request! as URLRequest, completionHandler: { data, response, error in
                    
                    viewController.hideHUD()
                    
                    guard error == nil else {
                       
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                 failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                        return
                    }
                    
                    guard let data = data else {
                        return
                    }
                    
                    
                    // Checking here Response
                    if response != nil {
                        
                        viewController.hideHUD()
                        
                        let statusCode = (response as! HTTPURLResponse).statusCode
                        
                        
                        // Checking here Response Status
                        
                        do {
                            
                            //create json object from data
                            
                            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                                
                                if 200...299 ~= statusCode {
                                    
                                    DispatchQueue.main.async {
                                        
                                        let status = NetworkResponseParser.sharedInstance.parseforgotPasswordResponse(object: json)
                                        
                                        var totalCount = 0
                                        
                                        if let countTotalString = json["data"] as? String{
                                           
                                            if let total = Int(countTotalString){
                                                totalCount = total
                                            }
                                        }
                                        
                                        successBlock(status,totalCount)
                                    }
                                }else if 401 == statusCode {
                                    DispatchQueue.main.async {
                                        self.moveToHomeScreen(kUnauthorizedError)
                                    }
                                }else{
                                    
                                    
                                    
                                    if Utilities.sharedInstance.isObjectNull(json as AnyObject?) {
                                        
                                        if let statusMessage = json["message"] as? String{
                                            
                                            DispatchQueue.main.async {
                                                failureBlock(true)
                                                self.ShowError(viewController, message: statusMessage)
                                            }
                                        }
                                    }
                                    
                                }
                                
                                
                            }
                            
                        } catch let catchError as NSError {
                           
                            DispatchQueue.main.async {
                                 failureBlock(true)
                                self.ShowError(viewController, message: catchError.localizedDescription)
                            }
                        }
                        
                        
                    }else{
                        
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                    }
                    
                    
                    
                })
                task.resume()
            } catch {
                print("parsing error")
            }
        }else {
            
            ShowError()
        }
    }
    // GetCategories Menu
    
    func getItemCategories(_ viewController: UIViewController, successBlock: @escaping (_ categories : Array<CategoriesModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
        
        if isConnectionEshtablished() {
            
            viewController.showHud(kLoading)
            var userId = ""
            let credentials = Utilities.getUserNameAndPasswordFromLocalStorage()
            if let userName = credentials.userName {
                userId = userName
            }
            
            
            do {
                
                // create post request
                let endpoint: String = BASE_URL + API_GET_CATEGORIES_MENU + "/" + userId
                
                let session = URLSession.shared
                
                let request = networkSharedInstance(endpoint)
                
                request?.httpMethod = "GET"
                
                
                let task = session.dataTask(with: request! as URLRequest, completionHandler: { data, response, error in
                    
                    
                    viewController.hideHUD()
                    
                    guard error == nil else {
                        
                       
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                        return
                    }
                    
                    
                    guard let data = data else {
                        return
                    }
                    
                    // Checking here Response
                    if response != nil {
                        
                        viewController.hideHUD()
                        
                        let statusCode = (response as! HTTPURLResponse).statusCode
                        
                        
                        do {
                            //create json object from data
                            
                            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                                
                                
                                
                                
                                if 200...299 ~= statusCode {
                                    
                                    DispatchQueue.main.async {
                                        
                                        let categories = NetworkResponseParser.sharedInstance.parseCategories(object: json as AnyObject)
                                        successBlock(categories)
                                    }
                                    
                                }else if 401 == statusCode {
                                    DispatchQueue.main.async {
                                        self.moveToHomeScreen(kUnauthorizedError)
                                    }
                                } else {
                                    
                                  
                                    if Utilities.sharedInstance.isObjectNull(json as AnyObject?) {
                                        
                                        if let statusMessage = json["message"] as? String{
                                            
                                            DispatchQueue.main.async {
                                                  failureBlock(true)
                                                self.ShowError(viewController, message: statusMessage)
                                            }
                                        }
                                    }
                                    
                                }
                                
                                
                                
                            }
                            
                        } catch let catchError as NSError {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: catchError.localizedDescription)
                            }
                        }
                        
                        
                    }else{
                        
                       
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                 failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                    }
                    
                    
                    
                    
                })
                task.resume()
            }
        }else {
            
            ShowError()
        }
    }
    
    func getMoreAboutGroup(_ viewController: UIViewController,url : String, parameters: Dictionary<String, Any>, successBlock: @escaping (_ itemGroups: Array<ItemDetailsModel>, _ pageInfo : Dictionary<String,Any>,_ totalOrders : Array<TotalOrdersModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
        
        if isConnectionEshtablished() {
            
            do {
                
                viewController.showHud(kLoading)
                
                let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                
                // create post request
                let endpoint: String = BASE_URL + url
                
                let session = URLSession.shared
                
                let request = networkSharedInstance(endpoint)
                
                request?.httpMethod = "POST"
                
                request?.httpBody = jsonData
                
                let task = session.dataTask(with: request! as URLRequest, completionHandler: { data, response, error in
                    
                    viewController.hideHUD()
                    
                    guard error == nil else {
                       
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                 failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                        return
                    }
                    
                    guard let data = data else {
                        return
                    }
                    
                    
                    
                    // Checking here Response
                    if response != nil {
                        
                        viewController.hideHUD()
                        
                        let statusCode = (response as! HTTPURLResponse).statusCode
                        
                        
                        do {
                            //create json object from data
                            
                            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                                
                                
                                if 200...299 ~= statusCode {
                                    
                                    DispatchQueue.main.async {
                                        
                                        let itemDetailsArray = NetworkResponseParser.sharedInstance.parseGroup(object: json as AnyObject?)
                                        
                                        let totalDetailsArray = NetworkResponseParser.sharedInstance.parseTotalOrderDetails(object: json as AnyObject?)
                                      
                                        var params = Dictionary<String,Any>()
                                        if let totalPages = json["totalPages"] as? Int{
                                            params.updateValue(totalPages, forKey: "totalPages")
                                        }
                                        if let totalPages = json["pageIndex"] as? Int{
                                            params.updateValue(totalPages, forKey: "pageIndex")
                                        }
                                        if let totalPages = json["totalRecords"] as? Int{
                                            params.updateValue(totalPages, forKey: "totalRecords")
                                        }
                                        if let statusMessage = json["statusMessage"] as? String{
                                            params.updateValue(statusMessage, forKey: "statusMessage")
                                        }
                                        successBlock(itemDetailsArray,params,totalDetailsArray)
                                    }
                                    
                                }else if 401 == statusCode {
                                    DispatchQueue.main.async {
                                        self.moveToHomeScreen(kUnauthorizedError)
                                    }
                                } else {
                                    
                                    
                                    if Utilities.sharedInstance.isObjectNull(json as AnyObject?) {
                                        
                                        if let statusMessage = json["message"] as? String{
                                            
                                            DispatchQueue.main.async {
                                                failureBlock(true)
                                                self.ShowError(viewController, message: statusMessage)
                                            }
                                        }
                                    }
                                    
                                }
                                
                                
                                
                            }
                            
                        } catch let catchError as NSError {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: catchError.localizedDescription)
                            }
                        }
                        
                        
                    }else{
                        
                       
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                    }
                    
                })
                
                task.resume()
            } catch {
                print("parsing error")
            }
        }else {
            
            ShowError()
        }
    }
    func getContactInformation(_ viewController: UIViewController, successBlock: @escaping (_ categories : Array<CustomerContactsModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
        
        if isConnectionEshtablished() {
            
            viewController.showHud(kLoading)
            var userId = ""
            let credentials = Utilities.getUserNameAndPasswordFromLocalStorage()
            if let userName = credentials.userName {
                userId = userName
            }
            
            
            do {
                
                // create post request
                let endpoint: String = BASE_URL + API_GETCUSTOMER_CONTACTS_CUSTOMER_NUMBER + "/" + userId
                
                let session = URLSession.shared
                
                let request = networkSharedInstance(endpoint)
                
                request?.httpMethod = "GET"
                
                
                let task = session.dataTask(with: request! as URLRequest, completionHandler: { data, response, error in
                    
                    
                    viewController.hideHUD()
                    
                    guard error == nil else {
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                        return
                    }
                    
                    
                    guard let data = data else {
                        return
                    }
                    
                    // Checking here Response
                    if response != nil {
                        
                        viewController.hideHUD()
                        
                        let statusCode = (response as! HTTPURLResponse).statusCode
                        
                        
                        do {
                            //create json object from data
                            
                            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                                
                                
                                
                                
                                if 200...299 ~= statusCode {
                                    
                                    DispatchQueue.main.async {
                                        
                                        let contactsDetails = NetworkResponseParser.sharedInstance.parseContactsDetails(object: json as AnyObject)
                                        successBlock(contactsDetails)
                                    }
                                    
                                }else if 401 == statusCode {
                                    DispatchQueue.main.async {
                                        self.moveToHomeScreen(kUnauthorizedError)
                                    }
                                } else {
                                    
                                    
                                    if Utilities.sharedInstance.isObjectNull(json as AnyObject?) {
                                        
                                        if let statusMessage = json["message"] as? String{
                                            
                                            DispatchQueue.main.async {
                                                failureBlock(true)
                                                self.ShowError(viewController, message: statusMessage)
                                            }
                                        }
                                    }
                                    
                                }
                                
                                
                                
                            }
                            
                        } catch let catchError as NSError {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: catchError.localizedDescription)
                            }
                        }
                        
                        
                    }else{
                        
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                    }
                    
                    
                    
                    
                })
                task.resume()
            }
        }else {
            
            ShowError()
        }
    }
    
    
    func getSimilarItemDetails(_ viewController: UIViewController,url : String, parameters: Dictionary<String, Any>, successBlock: @escaping (_ itemGroups: Array<SimilarItemModel>, _ pageInfo : Dictionary<String,Any>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
        
        if isConnectionEshtablished() {
            
            do {
                
                viewController.showHud(kLoading)
                
                let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                
                // create post request
                let endpoint: String = BASE_URL + url
                
                let session = URLSession.shared
                
                let request = networkSharedInstance(endpoint)
                
                request?.httpMethod = "POST"
                
                request?.httpBody = jsonData
                
                let task = session.dataTask(with: request! as URLRequest, completionHandler: { data, response, error in
                    
                    viewController.hideHUD()
                    
                    guard error == nil else {
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                        return
                    }
                    
                    guard let data = data else {
                        return
                    }
                    
                    
                    
                    // Checking here Response
                    if response != nil {
                        
                        viewController.hideHUD()
                        
                        let statusCode = (response as! HTTPURLResponse).statusCode
                        
                        
                        do {
                            //create json object from data
                            
                            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                                
                             
                                if 200...299 ~= statusCode {
                                    
                                    DispatchQueue.main.async {
                                        
                                        let similarItemDetailsArray = NetworkResponseParser.sharedInstance.parseSimilarItemDetailsArray(object: json as AnyObject?)
                                        var params = Dictionary<String,Any>()
                                        if let totalPages = json["totalPages"] as? Int{
                                            params.updateValue(totalPages, forKey: "totalPages")
                                        }
                                        if let totalPages = json["pageIndex"] as? Int{
                                            params.updateValue(totalPages, forKey: "pageIndex")
                                        }
                                        if let totalPages = json["totalRecords"] as? Int{
                                            params.updateValue(totalPages, forKey: "totalRecords")
                                        }
                                        if let statusMessage = json["statusMessage"] as? String{
                                            params.updateValue(statusMessage, forKey: "statusMessage")
                                        }
                                        successBlock(similarItemDetailsArray,params)
                                    }
                                    
                                }else if 401 == statusCode {
                                    DispatchQueue.main.async {
                                        self.moveToHomeScreen(kUnauthorizedError)
                                    }
                                } else {
                                    
                                    
                                    if Utilities.sharedInstance.isObjectNull(json as AnyObject?) {
                                        
                                        if let statusMessage = json["message"] as? String{
                                            
                                            DispatchQueue.main.async {
                                                failureBlock(true)
                                               // self.ShowError(viewController, message: statusMessage)
                                            }
                                        }
                                    }
                                    
                                }
                                
                                
                                
                            }
                            
                        } catch let catchError as NSError {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: catchError.localizedDescription)
                            }
                        }
                        
                        
                    }else{
                        
                      
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                  failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                    }
                    
                })
                
                task.resume()
            } catch {
                print("parsing error")
            }
        }else {
            
            ShowError()
        }
    }
    
    func getCollectionItemDetails(_ viewController: UIViewController,url : String, parameters: Dictionary<String, Any>, successBlock: @escaping (_ itemGroups: Array<Dictionary<String, Any>>, _ pageInfo : Dictionary<String,Any>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
        
        if isConnectionEshtablished() {
            
            do {
                
                viewController.showHud(kLoading)
                
                let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                
                // create post request
                let endpoint: String = BASE_URL + url
                
                let session = URLSession.shared
                
                let request = networkSharedInstance(endpoint)
                
                request?.httpMethod = "POST"
                
                request?.httpBody = jsonData
                
                let task = session.dataTask(with: request! as URLRequest, completionHandler: { data, response, error in
                    
                    viewController.hideHUD()
                    
                    guard error == nil else {
                       
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                 failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                        return
                    }
                    
                    guard let data = data else {
                        return
                    }
                    
                    
                    
                    // Checking here Response
                    if response != nil {
                        
                        viewController.hideHUD()
                        
                        let statusCode = (response as! HTTPURLResponse).statusCode
                        
                        
                        do {
                            //create json object from data
                            
                            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                                
                            
                                if 200...299 ~= statusCode {
                                    
                                    DispatchQueue.main.async {
                                        
                                        let collectionItemDetailsArray = NetworkResponseParser.sharedInstance.parseCollectionItemDetailsArray(object: json as AnyObject?)
                                        var params = Dictionary<String,Any>()
                                        if let totalPages = json["totalPages"] as? Int{
                                            params.updateValue(totalPages, forKey: "totalPages")
                                        }
                                        if let totalPages = json["pageIndex"] as? Int{
                                            params.updateValue(totalPages, forKey: "pageIndex")
                                        }
                                        if let totalPages = json["totalRecords"] as? Int{
                                            params.updateValue(totalPages, forKey: "totalRecords")
                                        }
                                        if let statusMessage = json["statusMessage"] as? String{
                                            params.updateValue(statusMessage, forKey: "statusMessage")
                                        }
                                        successBlock(collectionItemDetailsArray,params)
                                    }
                                    
                                }else if 401 == statusCode {
                                    DispatchQueue.main.async {
                                        self.moveToHomeScreen(kUnauthorizedError)
                                    }
                                } else {
                                    
                                   
                                    if Utilities.sharedInstance.isObjectNull(json as AnyObject?) {
                                        
                                        if let statusMessage = json["message"] as? String{
                                            
                                            DispatchQueue.main.async {
                                                 failureBlock(true)
                                                //self.ShowError(viewController, message: statusMessage)
                                            }
                                        }
                                    }
                                    
                                }
                                
                                
                                
                            }
                            
                        } catch let catchError as NSError {
                        
                            DispatchQueue.main.async {
                                    failureBlock(true)
                                self.ShowError(viewController, message: catchError.localizedDescription)
                            }
                        }
                        
                        
                    }else{
                        
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                print(errorDescription)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                    }
                    
                })
                
                task.resume()
            } catch {
                print("parsing error")
            }
        }else {
            
            ShowError()
        }
    }
    
    func getCountInfo(_ viewController: UIViewController, parameters: Dictionary<String, Any>, successBlock: @escaping (_ categories : Array<CountModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void){
        
        if isConnectionEshtablished() {
            
            do {
                
                
                let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                
                // create post request
                let endpoint: String = BASE_URL + API_GETTOTALSTODISPLAY
                
                let session = URLSession.shared
                
                let request = networkSharedInstance(endpoint)
                
                request?.httpMethod = "POST"
                
                request?.httpBody = jsonData
                
                let task = session.dataTask(with: request! as URLRequest, completionHandler: { data, response, error in
                    
                    
                    
                    guard error == nil else {
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                        return
                    }
                    
                    guard let data = data else {
                        return
                    }
                    
                    
                    // Checking here Response
                    if response != nil {
                        
                        
                        
                        let statusCode = (response as! HTTPURLResponse).statusCode
                        
                        
                        // Checking here Response Status
                        
                        do {
                            
                            //create json object from data
                            
                            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                                
                                if 200...299 ~= statusCode {
                                    
                                    DispatchQueue.main.async {
                                        
                                        let countDetails = NetworkResponseParser.sharedInstance.parseCountInfo(object: json)
                                        
                                        successBlock(countDetails)
                                    }
                                }else if 401 == statusCode {
                                    DispatchQueue.main.async {
                                        self.moveToHomeScreen(kUnauthorizedError)
                                    }
                                }else{
                                    
                                   
                                    
                                    if Utilities.sharedInstance.isObjectNull(json as AnyObject?) {
                                        
                                        if let statusMessage = json["message"] as? String{
                                            
                                            DispatchQueue.main.async {
                                                 failureBlock(true)
                                                self.ShowError(viewController, message: statusMessage)
                                            }
                                        }
                                    }
                                    
                                }
                                
                                
                            }
                            
                        } catch let catchError as NSError {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: catchError.localizedDescription)
                            }
                        }
                        
                        
                    }else{
                        
                       
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                 failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                    }
                    
                    
                    
                })
                task.resume()
            } catch {
                print("parsing error")
            }
        }else {
            
            ShowError()
        }
        
        
    }
    
    func getOpenOrderDetails(_ viewController: UIViewController,url : String, parameters: Dictionary<String, Any>, successBlock: @escaping (_ itemGroups: Array<OpenOrderModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
        
        if isConnectionEshtablished() {
            
            do {
                
                viewController.showHud(kLoading)
                
                let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                
                // create post request
                let endpoint: String = BASE_URL + url
                
                let session = URLSession.shared
                
                let request = networkSharedInstance(endpoint)
                
                request?.httpMethod = "POST"
                
                request?.httpBody = jsonData
                
                let task = session.dataTask(with: request! as URLRequest, completionHandler: { data, response, error in
                    
                    viewController.hideHUD()
                    
                    guard error == nil else {
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                        return
                    }
                    
                    guard let data = data else {
                        return
                    }
                    
                    
                    
                    // Checking here Response
                    if response != nil {
                        
                        viewController.hideHUD()
                        
                        let statusCode = (response as! HTTPURLResponse).statusCode
                        
                        
                        do {
                            //create json object from data
                            
                            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                                
                               
                                if 200...299 ~= statusCode {
                                    
                                    DispatchQueue.main.async {
                                        
                                        let openItemDetailsArray = NetworkResponseParser.sharedInstance.parseOpenItemDetailsArray(object: json as AnyObject?)
                                        var params = Dictionary<String,Any>()
                                        if let totalPages = json["totalPages"] as? Int{
                                            params.updateValue(totalPages, forKey: "totalPages")
                                        }
                                        if let totalPages = json["pageIndex"] as? Int{
                                            params.updateValue(totalPages, forKey: "pageIndex")
                                        }
                                        if let totalPages = json["totalRecords"] as? Int{
                                            params.updateValue(totalPages, forKey: "totalRecords")
                                        }
                                        if let statusMessage = json["statusMessage"] as? String{
                                            params.updateValue(statusMessage, forKey: "statusMessage")
                                        }
                                        successBlock(openItemDetailsArray)
                                    }
                                    
                                }else if 401 == statusCode {
                                    DispatchQueue.main.async {
                                        self.moveToHomeScreen(kUnauthorizedError)
                                    }
                                } else {
                                    
                                    
                                    if Utilities.sharedInstance.isObjectNull(json as AnyObject?) {
                                        
                                        if let statusMessage = json["message"] as? String{
                                            
                                            DispatchQueue.main.async {
                                                failureBlock(true)
                                                self.ShowError(viewController, message: statusMessage)
                                            }
                                        }
                                    }
                                    
                                }
                                
                                
                                
                            }
                            
                        } catch let catchError as NSError {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: catchError.localizedDescription)
                            }
                        }
                        
                        
                    }else{
                        
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                    }
                    
                })
                
                task.resume()
            } catch {
                print("parsing error")
            }
        }else {
            
            ShowError()
        }
    }

    
    func insertCustomerTrackDetails(_ viewController: UIViewController,url : String, parameters: Dictionary<String,Any>, successBlock: @escaping (_ message: String) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
        
        if isConnectionEshtablished() {
            
            do {
                
                
                let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                
                // create post request
                let endpoint: String = BASE_URL + url
                
                let session = URLSession.shared
                
                let request = networkSharedInstance(endpoint)
                
                request?.httpMethod = "POST"
                
                request?.httpBody = jsonData
                
                let task = session.dataTask(with: request! as URLRequest, completionHandler: { data, response, error in
                    
                    
                    guard error == nil else {
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                        return
                    }
                    
                    guard let data = data else {
                        return
                    }
                    
                    
                    // Checking here Response
                    if response != nil {
                        
                        
                        let statusCode = (response as! HTTPURLResponse).statusCode
                        
                        
                        // Checking here Response Status
                        
                        do {
                            
                            //create json object from data
                            
                            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                                
                                if 200...299 ~= statusCode {
                                    
                                    DispatchQueue.main.async {
                                        
                                        let status = NetworkResponseParser.sharedInstance.parseforgotPasswordResponse(object: json)
                                        
                                        successBlock(status)
                                    }
                                }else if 401 == statusCode {
                                    DispatchQueue.main.async {
                                        self.moveToHomeScreen(kUnauthorizedError)
                                    }
                                }else{
                                    
                                    
                                    
                                    if Utilities.sharedInstance.isObjectNull(json as AnyObject?) {
                                        
                                        if let statusMessage = json["message"] as? String{
                                            
                                            DispatchQueue.main.async {
                                                failureBlock(true)
                                                //self.ShowError(viewController, message: statusMessage)
                                            }
                                        }
                                    }
                                    
                                }
                                
                                
                            }
                            
                        } catch let catchError as NSError {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: catchError.localizedDescription)
                            }
                        }
                        
                        
                    }else{
                        
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                    }
                    
                    
                    
                })
                task.resume()
            } catch {
                print("parsing error")
            }
        }else {
            
            ShowError()
        }
    }
    
    
    func getMoreAboutGroupCount(_ viewController: UIViewController,url : String, parameters: Dictionary<String, Any>, successBlock: @escaping (_ itemGroups: Array<ItemDetailsModel>, _ pageInfo : Dictionary<String,Any>,_ totalOrders : Array<TotalOrdersModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
        
        if isConnectionEshtablished() {
            
            do {
                
                
                let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                
                // create post request
                let endpoint: String = BASE_URL + url
                
                let session = URLSession.shared
                
                let request = networkSharedInstance(endpoint)
                
                request?.httpMethod = "POST"
                
                request?.httpBody = jsonData
                
                let task = session.dataTask(with: request! as URLRequest, completionHandler: { data, response, error in
                    
                    
                    guard error == nil else {
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                        return
                    }
                    
                    guard let data = data else {
                        return
                    }
                    
                    
                    
                    // Checking here Response
                    if response != nil {
                        
                        
                        let statusCode = (response as! HTTPURLResponse).statusCode
                        
                        
                        do {
                            //create json object from data
                            
                            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                                
                                
                                if 200...299 ~= statusCode {
                                    
                                    DispatchQueue.main.async {
                                        
                                        let itemDetailsArray = NetworkResponseParser.sharedInstance.parseGroup(object: json as AnyObject?)
                                        
                                        let totalDetailsArray = NetworkResponseParser.sharedInstance.parseTotalOrderDetails(object: json as AnyObject?)
                                        
                                        var params = Dictionary<String,Any>()
                                        if let totalPages = json["totalPages"] as? Int{
                                            params.updateValue(totalPages, forKey: "totalPages")
                                        }
                                        if let totalPages = json["pageIndex"] as? Int{
                                            params.updateValue(totalPages, forKey: "pageIndex")
                                        }
                                        if let totalPages = json["totalRecords"] as? Int{
                                            params.updateValue(totalPages, forKey: "totalRecords")
                                        }
                                        if let statusMessage = json["statusMessage"] as? String{
                                            params.updateValue(statusMessage, forKey: "statusMessage")
                                        }
                                        successBlock(itemDetailsArray,params,totalDetailsArray)
                                    }
                                    
                                }else if 401 == statusCode {
                                    DispatchQueue.main.async {
                                        self.moveToHomeScreen(kUnauthorizedError)
                                    }
                                } else {
                                    
                                    
                                    if Utilities.sharedInstance.isObjectNull(json as AnyObject?) {
                                        
                                        if let statusMessage = json["message"] as? String{
                                            
                                            DispatchQueue.main.async {
                                                failureBlock(true)
                                               // self.ShowError(viewController, message: statusMessage)
                                            }
                                        }
                                    }
                                    
                                }
                                
                                
                                
                            }
                            
                        } catch let catchError as NSError {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: catchError.localizedDescription)
                            }
                        }
                        
                        
                    }else{
                        
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                               // self.ShowError(viewController, message: errorDescription)
                            }
                        }
                    }
                    
                })
                
                task.resume()
            } catch {
                print("parsing error")
            }
        }else {
            
            ShowError()
        }
    }
    
    
    func getCompleteOrderDetails(_ viewController: UIViewController,url : String, parameters: Dictionary<String, Any>, successBlock: @escaping (_ orderModel: Array<CompleteOrderModel>, _ pageInfo : Dictionary<String,Any>,_ totalOrders : Array<TotalOrdersModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
        
        if isConnectionEshtablished() {
            
            do {
                
                viewController.showHud(kLoading)
                
                let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                
                // create post request
                let endpoint: String = BASE_URL + url
                
                let session = URLSession.shared
                
                let request = networkSharedInstance(endpoint)
                
                request?.httpMethod = "POST"
                
                request?.httpBody = jsonData
                
                let task = session.dataTask(with: request! as URLRequest, completionHandler: { data, response, error in
                    
                
                    
                    guard error == nil else {
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                        return
                    }
                    
                    guard let data = data else {
                        return
                    }
                    
                    
                    
                    // Checking here Response
                    if response != nil {
                        
                     
                        
                        let statusCode = (response as! HTTPURLResponse).statusCode
                        
                        
                        do {
                            //create json object from data
                            
                            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                                
                                
                                if 200...299 ~= statusCode {
                                    
                                    DispatchQueue.main.async {
                                        
                                        let itemDetailsArray = NetworkResponseParser.sharedInstance.parseListCategories(object: json as AnyObject?)
                                        
                                        let totalDetailsArray = NetworkResponseParser.sharedInstance.parseTotalOrderDetails(object: json as AnyObject?)
                                        
                                        var params = Dictionary<String,Any>()
                                        if let totalPages = json["totalPages"] as? Int{
                                            params.updateValue(totalPages, forKey: "totalPages")
                                        }
                                        if let totalPages = json["pageIndex"] as? Int{
                                            params.updateValue(totalPages, forKey: "pageIndex")
                                        }
                                        if let totalPages = json["totalRecords"] as? Int{
                                            params.updateValue(totalPages, forKey: "totalRecords")
                                        }
                                        if let statusMessage = json["statusMessage"] as? String{
                                            params.updateValue(statusMessage, forKey: "statusMessage")
                                        }
                                        successBlock(itemDetailsArray,params,totalDetailsArray)
                                    }
                                    
                                }else if 401 == statusCode {
                                    DispatchQueue.main.async {
                                        self.moveToHomeScreen(kUnauthorizedError)
                                    }
                                } else {
                                    
                                    
                                    if Utilities.sharedInstance.isObjectNull(json as AnyObject?) {
                                        
                                        if let statusMessage = json["message"] as? String{
                                            
                                            DispatchQueue.main.async {
                                                failureBlock(true)
                                                self.ShowError(viewController, message: statusMessage)
                                            }
                                        }
                                    }
                                    
                                }
                                
                                
                                
                            }
                            
                        } catch let catchError as NSError {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: catchError.localizedDescription)
                            }
                        }
                        
                        
                    }else{
                        
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                    }
                    
                })
                
                task.resume()
            } catch {
                print("parsing error")
            }
        }else {
            
            ShowError()
        }
    }
    
    
    func getCustomerAddress(_ viewController: UIViewController,url : String, parameters: Dictionary<String, Any>, successBlock: @escaping (_ addressModel: Array<CustomerLookUpAddressModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
        
        if isConnectionEshtablished() {
            
            do {
                
                viewController.showHud(kLoading)
                
                let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                
                // create post request
                let endpoint: String = BASE_URL + url
                
                let session = URLSession.shared
                
                let request = networkSharedInstance(endpoint)
                
                request?.httpMethod = "POST"
                
                request?.httpBody = jsonData
                
                let task = session.dataTask(with: request! as URLRequest, completionHandler: { data, response, error in
                    
                     viewController.hideHUD()
                    
                    guard error == nil else {
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                        return
                    }
                    
                    guard let data = data else {
                        return
                    }
                    
                    
                    
                    // Checking here Response
                    if response != nil {
                        
                         viewController.hideHUD()
                        
                        let statusCode = (response as! HTTPURLResponse).statusCode
                        
                        
                        do {
                            //create json object from data
                            
                            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                                
                            
                                if 200...299 ~= statusCode {
                                    
                                    DispatchQueue.main.async {
                                        
                                        let customerItemDetailsArray = NetworkResponseParser.sharedInstance.parseAddressDetails(object: json as AnyObject?)
                                        successBlock(customerItemDetailsArray)
                                    }
                                    
                                }else if 401 == statusCode {
                                    DispatchQueue.main.async {
                                        self.moveToHomeScreen(kUnauthorizedError)
                                    }
                                } else {
                                    
                                    
                                    if Utilities.sharedInstance.isObjectNull(json as AnyObject?) {
                                        
                                        if let statusMessage = json["message"] as? String{
                                            
                                            DispatchQueue.main.async {
                                                failureBlock(true)
                                                self.ShowError(viewController, message: statusMessage)
                                            }
                                        }
                                    }
                                    
                                }
                                
                                
                                
                            }
                            
                        } catch let catchError as NSError {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: catchError.localizedDescription)
                            }
                        }
                        
                        
                    }else{
                        
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                    }
                    
                })
                
                task.resume()
            } catch {
                print("parsing error")
            }
        }else {
            
            ShowError()
        }
    }
    
    func getFrieghtTerms(_ viewController: UIViewController, successBlock: @escaping (_ categories : Array<FreightTermsModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
        
        if isConnectionEshtablished() {
            
        
            
            do {
                
                // create post request
                let endpoint: String = BASE_URL + API_GETFRIEGHTTERMS
                
                let session = URLSession.shared
                
                let request = networkSharedInstance(endpoint)
                
                request?.httpMethod = "GET"
                
                
                let task = session.dataTask(with: request! as URLRequest, completionHandler: { data, response, error in
                    
                    
                
                    guard error == nil else {
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                        return
                    }
                    
                    
                    guard let data = data else {
                        return
                    }
                    
                    // Checking here Response
                    if response != nil {
                        
            
                        
                        let statusCode = (response as! HTTPURLResponse).statusCode
                        
                        
                        do {
                            //create json object from data
                            
                            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                                
                                
                                
                                
                                if 200...299 ~= statusCode {
                                    
                                    DispatchQueue.main.async {
                                        
                                        let frieghtTypes = NetworkResponseParser.sharedInstance.parseFreightTypes(object: json as AnyObject)
                                        successBlock(frieghtTypes)
                                    }
                                    
                                }else if 401 == statusCode {
                                    DispatchQueue.main.async {
                                        self.moveToHomeScreen(kUnauthorizedError)
                                    }
                                } else {
                                    
                                    
                                    if Utilities.sharedInstance.isObjectNull(json as AnyObject?) {
                                        
                                        if let statusMessage = json["message"] as? String{
                                            
                                            DispatchQueue.main.async {
                                                failureBlock(true)
                                                self.ShowError(viewController, message: statusMessage)
                                            }
                                        }
                                    }
                                    
                                }
                                
                                
                                
                            }
                            
                        } catch let catchError as NSError {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: catchError.localizedDescription)
                            }
                        }
                        
                        
                    }else{
                        
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                    }
                    
                    
                    
                    
                })
                task.resume()
            }
        }else {
            
            ShowError()
        }
    }

    func getPaymentTerms(_ viewController: UIViewController, successBlock: @escaping (_ categories : Array<PaymentTermsModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
        
        if isConnectionEshtablished() {
            
            do {
                
                // create post request
                let endpoint: String = BASE_URL + API_GETPAYMENTTERMS
                
                let session = URLSession.shared
                
                let request = networkSharedInstance(endpoint)
                
                request?.httpMethod = "GET"
                
                
                let task = session.dataTask(with: request! as URLRequest, completionHandler: { data, response, error in
                    
                    
                    viewController.hideHUD()
                    
                    guard error == nil else {
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                        return
                    }
                    
                    
                    guard let data = data else {
                        return
                    }
                    
                    // Checking here Response
                    if response != nil {
                        
                        viewController.hideHUD()
                        
                        let statusCode = (response as! HTTPURLResponse).statusCode
                        
                        
                        do {
                            //create json object from data
                            
                            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                                
                                
                                
                                
                                if 200...299 ~= statusCode {
                                    
                                    DispatchQueue.main.async {
                                        
                                        let paymentTypes = NetworkResponseParser.sharedInstance.parsePaymentTypes(object: json as AnyObject)
                                        successBlock(paymentTypes)
                                    }
                                    
                                }else if 401 == statusCode {
                                    DispatchQueue.main.async {
                                        self.moveToHomeScreen(kUnauthorizedError)
                                    }
                                } else {
                                    
                                    
                                    if Utilities.sharedInstance.isObjectNull(json as AnyObject?) {
                                        
                                        if let statusMessage = json["message"] as? String{
                                            
                                            DispatchQueue.main.async {
                                                failureBlock(true)
                                                self.ShowError(viewController, message: statusMessage)
                                            }
                                        }
                                    }
                                    
                                }
                                
                                
                                
                            }
                            
                        } catch let catchError as NSError {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: catchError.localizedDescription)
                            }
                        }
                        
                        
                    }else{
                        
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                    }
                    
                    
                    
                    
                })
                task.resume()
            }
        }else {
            
            ShowError()
        }
    }
    
    
    func getOrderSummary(_ viewController: UIViewController,url : String, parameters: Dictionary<String, Any>, successBlock: @escaping (_ itemGroups: Array<OrderSummaryModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
        
        if isConnectionEshtablished() {
            
            do {
                
                viewController.showHud(kLoading)
                
                let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                
                // create post request
                let endpoint: String = BASE_URL + url
                
                let session = URLSession.shared
                
                let request = networkSharedInstance(endpoint)
                
                request?.httpMethod = "POST"
                
                request?.httpBody = jsonData
                
                let task = session.dataTask(with: request! as URLRequest, completionHandler: { data, response, error in
                    
                    viewController.hideHUD()
                    
                    guard error == nil else {
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                        return
                    }
                    
                    guard let data = data else {
                        return
                    }
                    
                    
                    
                    // Checking here Response
                    if response != nil {
                        
                        viewController.hideHUD()
                        
                        let statusCode = (response as! HTTPURLResponse).statusCode
                        
                        
                        do {
                            //create json object from data
                            
                            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                                
                                
                                if 200...299 ~= statusCode {
                                    
                                    DispatchQueue.main.async {
                                        
                                        let itemDetailsArray = NetworkResponseParser.sharedInstance.parseOrderSummary(object: json as AnyObject?)
                                
                                        successBlock(itemDetailsArray)
                                    }
                                    
                                }else if 401 == statusCode {
                                    DispatchQueue.main.async {
                                        self.moveToHomeScreen(kUnauthorizedError)
                                    }
                                } else {
                                    
                                    
                                    if Utilities.sharedInstance.isObjectNull(json as AnyObject?) {
                                        
                                        if let statusMessage = json["message"] as? String{
                                            
                                            DispatchQueue.main.async {
                                                failureBlock(true)
                                                self.ShowError(viewController, message: statusMessage)
                                            }
                                        }
                                    }
                                    
                                }
                                
                                
                                
                            }
                            
                        } catch let catchError as NSError {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: catchError.localizedDescription)
                            }
                        }
                        
                        
                    }else{
                        
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                    }
                    
                })
                
                task.resume()
            } catch {
                print("parsing error")
            }
        }else {
            
            ShowError()
        }
    }

    
    func getAddressTypes(_ viewController: UIViewController, successBlock: @escaping (_ categories : Array<AddressTypeModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
        
        if isConnectionEshtablished() {
            
            
            
            do {
                
                 viewController.showHud(kLoading)
                
                // create post request
                let endpoint: String = BASE_URL + API_GETADDRESSTYPES
                
                let session = URLSession.shared
                
                let request = networkSharedInstance(endpoint)
                
                request?.httpMethod = "GET"
                
                
                let task = session.dataTask(with: request! as URLRequest, completionHandler: { data, response, error in
                    
                    
                    
                    guard error == nil else {
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                        return
                    }
                    
                    guard let data = data else {
                        return
                    }
                    
                    // Checking here Response
                    if response != nil {
                        
                        
                        
                        let statusCode = (response as! HTTPURLResponse).statusCode
                        
                        
                        do {
                            //create json object from data
                            
                            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                                
                                
                               
                                
                                if 200...299 ~= statusCode {
                                    
                                    DispatchQueue.main.async {
                                        
                                        let addressArray = NetworkResponseParser.sharedInstance.parseAddressTypes(object: json as AnyObject?)
                                        successBlock(addressArray)
                                    }
                                    
                                }else if 401 == statusCode {
                                    DispatchQueue.main.async {
                                        self.moveToHomeScreen(kUnauthorizedError)
                                    }
                                } else {
                                    
                                    
                                    if Utilities.sharedInstance.isObjectNull(json as AnyObject?) {
                                        
                                        if let statusMessage = json["message"] as? String{
                                            
                                            DispatchQueue.main.async {
                                                failureBlock(true)
                                                self.ShowError(viewController, message: statusMessage)
                                            }
                                        }
                                    }
                                    
                                }
                                
                                
                                
                            }
                            
                        } catch let catchError as NSError {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: catchError.localizedDescription)
                            }
                        }
                        
                        
                    }else{
                        
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                    }
                    
                    
                    
                    
                })
                task.resume()
            }
        }else {
            
            ShowError()
        }
    }

    func getStates(_ viewController: UIViewController, successBlock: @escaping (_ categories : Array<StatesModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
        
        if isConnectionEshtablished() {
            
            
            
            do {
                
        
                
                // create post request
                let endpoint: String = BASE_URL + API_GETSTATES
                
                let session = URLSession.shared
                
                let request = networkSharedInstance(endpoint)
                
                request?.httpMethod = "GET"
                
                
                let task = session.dataTask(with: request! as URLRequest, completionHandler: { data, response, error in
                    
                    
                    
                    guard error == nil else {
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                        return
                    }
                    
                    
                    guard let data = data else {
                        return
                    }
                    
                    // Checking here Response
                    if response != nil {
                        
                        
                        
                        let statusCode = (response as! HTTPURLResponse).statusCode
                        
                        
                        do {
                            //create json object from data
                            
                            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                                
                               
                                
                                
                                
                                if 200...299 ~= statusCode {
                                    
                                    DispatchQueue.main.async {
                                        
                                        let statesArray = NetworkResponseParser.sharedInstance.parseStates(object: json as AnyObject?)
                                        successBlock(statesArray)
                                    }
                                    
                                }else if 401 == statusCode {
                                    DispatchQueue.main.async {
                                        self.moveToHomeScreen(kUnauthorizedError)
                                    }
                                } else {
                                    
                                    
                                    if Utilities.sharedInstance.isObjectNull(json as AnyObject?) {
                                        
                                        if let statusMessage = json["message"] as? String{
                                            
                                            DispatchQueue.main.async {
                                                failureBlock(true)
                                                self.ShowError(viewController, message: statusMessage)
                                            }
                                        }
                                    }
                                    
                                }
                                
                                
                                
                            }
                            
                        } catch let catchError as NSError {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: catchError.localizedDescription)
                            }
                        }
                        
                        
                    }else{
                        
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                    }
                    
                    
                    
                    
                })
                task.resume()
            }
        }else {
            
            ShowError()
        }
    }
    
    func getCountries(_ viewController: UIViewController, successBlock: @escaping (_ categories : Array<CountryModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
        
        if isConnectionEshtablished() {
            
            
            
            do {
                
            
                
                // create post request
                let endpoint: String = BASE_URL + API_GETCOUNTRIES
                
                let session = URLSession.shared
                
                let request = networkSharedInstance(endpoint)
                
                request?.httpMethod = "GET"
                
                
                let task = session.dataTask(with: request! as URLRequest, completionHandler: { data, response, error in
                    
                    
                    
                    guard error == nil else {
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                        return
                    }
                    
                    
                    guard let data = data else {
                        return
                    }
                    
                    // Checking here Response
                    if response != nil {
                        
                        
                        
                        let statusCode = (response as! HTTPURLResponse).statusCode
                        
                        
                        do {
                            //create json object from data
                            
                            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                                
                               
                                
                                
                                if 200...299 ~= statusCode {
                                    
                                    DispatchQueue.main.async {
                                        
                                        let countriesArray = NetworkResponseParser.sharedInstance.parseCountries(object: json as AnyObject?)
                                        successBlock(countriesArray)
                                    }
                                    
                                }else if 401 == statusCode {
                                    DispatchQueue.main.async {
                                        self.moveToHomeScreen(kUnauthorizedError)
                                    }
                                } else {
                                    
                                    
                                    if Utilities.sharedInstance.isObjectNull(json as AnyObject?) {
                                        
                                        if let statusMessage = json["message"] as? String{
                                            
                                            DispatchQueue.main.async {
                                                failureBlock(true)
                                                self.ShowError(viewController, message: statusMessage)
                                            }
                                        }
                                    }
                                    
                                }
                                
                                
                                
                            }
                            
                        } catch let catchError as NSError {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: catchError.localizedDescription)
                            }
                        }
                        
                        
                    }else{
                        
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                    }
                    
                    
                    
                    
                })
                task.resume()
            }
        }else {
            
            ShowError()
        }
    }
    
    
    func getShipViaTypes(_ viewController: UIViewController, successBlock: @escaping (_ categories : Array<ShipViaTypeModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
        
        if isConnectionEshtablished() {
            
            
            
            do {
                
                // create post request
                let endpoint: String = BASE_URL + API_GETSHIPVIATYPES
                
                let session = URLSession.shared
                
                let request = networkSharedInstance(endpoint)
                
                request?.httpMethod = "GET"
                
                
                let task = session.dataTask(with: request! as URLRequest, completionHandler: { data, response, error in
                    
                    viewController.hideHUD()
                    
                    guard error == nil else {
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                        return
                    }
                    
                    
                    guard let data = data else {
                        return
                    }
                    
                    // Checking here Response
                    if response != nil {
                        
                        viewController.hideHUD()
                        
                        let statusCode = (response as! HTTPURLResponse).statusCode
                        
                        
                        do {
                            //create json object from data
                            
                            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                                
                                
                                
                                
                                if 200...299 ~= statusCode {
                                    
                                    DispatchQueue.main.async {
                                        
                                        let shipViaTypeArray = NetworkResponseParser.sharedInstance.parseShipViaTypes(object: json as AnyObject?)
                                        successBlock(shipViaTypeArray)
                                    }
                                    
                                }else if 401 == statusCode {
                                    DispatchQueue.main.async {
                                        self.moveToHomeScreen(kUnauthorizedError)
                                    }
                                } else {
                                    
                                    
                                    if Utilities.sharedInstance.isObjectNull(json as AnyObject?) {
                                        
                                        if let statusMessage = json["message"] as? String{
                                            
                                            DispatchQueue.main.async {
                                                failureBlock(true)
                                                self.ShowError(viewController, message: statusMessage)
                                            }
                                        }
                                    }
                                    
                                }
                                
                                
                                
                            }
                            
                        } catch let catchError as NSError {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: catchError.localizedDescription)
                            }
                        }
                        
                        
                    }else{
                        
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                    }
                    
                    
                    
                    
                })
                task.resume()
            }
        }else {
            
            ShowError()
        }
    }
    
    func getCustomerCreditCardDetails(_ viewController: UIViewController,url : String, parameters: Dictionary<String, Any>, successBlock: @escaping (_ creditCards: Array<CreditCardModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
        
        if isConnectionEshtablished() {
            
            do {
                
                viewController.showHud(kLoading)
                
                let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                
                // create post request
                let endpoint: String = BASE_URL + url
                
                let session = URLSession.shared
                
                let request = networkSharedInstance(endpoint)
                
                request?.httpMethod = "POST"
                
                request?.httpBody = jsonData
                
                let task = session.dataTask(with: request! as URLRequest, completionHandler: { data, response, error in
                    
                    viewController.hideHUD()
                    
                    guard error == nil else {
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                        return
                    }
                    
                    guard let data = data else {
                        return
                    }
                    
                    
                    
                    // Checking here Response
                    if response != nil {
                        
                        viewController.hideHUD()
                        
                        let statusCode = (response as! HTTPURLResponse).statusCode
                        
                        
                        do {
                            //create json object from data
                            
                            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                                
                                
                                if 200...299 ~= statusCode {
                                    
                                    DispatchQueue.main.async {
                                        
                                        let creditCardsArray = NetworkResponseParser.sharedInstance.parseCreditCardDetails(object: json as AnyObject?)
                                        successBlock(creditCardsArray)
                    
                                    }
                                    
                                }else if 401 == statusCode {
                                    DispatchQueue.main.async {
                                        self.moveToHomeScreen(kUnauthorizedError)
                                    }
                                } else {
                                    
                                    
                                    if Utilities.sharedInstance.isObjectNull(json as AnyObject?) {
                                        
                                        if let statusMessage = json["message"] as? String{
                                            
                                            DispatchQueue.main.async {
                                                failureBlock(true)
                                                self.ShowError(viewController, message: statusMessage)
                                            }
                                        }
                                    }
                                    
                                }
                                
                                
                                
                            }
                            
                        } catch let catchError as NSError {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: catchError.localizedDescription)
                            }
                        }
                        
                        
                    }else{
                        
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                    }
                    
                })
                
                task.resume()
            } catch {
                print("parsing error")
            }
        }else {
            
            ShowError()
        }
    }
    
    
    func getCreditCardAddress(_ viewController: UIViewController,url : String, parameters: Dictionary<String, Any>, successBlock: @escaping (_ addressModel: Array<CustomerLookUpAddressModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
        
        if isConnectionEshtablished() {
            
            do {
                
                viewController.showHud(kLoading)
                
                let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                
                // create post request
                let endpoint: String = BASE_URL + url
                
                let session = URLSession.shared
                
                let request = networkSharedInstance(endpoint)
                
                request?.httpMethod = "POST"
                
                request?.httpBody = jsonData
                
                let task = session.dataTask(with: request! as URLRequest, completionHandler: { data, response, error in
                    
                    viewController.hideHUD()
                    
                    guard error == nil else {
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                        return
                    }
                    
                    guard let data = data else {
                        return
                    }
                    
                    
                    
                    // Checking here Response
                    if response != nil {
                        
                        viewController.hideHUD()
                        
                        let statusCode = (response as! HTTPURLResponse).statusCode
                        
                        
                        do {
                            //create json object from data
                            
                            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                                
                               
                                if 200...299 ~= statusCode {
                                    
                                    DispatchQueue.main.async {
                                        
                                        let customerItemDetailsArray = NetworkResponseParser.sharedInstance.parseAddressDetails(object: json as AnyObject?)
                                        successBlock(customerItemDetailsArray)
                                    }
                                    
                                }else if 401 == statusCode {
                                    DispatchQueue.main.async {
                                        self.moveToHomeScreen(kUnauthorizedError)
                                    }
                                } else {
                                    
                                    
                                    if Utilities.sharedInstance.isObjectNull(json as AnyObject?) {
                                        
                                        if let statusMessage = json["message"] as? String{
                                            
                                            DispatchQueue.main.async {
                                                failureBlock(true)
                                                self.ShowError(viewController, message: statusMessage)
                                            }
                                        }
                                    }
                                    
                                }
                                
                                
                                
                            }
                            
                        } catch let catchError as NSError {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: catchError.localizedDescription)
                            }
                        }
                        
                        
                    }else{
                        
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                    }
                    
                })
                
                task.resume()
            } catch {
                print("parsing error")
            }
        }else {
            
            ShowError()
        }
    }
    
    
    func getRequest(_ viewController: UIViewController, url : String, successBlock: @escaping (_ json : NSDictionary) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
        
        if isConnectionEshtablished() {
            
            viewController.showHud(kLoading)
   
            
            do {
                
                // create post request
                let endpoint: String = BASE_URL + url
                
                let session = URLSession.shared
                
                let request = networkSharedInstance(endpoint)
                
                request?.httpMethod = "GET"
                
                
                let task = session.dataTask(with: request! as URLRequest, completionHandler: { data, response, error in
                    
                    
                    viewController.hideHUD()
                    
                    guard error == nil else {
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                        return
                    }
                    
                    
                    guard let data = data else {
                        return
                    }
                    
                    // Checking here Response
                    if response != nil {
                        
                        viewController.hideHUD()
                        
                        let statusCode = (response as! HTTPURLResponse).statusCode
                        
                        
                        do {
                            //create json object from data
                            
                            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                                
                                
                                
                                
                                if 200...299 ~= statusCode {
                                    
                                    DispatchQueue.main.async {
                                        
                                        successBlock(json)
                                    }
                                    
                                }else if 401 == statusCode {
                                    DispatchQueue.main.async {
                                        self.moveToHomeScreen(kUnauthorizedError)
                                    }
                                } else {
                                    
                                    
                                    if Utilities.sharedInstance.isObjectNull(json as AnyObject?) {
                                        
                                        if let statusMessage = json["message"] as? String{
                                            
                                            DispatchQueue.main.async {
                                                failureBlock(true)
                                                self.ShowError(viewController, message: statusMessage)
                                            }
                                        }
                                    }
                                    
                                }
                                
                                
                                
                            }
                            
                        } catch let catchError as NSError {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: catchError.localizedDescription)
                            }
                        }
                        
                        
                    }else{
                        
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                    }
                    
                    
                    
                    
                })
                task.resume()
            }
        }else {
            
            ShowError()
        }
    }
    
    //MARK: - POST API
    
    func postOrderRequest(_ viewController: UIViewController,url : String, parameters: Array<Dictionary<String, Any>>, successBlock: @escaping (_ message: String , _ count : Int) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
        
        if isConnectionEshtablished() {
            
            do {
                
                viewController.showHud(kLoading)
                
                let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                
                // create post request
                let endpoint: String = BASE_URL + url
                
                let session = URLSession.shared
                
                let request = networkSharedInstance(endpoint)
                
                request?.httpMethod = "POST"
                
                request?.httpBody = jsonData
                
                let task = session.dataTask(with: request! as URLRequest, completionHandler: { data, response, error in
                    
                    viewController.hideHUD()
                    
                    guard error == nil else {
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                        return
                    }
                    
                    guard let data = data else {
                        return
                    }
                    
                    
                    // Checking here Response
                    if response != nil {
                        
                        viewController.hideHUD()
                        
                        let statusCode = (response as! HTTPURLResponse).statusCode
                        
                        
                        // Checking here Response Status
                        
                        do {
                            
                            //create json object from data
                            
                            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                                
                                if 200...299 ~= statusCode {
                                    
                                    DispatchQueue.main.async {
                                        
                                        let status = NetworkResponseParser.sharedInstance.parseforgotPasswordResponse(object: json)
                                        
                                        var totalCount = 0
                                        
                                        if let countTotalString = json["data"] as? String{
                                            
                                            if let total = Int(countTotalString){
                                                totalCount = total
                                            }
                                        }
                                        
                                        successBlock(status,totalCount)
                                    }
                                }else if 401 == statusCode {
                                    DispatchQueue.main.async {
                                        self.moveToHomeScreen(kUnauthorizedError)
                                    }
                                }else{
                                    
                                    
                                    
                                    if Utilities.sharedInstance.isObjectNull(json as AnyObject?) {
                                        
                                        if let statusMessage = json["message"] as? String{
                                            
                                            DispatchQueue.main.async {
                                                failureBlock(true)
                                                self.ShowError(viewController, message: statusMessage)
                                            }
                                        }
                                    }
                                    
                                }
                                
                                
                            }
                            
                        } catch let catchError as NSError {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: catchError.localizedDescription)
                            }
                        }
                        
                        
                    }else{
                        
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                    }
                    
                    
                    
                })
                task.resume()
            } catch {
                print("parsing error")
            }
        }else {
            
            ShowError()
        }
    }
    
    
    func getSubmitOrderRequest(_ viewController: UIViewController, url : String, successBlock: @escaping (_ itemGroups: Array<SimilarItemModel>,Dictionary<String,Any>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
        
        if isConnectionEshtablished() {
            
            viewController.showHud(kLoading)
            
            
            do {
                
                // create post request
                let endpoint: String = BASE_URL + url
                
                let session = URLSession.shared
                
                let request = networkSharedInstance(endpoint)
                
                request?.httpMethod = "GET"
                
                
                let task = session.dataTask(with: request! as URLRequest, completionHandler: { data, response, error in
                    
                    
                    viewController.hideHUD()
                    
                    guard error == nil else {
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                        return
                    }
                    
                    
                    guard let data = data else {
                        return
                    }
                    
                    // Checking here Response
                    if response != nil {
                        
                        viewController.hideHUD()
                        
                        let statusCode = (response as! HTTPURLResponse).statusCode
                        
                        
                        do {
                            //create json object from data
                            
                            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                                
                                
                                
                                
                                if 200...299 ~= statusCode {
                                    
                                    DispatchQueue.main.async {
                                        
                                        let similarItemDetailsArray = NetworkResponseParser.sharedInstance.parseBestSimilarItemDetailsArray(object: json as AnyObject?)
                                        let data = json ["data"] as? NSDictionary
                                        var params = Dictionary<String,Any>()
                                   
                                        if let statusMessage = data?["email"] as? String{
                                            params.updateValue(statusMessage, forKey: "email")
                                        }
                                        
                                        if let statusMessage = data?["orderNumber"] as? String{
                                            params.updateValue(statusMessage, forKey: "orderNumber")
                                        }
                                        
                                        successBlock(similarItemDetailsArray,params)

                                        
                                    }
                                    
                                }else if 401 == statusCode {
                                    DispatchQueue.main.async {
                                        self.moveToHomeScreen(kUnauthorizedError)
                                    }
                                } else {
                                    
                                    
                                    if Utilities.sharedInstance.isObjectNull(json as AnyObject?) {
                                        
                                        if let statusMessage = json["message"] as? String{
                                            
                                            DispatchQueue.main.async {
                                                failureBlock(true)
                                                self.ShowError(viewController, message: statusMessage)
                                            }
                                        }
                                    }
                                    
                                }
                                
                                
                                
                            }
                            
                        } catch let catchError as NSError {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: catchError.localizedDescription)
                            }
                        }
                        
                        
                    }else{
                        
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                    }
                    
                    
                    
                    
                })
                task.resume()
            }
        }else {
            
            ShowError()
        }
    }


    func getContactTypes(_ viewController: UIViewController, successBlock: @escaping (_ categories : Array<ContactTypeModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
        
        if isConnectionEshtablished() {
            
            
            
            do {
                
                viewController.showHud(kLoading)
                
                // create post request
                let endpoint: String = BASE_URL + API_GET_CONTACT_TYPES
                
                let session = URLSession.shared
                
                let request = networkSharedInstance(endpoint)
                
                request?.httpMethod = "GET"
                
                
                let task = session.dataTask(with: request! as URLRequest, completionHandler: { data, response, error in
                    
                    viewController.hideHUD()
                    
                    guard error == nil else {
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                        return
                    }
                    
                    guard let data = data else {
                        return
                    }
                    
                    // Checking here Response
                    if response != nil {
                        
                        
                              viewController.hideHUD()
                        let statusCode = (response as! HTTPURLResponse).statusCode
                        
                        
                        do {
                            //create json object from data
                            
                            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                                
                                
                                
                                
                                if 200...299 ~= statusCode {
                                    
                                    DispatchQueue.main.async {
                                        
                                        let contactsArray = NetworkResponseParser.sharedInstance.parseContactTypes(object: json as AnyObject?)
                                        successBlock(contactsArray)
                                    }
                                    
                                }else if 401 == statusCode {
                                    DispatchQueue.main.async {
                                        self.moveToHomeScreen(kUnauthorizedError)
                                    }
                                } else {
                                    
                                    
                                    if Utilities.sharedInstance.isObjectNull(json as AnyObject?) {
                                        
                                        if let statusMessage = json["message"] as? String{
                                            
                                            DispatchQueue.main.async {
                                                failureBlock(true)
                                                self.ShowError(viewController, message: statusMessage)
                                            }
                                        }
                                    }
                                    
                                }
                                
                                
                                
                            }
                            
                        } catch let catchError as NSError {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: catchError.localizedDescription)
                            }
                        }
                        
                        
                    }else{
                        
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                    }
                    
                    
                    
                    
                })
                task.resume()
            }
        }else {
            
            ShowError()
        }
    }

    
    func getMainAccountInformation(_ viewController: UIViewController, successBlock: @escaping (_ categories : Array<CustomerAddressModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
        
        if isConnectionEshtablished() {
            
            
            
            do {
                
                viewController.showHud(kLoading)
                
                var customerNumber = ""
                
                let credentials = Utilities.getUserNameAndPasswordFromLocalStorage()
                if let userName = credentials.userName {
                    customerNumber = userName
                }
                
                // create post request
                let endpoint: String = BASE_URL + API_GETCUSTOMERGENERALINFO + "/" + customerNumber
                
                let session = URLSession.shared
                
                let request = networkSharedInstance(endpoint)
                
                request?.httpMethod = "GET"
                
                
                let task = session.dataTask(with: request! as URLRequest, completionHandler: { data, response, error in
                    
                    viewController.hideHUD()
                    
                    guard error == nil else {
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                        return
                    }
                    
                    guard let data = data else {
                        return
                    }
                    
                    // Checking here Response
                    if response != nil {
                        
                        
                        viewController.hideHUD()
                        let statusCode = (response as! HTTPURLResponse).statusCode
                        
                        
                        do {
                            //create json object from data
                            
                            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                                
                                
                                
                                
                                if 200...299 ~= statusCode {
                                    
                                    DispatchQueue.main.async {
                                        
                                        let mainInfoDetailsArray = NetworkResponseParser.sharedInstance.parseCustomerMainAddressDetails(object: json as AnyObject?)
                                        successBlock(mainInfoDetailsArray)
                                    }
                                    
                                }else if 401 == statusCode {
                                    DispatchQueue.main.async {
                                        self.moveToHomeScreen(kUnauthorizedError)
                                    }
                                } else {
                                    
                                    
                                    if Utilities.sharedInstance.isObjectNull(json as AnyObject?) {
                                        
                                        if let statusMessage = json["message"] as? String{
                                            
                                            DispatchQueue.main.async {
                                                failureBlock(true)
                                                self.ShowError(viewController, message: statusMessage)
                                            }
                                        }
                                    }
                                    
                                }
                                
                                
                                
                            }
                            
                        } catch let catchError as NSError {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: catchError.localizedDescription)
                            }
                        }
                        
                        
                    }else{
                        
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                    }
                    
                    
                    
                    
                })
                task.resume()
            }
        }else {
            
            ShowError()
        }
    }
    
    func getShipTypes(_ viewController: UIViewController, successBlock: @escaping (_ categories : Array<ShipViaTypeModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
        
        if isConnectionEshtablished() {
            
           
            
            do {
                
                viewController.showHud(kLoading)
         
                let endpoint: String = BASE_URL + API_GETSHIPVIATYPES
                
                let session = URLSession.shared
                
                let request = networkSharedInstance(endpoint)
                
                request?.httpMethod = "GET"
                
                
                let task = session.dataTask(with: request! as URLRequest, completionHandler: { data, response, error in
                    
                    viewController.hideHUD()
                    
                    guard error == nil else {
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                        return
                    }
                    
                    
                    guard let data = data else {
                        return
                    }
                    
                    // Checking here Response
                    if response != nil {
                        
                        viewController.hideHUD()
                        
                        let statusCode = (response as! HTTPURLResponse).statusCode
                        
                        
                        do {
                            //create json object from data
                            
                            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                                
                                
                                
                                
                                if 200...299 ~= statusCode {
                                    
                                    DispatchQueue.main.async {
                                        
                                        let shipViaTypeArray = NetworkResponseParser.sharedInstance.parseShipViaTypes(object: json as AnyObject?)
                                        successBlock(shipViaTypeArray)
                                    }
                                    
                                }else if 401 == statusCode {
                                    DispatchQueue.main.async {
                                        self.moveToHomeScreen(kUnauthorizedError)
                                    }
                                } else {
                                    
                                    
                                    if Utilities.sharedInstance.isObjectNull(json as AnyObject?) {
                                        
                                        if let statusMessage = json["message"] as? String{
                                            
                                            DispatchQueue.main.async {
                                                failureBlock(true)
                                                self.ShowError(viewController, message: statusMessage)
                                            }
                                        }
                                    }
                                    
                                }
                                
                                
                                
                            }
                            
                        } catch let catchError as NSError {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: catchError.localizedDescription)
                            }
                        }
                        
                        
                    }else{
                        
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                    }
                    
                    
                    
                    
                })
                task.resume()
            }
        }else {
            
            ShowError()
        }
    }
    
    
    func getPaymentDueInfo(_ viewController: UIViewController, successBlock: @escaping (_ paymentDueInfo : Array<MakePaymentModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
        
        if isConnectionEshtablished() {
            
            
            
            do {
                
                viewController.showHud(kLoading)
                
                
                var customerNumber = ""
                
                let credentials = Utilities.getUserNameAndPasswordFromLocalStorage()
                if let userName = credentials.userName {
                    customerNumber = userName
                }
                
                let endpoint: String = BASE_URL + API_GETPAYMENTSDUE + "/" + customerNumber
                
                let session = URLSession.shared
                
                let request = networkSharedInstance(endpoint)
                
                request?.httpMethod = "GET"
                
                
                let task = session.dataTask(with: request! as URLRequest, completionHandler: { data, response, error in
                    
                    viewController.hideHUD()
                    
                    guard error == nil else {
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                        return
                    }
                    
                    
                    guard let data = data else {
                        return
                    }
                    
                    // Checking here Response
                    if response != nil {
                        
                        viewController.hideHUD()
                        
                        let statusCode = (response as! HTTPURLResponse).statusCode
                        
                        
                        do {
                            //create json object from data
                            
                            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                                
                                
                                
                                
                                if 200...299 ~= statusCode {
                                    
                                    DispatchQueue.main.async {
                                        
                                        let paymentDuesArray = NetworkResponseParser.sharedInstance.parsePaymentDueInfo(object: json as AnyObject?)
                                        successBlock(paymentDuesArray)
                                    }
                                    
                                }else if 401 == statusCode {
                                    DispatchQueue.main.async {
                                        self.moveToHomeScreen(kUnauthorizedError)
                                    }
                                } else {
                                    
                                    
                                    if Utilities.sharedInstance.isObjectNull(json as AnyObject?) {
                                        
                                        if let statusMessage = json["message"] as? String{
                                            
                                            DispatchQueue.main.async {
                                                failureBlock(true)
                                                self.ShowError(viewController, message: statusMessage)
                                            }
                                        }
                                    }
                                    
                                }
                                
                                
                                
                            }
                            
                        } catch let catchError as NSError {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: catchError.localizedDescription)
                            }
                        }
                        
                        
                    }else{
                        
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                    }
                    
                    
                    
                    
                })
                task.resume()
            }
        }else {
            
            ShowError()
        }
    }
    
    func getCreditCardDetails(_ viewController: UIViewController,url : String, parameters: Dictionary<String, Any>, successBlock: @escaping (_ creditCards: Array<CreditCardModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
        
        if isConnectionEshtablished() {
            
            do {
                
                viewController.showHud(kLoading)
                
                let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                
                // create post request
                let endpoint: String = BASE_URL + url
                
                let session = URLSession.shared
                
                let request = networkSharedInstance(endpoint)
                
                request?.httpMethod = "POST"
                
                request?.httpBody = jsonData
                
                let task = session.dataTask(with: request! as URLRequest, completionHandler: { data, response, error in
                    
                    viewController.hideHUD()
                    
                    guard error == nil else {
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                        return
                    }
                    
                    guard let data = data else {
                        return
                    }
                    
                    
                    
                    // Checking here Response
                    if response != nil {
                        
                        viewController.hideHUD()
                        
                        let statusCode = (response as! HTTPURLResponse).statusCode
                        
                        
                        do {
                            //create json object from data
                            
                            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                                
                                
                                if 200...299 ~= statusCode {
                                    
                                    DispatchQueue.main.async {
                                        
                                        let creditCardsArray = NetworkResponseParser.sharedInstance.parseCreditCardDetails(object: json as AnyObject?)
                                        successBlock(creditCardsArray)
                                        
                                    }
                                    
                                }else if 401 == statusCode {
                                    DispatchQueue.main.async {
                                        self.moveToHomeScreen(kUnauthorizedError)
                                    }
                                } else {
                                    
                                    
                                    if Utilities.sharedInstance.isObjectNull(json as AnyObject?) {
                                        
                                        if let statusMessage = json["message"] as? String{
                                            
                                            DispatchQueue.main.async {
                                                failureBlock(true)
                                                //self.ShowError(viewController, message: statusMessage)
                                            }
                                        }
                                    }
                                    
                                }
                                
                                
                                
                            }
                            
                        } catch let catchError as NSError {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: catchError.localizedDescription)
                            }
                        }
                        
                        
                    }else{
                        
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                    }
                    
                })
                
                task.resume()
            } catch {
                print("parsing error")
            }
        }else {
            
            ShowError()
        }
    }
    
    //MARK: - POST API
    
    func postReferralCodeRequest(_ viewController: UIViewController,url : String, parameters: Dictionary<String,Any>, successBlock: @escaping (_ message: String , _ referredBy : String) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
        
        if isConnectionEshtablished() {
            
            do {
                
                viewController.showHud(kLoading)
                
                let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                
                // create post request
                let endpoint: String = BASE_URL + url
                
                let session = URLSession.shared
                
                let request = networkSharedInstance(endpoint)
                
                request?.httpMethod = "POST"
                
                request?.httpBody = jsonData
                
                let task = session.dataTask(with: request! as URLRequest, completionHandler: { data, response, error in
                    
                    viewController.hideHUD()
                    
                    guard error == nil else {
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                        return
                    }
                    
                    guard let data = data else {
                        return
                    }
                    
                    
                    // Checking here Response
                    if response != nil {
                        
                        viewController.hideHUD()
                        
                        let statusCode = (response as! HTTPURLResponse).statusCode
                        
                        
                        // Checking here Response Status
                        
                        do {
                            
                            //create json object from data
                            
                            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                                
                                if 200...299 ~= statusCode {
                                    
                                    DispatchQueue.main.async {
                                        
                              
                                        
                
                                        var referredBy = ""
                                        var status = ""
                                        
                                        if let statusMessageInfo = json["statusMessage"] as? NSDictionary{
                                            
                                            if let referredByName = statusMessageInfo["referredby"] as? String{
                                                referredBy = referredByName
                                            }
                                            
                                            if let statusMessage = statusMessageInfo["status"] as? String{
                                                status = statusMessage
                                            }
                                        }
                                        
                                        successBlock(status,referredBy)
                                    }
                                }else if 401 == statusCode {
                                    DispatchQueue.main.async {
                                        self.moveToHomeScreen(kUnauthorizedError)
                                    }
                                }else{
                                    
                                    
                                    
                                    if Utilities.sharedInstance.isObjectNull(json as AnyObject?) {
                                        
                                        if let statusMessage = json["message"] as? String{
                                            
                                            DispatchQueue.main.async {
                                                failureBlock(true)
                                                self.ShowError(viewController, message: statusMessage)
                                            }
                                        }
                                    }
                                    
                                }
                                
                                
                            }
                            
                        } catch let catchError as NSError {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: catchError.localizedDescription)
                            }
                        }
                        
                        
                    }else{
                        
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                    }
                    
                    
                    
                })
                task.resume()
            } catch {
                print("parsing error")
            }
        }else {
            
            ShowError()
        }
    }
    
    func getOrdersAndInvoices(_ viewController: UIViewController,url : String, successBlock: @escaping (_ invoiceModel : Array<OrderAndInvoiceModel>, _ pageInfo : Dictionary<String,Any>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
        
        if isConnectionEshtablished() {
            
            
            
            do {
                
                viewController.showHud(kLoading)
                
                
                // create post request
                let endpoint: String = BASE_URL + url
                
                let session = URLSession.shared
                
                let request = networkSharedInstance(endpoint)
                
                request?.httpMethod = "GET"
                
                
                let task = session.dataTask(with: request! as URLRequest, completionHandler: { data, response, error in
                    
                    viewController.hideHUD()
                    
                    guard error == nil else {
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                        return
                    }
                    
                    guard let data = data else {
                        return
                    }
                    
                    // Checking here Response
                    if response != nil {
                        
                        
                        viewController.hideHUD()
                        let statusCode = (response as! HTTPURLResponse).statusCode
                        
                        
                        do {
                            //create json object from data
                            
                            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                                
                                
                                
                                
                                if 200...299 ~= statusCode {
                                    
                                    DispatchQueue.main.async {
                                        
                                        let parseOrdersAndInvoicesArray = NetworkResponseParser.sharedInstance.parseOrdersAndInvoices(object: json as AnyObject?)
                                        
                                        var params = Dictionary<String,Any>()
                                        if let totalPages = json["totalPages"] as? Int{
                                            params.updateValue(totalPages, forKey: "totalPages")
                                        }
                                        if let totalPages = json["pageIndex"] as? Int{
                                            params.updateValue(totalPages, forKey: "pageIndex")
                                        }
                                        if let totalPages = json["totalRecords"] as? Int{
                                            params.updateValue(totalPages, forKey: "totalRecords")
                                        }
                                        if let statusMessage = json["statusMessage"] as? String{
                                            params.updateValue(statusMessage, forKey: "statusMessage")
                                        }
                                        
                                        successBlock(parseOrdersAndInvoicesArray,params)
                                    }
                                    
                                }else if 401 == statusCode {
                                    DispatchQueue.main.async {
                                        self.moveToHomeScreen(kUnauthorizedError)
                                    }
                                } else {
                                    
                                    
                                    if Utilities.sharedInstance.isObjectNull(json as AnyObject?) {
                                        
                                        if let statusMessage = json["message"] as? String{
                                            
                                            DispatchQueue.main.async {
                                                failureBlock(true)
                                                self.ShowError(viewController, message: statusMessage)
                                            }
                                        }
                                    }
                                    
                                }
                                
                                
                                
                            }
                            
                        } catch let catchError as NSError {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: catchError.localizedDescription)
                            }
                        }
                        
                        
                    }else{
                        
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                    }
                    
                    
                    
                    
                })
                task.resume()
            }
        }else {
            
            ShowError()
        }
    }
    
    func getCountForOrdersAndInvoices(_ viewController: UIViewController,url : String, successBlock: @escaping (_ invoiceModel : Array<OrderAndInvoiceModel>, _ pageInfo : Dictionary<String,Any>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
        
        if isConnectionEshtablished() {
            
            
            
            do {
                
 
                
                
                // create post request
                let endpoint: String = BASE_URL + url
                
                let session = URLSession.shared
                
                let request = networkSharedInstance(endpoint)
                
                request?.httpMethod = "GET"
                
                
                let task = session.dataTask(with: request! as URLRequest, completionHandler: { data, response, error in
                    
 
                    
                    guard error == nil else {
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                        return
                    }
                    
                    guard let data = data else {
                        return
                    }
                    
                    // Checking here Response
                    if response != nil {
                        
                        
            
                        let statusCode = (response as! HTTPURLResponse).statusCode
                        
                        
                        do {
                            //create json object from data
                            
                            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                                
                                
                                
                                
                                if 200...299 ~= statusCode {
                                    
                                    DispatchQueue.main.async {
                                        
                                        let parseOrdersAndInvoicesArray = NetworkResponseParser.sharedInstance.parseOrdersAndInvoices(object: json as AnyObject?)
                                        
                                        var params = Dictionary<String,Any>()
                                        if let totalPages = json["totalPages"] as? Int{
                                            params.updateValue(totalPages, forKey: "totalPages")
                                        }
                                        if let totalPages = json["pageIndex"] as? Int{
                                            params.updateValue(totalPages, forKey: "pageIndex")
                                        }
                                        if let totalPages = json["totalRecords"] as? Int{
                                            params.updateValue(totalPages, forKey: "totalRecords")
                                        }
                                        if let statusMessage = json["statusMessage"] as? String{
                                            params.updateValue(statusMessage, forKey: "statusMessage")
                                        }
                                        
                                        successBlock(parseOrdersAndInvoicesArray,params)
                                    }
                                    
                                }else if 401 == statusCode {
                                    DispatchQueue.main.async {
                                        self.moveToHomeScreen(kUnauthorizedError)
                                    }
                                } else {
                                    
                                    
                                    if Utilities.sharedInstance.isObjectNull(json as AnyObject?) {
                                        
                                        if let statusMessage = json["message"] as? String{
                                            
                                            DispatchQueue.main.async {
                                                failureBlock(true)
                                                //self.ShowError(viewController, message: statusMessage)
                                            }
                                        }
                                    }
                                    
                                }
                                
                                
                                
                            }
                            
                        } catch let catchError as NSError {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: catchError.localizedDescription)
                            }
                        }
                        
                        
                    }else{
                        
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                    }
                    
                    
                    
                    
                })
                task.resume()
            }
        }else {
            
            ShowError()
        }
    }
    
    
    func getOrdersAndInvoiceDetails(_ viewController: UIViewController,url : String, successBlock: @escaping (_ invoiceModel : Array<ListOrdersModel>, _ pageInfo : Dictionary<String,Any>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
        
        if isConnectionEshtablished() {
            
            
            
            do {
                
                viewController.showHud(kLoading)
                
                
                // create post request
                let endpoint: String = BASE_URL + url
                
                let session = URLSession.shared
                
                let request = networkSharedInstance(endpoint)
                
                request?.httpMethod = "GET"
                
                
                let task = session.dataTask(with: request! as URLRequest, completionHandler: { data, response, error in
                    
                    viewController.hideHUD()
                    
                    guard error == nil else {
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                        return
                    }
                    
                    guard let data = data else {
                        return
                    }
                    
                    // Checking here Response
                    if response != nil {
                        
                        
                        viewController.hideHUD()
                        let statusCode = (response as! HTTPURLResponse).statusCode
                        
                        
                        do {
                            //create json object from data
                            
                            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                                
                                
                                
                                
                                if 200...299 ~= statusCode {
                                    
                                    DispatchQueue.main.async {
                                        
                                        let parseOrdersAndInvoiceDetailsArray = NetworkResponseParser.sharedInstance.parseOrdersAndInvoiceDetails(object: json as AnyObject?)
                                        
                                        var params = Dictionary<String,Any>()
                                        if let totalPages = json["totalPages"] as? Int{
                                            params.updateValue(totalPages, forKey: "totalPages")
                                        }
                                        if let totalPages = json["pageIndex"] as? Int{
                                            params.updateValue(totalPages, forKey: "pageIndex")
                                        }
                                        if let totalPages = json["totalRecords"] as? Int{
                                            params.updateValue(totalPages, forKey: "totalRecords")
                                        }
                                        if let statusMessage = json["statusMessage"] as? String{
                                            params.updateValue(statusMessage, forKey: "statusMessage")
                                        }
                                        
                                        successBlock(parseOrdersAndInvoiceDetailsArray,params)
                                    }
                                    
                                }else if 401 == statusCode {
                                    DispatchQueue.main.async {
                                        self.moveToHomeScreen(kUnauthorizedError)
                                    }
                                } else {
                                    
                                    
                                    if Utilities.sharedInstance.isObjectNull(json as AnyObject?) {
                                        
                                        if let statusMessage = json["message"] as? String{
                                            
                                            DispatchQueue.main.async {
                                                failureBlock(true)
                                                self.ShowError(viewController, message: statusMessage)
                                            }
                                        }
                                    }
                                    
                                }
                                
                                
                                
                            }
                            
                        } catch let catchError as NSError {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: catchError.localizedDescription)
                            }
                        }
                        
                        
                    }else{
                        
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                self.ShowError(viewController, message: errorDescription)
                            }
                        }
                    }
                    
                    
                    
                    
                })
                task.resume()
            }
        }else {
            
            ShowError()
        }
    }
    
    //MARK: - Search For Items API
    
    /*      func searchForItem(_ viewController: UIViewController, parameters: Dictionary<String, Any>, successBlock: @escaping (_ itemDetails : Array<ItemDetailsModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     let url = BASE_URL + API_SEARCH_ITEM
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: { (sessionDataTask, response) in
     
     viewController.hideHUD()
     let itemDetailsArray = NetworkResponseParser.sharedInstance.parseItemDetails(object: response as AnyObject)
     successBlock(itemDetailsArray)
     
     if itemDetailsArray.count > 0 {
     
     Utilities.showToast(viewController.view, text: "\(itemDetailsArray.count) item(s) found")
     }
     
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     func searchForRep(_ viewController: UIViewController, parameters: Dictionary<String, Any>, successBlock: @escaping (_ repDetails : Array<RepModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     let url = BASE_URL + API_SEARCHFORREP
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: { (sessionDataTask, response) in
     
     viewController.hideHUD()
     let repDetailsArray = NetworkResponseParser.sharedInstance.parseRepDetails(object: response as AnyObject)
     successBlock(repDetailsArray)
     
     
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     func changeRepForQuote(_ viewController: UIViewController, parameters: Dictionary<String, Any>, successBlock: @escaping (_ json : Any?) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     let url = BASE_URL + API_CHANGEREPFORQUOTE
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: { (sessionDataTask, response) in
     
     viewController.hideHUD()
     successBlock(response)
     
     
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     func getItemCategories(_ viewController: UIViewController, successBlock: @escaping (_ categories : Array<CategoriesModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     var userId = ""
     let credentials = Utilities.getUserNameAndPasswordFromLocalStorage()
     if let userName = credentials.userName {
     userId = userName
     }
     let url = BASE_URL + API_GET_CATEGORIES_MENU + "/" + userId
     
     sessionManager.get(url, parameters: nil, progress: nil, success: { (sessionDataTask, response) in
     
     viewController.hideHUD()
     let categories = NetworkResponseParser.sharedInstance.parseCategories(object: response as AnyObject)
     successBlock(categories)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     //MARK: - Get Sub Categories API
     
     func fetchSubCategories(_ viewController: UIViewController, parameters: [String : AnyObject]?, successBlock: @escaping (_ itemDetails : Array<SubCategoriesModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     let url = BASE_URL + API_GET_SUB_CATEGORIES
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: { (sessionDataTask, response) in
     
     viewController.hideHUD()
     let subCategories = NetworkResponseParser.sharedInstance.parseSubCategories(object: response as AnyObject?)
     successBlock(subCategories)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     //MARK: - Get Item Details API
     
     func getItemDetails(_ viewController: UIViewController, url: String, successBlock: @escaping (_ categories: Array<ItemDetailsModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     sessionManager.get(url, parameters: nil, progress: nil, success: { (task, response) in
     
     viewController.hideHUD()
     let itemDetails = NetworkResponseParser.sharedInstance.parseItemDetails(object: response as AnyObject?)
     successBlock(itemDetails)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     //MARK: - Get Item Groups API
     
     func getItemGroups(_ viewController: UIViewController, parameters: NSDictionary, successBlock: @escaping (_ itemGroups: Array<GroupsModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     let url = BASE_URL + API_GET_ITEM_GROUPS
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: { (sessionDataTask, response) in
     
     viewController.hideHUD()
     let itemGroupsArray = NetworkResponseParser.sharedInstance.parseItemGroups(object: response as AnyObject?)
     successBlock(itemGroupsArray)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     //MARK: - Get More About Item API
     
     func getMoreAboutItem(_ viewController: UIViewController, parameters: Dictionary<String, Any>, successBlock: @escaping (_ itemGroups: Array<ItemMoreModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     let url = BASE_URL + API_GET_ITEMS_BY_FILTERS
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: { (sessionDataTask, response) in
     
     viewController.hideHUD()
     let itemMoreArray = NetworkResponseParser.sharedInstance.parseItemMore(object: response as AnyObject?)
     successBlock(itemMoreArray)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     func getMoreAboutGroup(_ viewController: UIViewController, parameters: Dictionary<String, Any>, successBlock: @escaping (_ itemGroups: Array<ItemDetailsModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     let url = BASE_URL + API_GET_ITEMS_BY_FILTERS
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: { (sessionDataTask, response) in
     
     viewController.hideHUD()
     let itemDetailsArray = NetworkResponseParser.sharedInstance.parseGroup(object: response as AnyObject?)
     successBlock(itemDetailsArray)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     //MARK: - Get Catalogs API
     
     func getCatalogs(_ viewController: UIViewController, successBlock: @escaping (_ catalogs: Array<CatalogsModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     let url = BASE_URL + API_GET_CATALOGS
     
     sessionManager.get(url, parameters: nil, progress: nil, success: { (task, response) in
     
     viewController.hideHUD()
     let catalogs = NetworkResponseParser.sharedInstance.parseCatalogs(object: response as AnyObject?)
     successBlock(catalogs)
     
     if catalogs.count > 0 {
     
     Utilities.showToast(viewController.view, text: "\(catalogs.count) catalog(s) found")
     }
     
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     //MARK: - Search Customer For Quotes API
     
     func searchCustomerForQuotes(_ viewController: UIViewController, parameters: NSDictionary, successBlock: @escaping (_ customers: Array<SearchCustomerForQuotesModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     let url = BASE_URL + API_SEARCH_CUSTOMER_FOR_QUOTES
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: { (sessionDataTask, response) in
     viewController.hideHUD()
     let customerArray = NetworkResponseParser.sharedInstance.parseCustomerForQuotes(object: response as AnyObject?)
     successBlock(customerArray)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     //MARK: - Get Existing Quotes API
     
     func getExistingQuotes(_ viewController: UIViewController, parameters: NSDictionary, successBlock: @escaping (_ customers: Array<ExistingQuotesModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     let url = BASE_URL + API_DISPLAY_EXSTINING_QUOTES
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: { (sessionDataTask, response) in
     
     viewController.hideHUD()
     let existingQuotesArray = NetworkResponseParser.sharedInstance.parseExistingQuotes(object: response as AnyObject?)
     successBlock(existingQuotesArray)
     
     if existingQuotesArray.count > 0 {
     
     Utilities.showToast(viewController.view, text: "\(existingQuotesArray.count) quote(s) found")
     }
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     //MARK: - Get Buyers API
     
     func getBuyers(_ viewController: UIViewController, customerNumber: String, successBlock: @escaping (_ buyers: Array<String>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     if(SVProgressHUD.isVisible() == false){
     viewController.showHud(kLoading)
     }
     let url = BASE_URL + API_GET_BUYERS + customerNumber
     
     sessionManager.get(url, parameters: nil, progress: nil, success: { (task, response) in
     
     //viewController.hideHUD()
     
     let buyersArray = NetworkResponseParser.sharedInstance.parseBuyers(object: response as AnyObject?)
     successBlock(buyersArray)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     //MARK: - Get States API
     
     func getStates(_ viewController: UIViewController, successBlock: @escaping (_ states: Array<StatesModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     let url = BASE_URL + API_GET_STATES
     
     sessionManager.get(url, parameters: nil, progress: nil, success: { (task, response) in
     
     viewController.hideHUD()
     let statesArray = NetworkResponseParser.sharedInstance.parseStates(object: response as AnyObject?)
     successBlock(statesArray)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     //MARK: - Get FrieghtTerms API
     
     func getFrieghtTerms(_ viewController: UIViewController, successBlock: @escaping (_ frieghtTerms: Array<FreightTermsModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     if(SVProgressHUD.isVisible() == false){
     viewController.showHud(kLoading)
     }
     let url = BASE_URL + API_GETFREIGHTTERMS
     
     sessionManager.get(url, parameters: nil, progress: nil, success: { (task, response) in
     
     let frieghtTermsArray = NetworkResponseParser.sharedInstance.parseFreightTypes(object: response as AnyObject?)
     successBlock(frieghtTermsArray)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     //MARK: - Get Claim Subcodes API
     
     func getClaimSubcodes(_ viewController: UIViewController, url: String, successBlock: @escaping (_ subcodes: Array<ClaimSubcodeModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     
     viewController.showHud(kLoading)
     
     
     
     sessionManager.get(url, parameters: nil, progress: nil, success: { (task, response) in
     viewController.hideHUD()
     let subCodesArray = NetworkResponseParser.sharedInstance.parseClaimSubCodeTypes(object: response as AnyObject?)
     successBlock(subCodesArray)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     //MARK: - Get PaymentTerms API
     
     func getPaymentTerms(_ viewController: UIViewController, successBlock: @escaping (_ paymentTerms: Array<PaymentTermsModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     if(SVProgressHUD.isVisible() == false){
     viewController.showHud(kLoading)
     }
     let url = BASE_URL + API_GETPAYMENTTERMS
     
     sessionManager.get(url, parameters: nil, progress: nil, success: { (task, response) in
     
     viewController.hideHUD()
     let paymentTermsArray = NetworkResponseParser.sharedInstance.parsePaymentTypes(object: response as AnyObject?)
     successBlock(paymentTermsArray)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     //MARK: - Get Coutries API
     
     func getCountries(_ viewController: UIViewController, successBlock: @escaping (_ countries: Array<CountryModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     let url = BASE_URL + API_GET_COUNTRIES
     
     sessionManager.get(url, parameters: nil, progress: nil, success: { (task, response) in
     
     viewController.hideHUD()
     let countriesArray = NetworkResponseParser.sharedInstance.parseCountries(object: response as AnyObject?)
     successBlock(countriesArray)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     //MARK: - Get Quotes For List API
     
     func getQuotesForList(_ viewController: UIViewController, successBlock: @escaping (_ quotes: Array<QuotesForListModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     let url = BASE_URL + API_GET_QUOTE_FOR_LIST
     
     sessionManager.get(url, parameters: nil, progress: nil, success: { (task, response) in
     
     viewController.hideHUD()
     let quotesArray = NetworkResponseParser.sharedInstance.parseQuotesForList(object: response as AnyObject?)
     successBlock(quotesArray)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     //MARK: - Get Showrooms API
     
     func getShowrooms(_ viewController: UIViewController, successBlock: @escaping (_ showrooms: Array<ShowRoomsModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     let url = BASE_URL + API_GET_QUOTE_FOR_LIST
     
     sessionManager.get(url, parameters: nil, progress: nil, success: { (task, response) in
     
     viewController.hideHUD()
     let showroomsArray = NetworkResponseParser.sharedInstance.parseShowRooms(object: response as AnyObject?)
     successBlock(showroomsArray)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     //MARK: - Insert Update Quotes API
     
     func insertUpdateQuotes(_ viewController: UIViewController, parameters: [String : AnyObject]?, url: String, successBlock: @escaping (_ quoteNumber: Int) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: { (sessionDataTask, response) in
     
     viewController.hideHUD()
     let data = NetworkResponseParser.sharedInstance.parseInsertUpdateQuotes(object: response as AnyObject?)
     successBlock(data)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     //MARK: - Get Quote Item Details API
     
     func getQuoteItemDetails(_ viewController: UIViewController, parameters: NSDictionary, successBlock: @escaping (_ itemDetails: Array<QuoteItemDetailsModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     let url = BASE_URL + API_GET_QUOTE_ITEM_DETAILS
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: { (sessionDataTask, response) in
     
     viewController.hideHUD()
     let itemDetailsArray = NetworkResponseParser.sharedInstance.parseQuoteItemDetails(object: response as AnyObject?)
     successBlock(itemDetailsArray)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     func getCustomerItemDetails(_ viewController: UIViewController, parameters: Dictionary<String, Any>, successBlock: @escaping (_ customerItemDetails: Array<CustomerAddItemModel>) -> Void, failureBlock: @escaping (_ fail : Bool, _ message: String) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     
     let url = BASE_URL + API_GETORDERINFO
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: { (sessionDataTask, response) in
     
     let customerItemDetailsArray = NetworkResponseParser.sharedInstance.parseCustomerItemDetails(object: response as AnyObject?)
     successBlock(customerItemDetailsArray)
     
     }, failure: { (sessionDataTask, error) in
     
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     var statusMsg = ""
     if let data =  (error as NSError).userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey]{
     if let statusesDict = try? JSONSerialization.jsonObject(with: data as! Data, options: .allowFragments) as? [String: Any]{
     statusMsg = (statusesDict?["statusMessage"] as? String)!
     }
     
     }
     print(error)
     viewController.hideHUD()
     //self.ShowErrorInfo(viewController, error: error)
     failureBlock(true,statusMsg)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     
     
     })
     }
     }
     
     
     func getTotalOrderDetails(_ viewController: UIViewController, parameters: Dictionary<String, Any>, successBlock: @escaping (_ totalOrdersDetails: Array<TotalOrdersModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     if(SVProgressHUD.isVisible() == false){
     viewController.showHud(kLoading)
     }
     
     let url = BASE_URL + API_GETTOTALCATEGORIES
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: { (sessionDataTask, response) in
     
     viewController.hideHUD()
     
     let totalOrdersModelArray = NetworkResponseParser.sharedInstance.parseTotalOrderDetails(object: response as AnyObject?)
     
     successBlock(totalOrdersModelArray)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     func insertCustomerItemDetails(_ viewController: UIViewController, parameters:Dictionary<String, Any>, successBlock: @escaping (_ itemStatus: String) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     
     let url = BASE_URL + API_INSERTUPDATEORDERITEMS
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: { (sessionDataTask, response) in
     
     let status = NetworkResponseParser.sharedInstance.parseInsertUpdateQuoteItem(object: response as AnyObject?)
     
     successBlock(status)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     
     
     //MARK: - Insert Update Quote Items API
     
     func insertUpdateQuoteItems(_ viewController: UIViewController, parameters:Dictionary<String, Any>, successBlock: @escaping (_ itemStatus: String) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     
     viewController.showHud(kLoading)
     
     
     let url = BASE_URL + API_INSERT_UPDATE_QUOTE_ITEM
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: { (sessionDataTask, response) in
     
     viewController.hideHUD()
     let status = NetworkResponseParser.sharedInstance.parseInsertUpdateQuoteItem(object: response as AnyObject?)
     successBlock(status)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     //MARK: - Delete Quote Items API
     
     func deleteQuoteItems(_ viewController: UIViewController, parameters: NSDictionary, areMultipleItems: Bool, successBlock: @escaping (_ itemStatus: String) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     var url = ""
     
     areMultipleItems == true ? (url = BASE_URL + API_DELETE_MULTIPLE_QUOTE_ITEMS) : (url = BASE_URL + API_DELETE_QUOTE_ITEM)
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: { (sessionDataTask, response) in
     
     viewController.hideHUD()
     let status = NetworkResponseParser.sharedInstance.parseInsertUpdateQuoteItem(object: response as AnyObject?)
     successBlock(status)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     //MARK: - Get Quote Items API
     
     func getQuoteItems(_ viewController: UIViewController, parameters: [String : AnyObject]?, url: String, successBlock: @escaping (_ states: Array<QuoteItemModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: { (sessionDataTask, response) in
     
     viewController.hideHUD()
     let quoteItemsArray = NetworkResponseParser.sharedInstance.parseQuoteItems(object: response as AnyObject?)
     successBlock(quoteItemsArray)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     //MARK: - Get Quote For Value API
     
     func getQuoteForValue(_ viewController: UIViewController, url: String, successBlock: @escaping (_ quoteValues: Array<QuoteForValuesModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     if(SVProgressHUD.isVisible() == false){
     viewController.showHud(kLoading)
     }
     
     sessionManager.get(url, parameters: nil, progress: nil, success: { (task, response) in
     
     
     let quoteForValuesArray = NetworkResponseParser.sharedInstance.parseQuoteForValues(object: response as AnyObject?)
     successBlock(quoteForValuesArray)
     
     }, failure: { (task, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (task?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     
     //MARK: - Get Quote Header API
     
     func getQuoteHeader(_ viewController: UIViewController, url: String, successBlock: @escaping (_ states: Array<QuoteHeaderModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     sessionManager.get(url, parameters: nil, progress: nil, success: { (task, response) in
     
     viewController.hideHUD()
     let quoteHeaderArray = NetworkResponseParser.sharedInstance.parseQuoteHeader(object: response as AnyObject?)
     successBlock(quoteHeaderArray)
     
     }, failure: { (task, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (task?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     //MARK: - Get Currents Specials API
     
     func getCurrentSpecials(_ viewController: UIViewController, url: String, successBlock: @escaping (_ specialsArray: Array<SpecialsModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     sessionManager.get(url, parameters: nil, progress: nil, success: { (task, response) in
     
     viewController.hideHUD()
     let specialsArray = NetworkResponseParser.sharedInstance.parseCurrentSpecials(object: response as AnyObject?)
     successBlock(specialsArray)
     
     }, failure: { (task, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (task?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     //MARK: - Get Customer Billing Address API
     
     func getCustomerBillingAddress(_ viewController: UIViewController, url: String, successBlock: @escaping (_ addresses: Array<BillingAddressModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     sessionManager.get(url, parameters: nil, progress: nil, success: { (task, response) in
     
     viewController.hideHUD()
     let addressesArray = NetworkResponseParser.sharedInstance.parseCustomerBillingAddress(object: response as AnyObject?)
     successBlock(addressesArray)
     
     }, failure: { (task, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (task?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     
     //MARK: - -----------------------------------------
     //MARK:       >>>>>>>>>>> PHASE II <<<<<<<<<<<
     //MARK:   -----------------------------------------
     
     //MARK: - Search Customers API
     
     func postRequest(_ viewController: UIViewController, url: String, parameters: Dictionary<String, Any>, successBlock: @escaping (_ jsonData: Any?) -> Void, failureBlock: @escaping(_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     
     if(SVProgressHUD.isVisible() == false){
     viewController.showHud(kLoading)
     }
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: {(task, response) in
     
     
     viewController.hideHUD()
     successBlock(response)
     
     }, failure: { [weak self] (task, error) in
     
     guard let strongSelf = self else { return }
     print(error)
     viewController.hideHUD()
     if let code = (task?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     strongSelf.moveToHomeScreen(kUnauthorizedError)
     }else{
     strongSelf.ShowErrorInfo(viewController, error: error)
     }
     }else{
     strongSelf.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     
     })
     }
     }
     
     func getRequest(_ viewController: UIViewController, url: String, successBlock: @escaping (_ jsonData: Any?) -> Void, failureBlock: @escaping(_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     sessionManager.get(url, parameters: nil, progress: nil, success: { (task, response) in
     viewController.hideHUD()
     successBlock(response)
     
     }, failure: { [weak self] (task, error) in
     
     guard let strongSelf = self else { return }
     print(error)
     viewController.hideHUD()
     if let code = (task?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     strongSelf.moveToHomeScreen(kUnauthorizedError)
     }else{
     strongSelf.ShowErrorInfo(viewController, error: error)
     }
     }else{
     strongSelf.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     
     
     })
     }
     }
     func downloadImagePostRequest(_ viewController: UIViewController, url: String,parameters: Dictionary<String, Any>, successBlock: @escaping (_ customerItemDetails: Array<ImageDownloadModel>) -> Void, failureBlock: @escaping(_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     if(SVProgressHUD.isVisible() == false){
     viewController.showHud(kLoading)
     }
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: {(task, response) in
     
     
     let imagessArray = NetworkResponseParser.sharedInstance.parseImageResponse(object: response as AnyObject?)
     successBlock(imagessArray)
     
     }, failure: { [weak self] (task, error) in
     
     guard let strongSelf = self else { return }
     print(error)
     viewController.hideHUD()
     if let code = (task?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     strongSelf.moveToHomeScreen(kUnauthorizedError)
     }else{
     //strongSelf.ShowErrorInfo(viewController, error: error)
     }
     }
     failureBlock(true)
     
     
     })
     }
     }
     
     func getClaimRequest(_ viewController: UIViewController, url: String, successBlock: @escaping (_ jsonData: Any?) -> Void, failureBlock: @escaping(_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     sessionManager.get(url, parameters: nil, progress: nil, success: { (task, response) in
     successBlock(response)
     
     }, failure: { [weak self] (task, error) in
     
     guard let strongSelf = self else { return }
     print(error)
     viewController.hideHUD()
     if let code = (task?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     strongSelf.moveToHomeScreen(kUnauthorizedError)
     }else{
     strongSelf.ShowErrorInfo(viewController, error: error)
     }
     }else{
     strongSelf.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     
     
     })
     }
     }
     
     func postCountSheetRequest(_ viewController: UIViewController, url: String, parameters: Dictionary<String, Any>, successBlock: @escaping (_ jsonData: Any?) -> Void, failureBlock: @escaping(_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: {(task, response) in
     viewController.hideHUD()
     successBlock(response)
     
     }, failure: {[weak self] (task, error) in
     
     guard let strongSelf = self else { return }
     print(error)
     viewController.hideHUD()
     if let code = (task?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     strongSelf.moveToHomeScreen(kUnauthorizedError)
     }else{
     strongSelf.ShowErrorInfo(viewController, error: error)
     }
     }else{
     strongSelf.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     
     //MARK: - Update Rep Favorites API
     
     func updateRepFavorites(_ viewController: UIViewController, url: String, parameters: Dictionary<String, Any>, successBlock: @escaping (_ jsonData: Any?) -> Void, failureBlock: @escaping(_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: {(task, response) in
     viewController.hideHUD()
     successBlock(response)
     
     }, failure: { [weak self] (task, error) in
     
     guard let strongSelf = self else { return }
     print(error)
     viewController.hideHUD()
     if let code = (task?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     strongSelf.moveToHomeScreen(kUnauthorizedError)
     }else{
     strongSelf.ShowErrorInfo(viewController, error: error)
     }
     }else{
     strongSelf.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     
     
     // MARK Insert Order API
     
     func insertOrderRequest(_ viewController: UIViewController, url: String, parameters: Dictionary<String, Any>, successBlock: @escaping (_ jsonData: Any?) -> Void, failureBlock: @escaping(_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: {(task, response) in
     viewController.hideHUD()
     successBlock(response)
     
     }, failure: { [weak self] (task, error) in
     
     guard let strongSelf = self else { return }
     print(error)
     viewController.hideHUD()
     if let code = (task?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     strongSelf.moveToHomeScreen(kUnauthorizedError)
     }else{
     strongSelf.ShowErrorInfo(viewController, error: error)
     }
     }else{
     strongSelf.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     // MARK Insert Order API
     
     func deleteOrderRequest(_ viewController: UIViewController, url: String, parameters: [[String: Any]], successBlock: @escaping (_ jsonData: Any?) -> Void, failureBlock: @escaping(_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: {(task, response) in
     viewController.hideHUD()
     successBlock(response)
     
     }, failure: { [weak self] (task, error) in
     
     guard let strongSelf = self else { return }
     print(error)
     viewController.hideHUD()
     if let code = (task?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     strongSelf.moveToHomeScreen(kUnauthorizedError)
     }else{
     strongSelf.ShowErrorInfo(viewController, error: error)
     }
     }else{
     strongSelf.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     
     
     })
     }
     }
     
     
     func getOrderItemsDetails(_ viewController: UIViewController, parameters: Dictionary<String, Any>, successBlock: @escaping (_ customerItemDetails: Array<CustomerViewModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     let url = BASE_URL + API_GETORDERITEMS
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: { (sessionDataTask, response) in
     
     viewController.hideHUD()
     let customerOrderItemsDetailsArray = NetworkResponseParser.sharedInstance.parseCustomerOrderItemsDetails(object: response as AnyObject?)
     successBlock(customerOrderItemsDetailsArray)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     
     func insertDeleteFavoriteRequest(_ viewController: UIViewController, url: String, parameters: Dictionary<String, Any>, successBlock: @escaping (_ jsonData: Any?) -> Void, failureBlock: @escaping(_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: {(task, response) in
     viewController.hideHUD()
     successBlock(response)
     
     }, failure: { [weak self] (task, error) in
     
     guard let strongSelf = self else { return }
     print(error)
     viewController.hideHUD()
     if let code = (task?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     strongSelf.moveToHomeScreen(kUnauthorizedError)
     }else{
     strongSelf.ShowErrorInfo(viewController, error: error)
     }
     }else{
     strongSelf.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     
     func getCustomerOrderViewDetails(_ viewController: UIViewController, parameters: Dictionary<String, Any>, successBlock: @escaping (_ customerItemDetails: Array<CustomerViewOrderDetailInfoModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     let url = BASE_URL + API_GETHEADERINFORMATION
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: { (sessionDataTask, response) in
     
     viewController.hideHUD()
     let customerOrderItemsDetailsArray = NetworkResponseParser.sharedInstance.parseCustomerViewOrderDetails(object: response as AnyObject?)
     successBlock(customerOrderItemsDetailsArray)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     
     func getAddressDetails(_ viewController: UIViewController, parameters: Dictionary<String, Any>, successBlock: @escaping (_ customerItemDetails: Array<CustomerLookUpAddressModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     let url = BASE_URL + API_GETCUSTOMERADDRESSES
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: { (sessionDataTask, response) in
     
     viewController.hideHUD()
     let customerItemDetailsArray = NetworkResponseParser.sharedInstance.parseAddressDetails(object: response as AnyObject?)
     successBlock(customerItemDetailsArray)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     
     func getClaimsAddressDetails(_ viewController: UIViewController, parameters: Dictionary<String, Any>, successBlock: @escaping (_ customerItemDetails: Array<CustomerLookUpAddressModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     
     
     let url = BASE_URL + API_GETCUSTOMERADDRESSES
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: { (sessionDataTask, response) in
     
     
     let customerItemDetailsArray = NetworkResponseParser.sharedInstance.parseClaimAddressDetails(object: response as AnyObject?)
     successBlock(customerItemDetailsArray)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     
     func getClaimsAddress(_ viewController: UIViewController, parameters: Dictionary<String, Any>, successBlock: @escaping (_ customerItemDetails: Array<CustomerLookUpAddressModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     
     
     let url = BASE_URL + API_GETCUSTOMERADDRESSES
     viewController.showHud(kLoading)
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: { (sessionDataTask, response) in
     
     viewController.hideHUD()
     let customerItemDetailsArray = NetworkResponseParser.sharedInstance.parseClaimAddressDetails(object: response as AnyObject?)
     successBlock(customerItemDetailsArray)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     
     func deleteCustomerContact(_ viewController: UIViewController, url: String, parameters: Dictionary<String, Any>, successBlock: @escaping (_ jsonData: Any?) -> Void, failureBlock: @escaping(_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: {(task, response) in
     viewController.hideHUD()
     successBlock(response)
     
     }, failure: { [weak self] (task, error) in
     
     guard let strongSelf = self else { return }
     print(error)
     viewController.hideHUD()
     if let code = (task?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     strongSelf.moveToHomeScreen(kUnauthorizedError)
     }else{
     strongSelf.ShowErrorInfo(viewController, error: error)
     }
     }else{
     strongSelf.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     func getAddressTypes(_ viewController: UIViewController, successBlock: @escaping (_ address: Array<AddressTypeModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     
     let url = BASE_URL + API_GETADDRESSTYPES
     
     sessionManager.get(url, parameters: nil, progress: nil, success: { (task, response) in
     
     let addressArray = NetworkResponseParser.sharedInstance.parseAddressTypes(object: response as AnyObject?)
     successBlock(addressArray)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     func getContactTypes(_ viewController: UIViewController, successBlock: @escaping (_ contacts: Array<ContactTypeModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     let url = BASE_URL + API_GETCONTACTTYPES
     
     sessionManager.get(url, parameters: nil, progress: nil, success: { (task, response) in
     
     viewController.hideHUD()
     let contactsArray = NetworkResponseParser.sharedInstance.parseContactTypes(object: response as AnyObject?)
     successBlock(contactsArray)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     func getShipViaTypes(_ viewController: UIViewController, successBlock: @escaping (_ states: Array<ShipViaTypeModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     let url = BASE_URL + API_GETSHIPVIATYPES
     
     sessionManager.get(url, parameters: nil, progress: nil, success: { (task, response) in
     
     viewController.hideHUD()
     let shipViaTypeArray = NetworkResponseParser.sharedInstance.parseShipViaTypes(object: response as AnyObject?)
     successBlock(shipViaTypeArray)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     func insertOrUpdateAddress(_ viewController: UIViewController, url: String, parameters: Dictionary<String, Any>, successBlock: @escaping (_ jsonData: Any?) -> Void, failureBlock: @escaping(_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: {(task, response) in
     viewController.hideHUD()
     successBlock(response)
     
     }, failure: { [weak self] (task, error) in
     
     guard let strongSelf = self else { return }
     print(error)
     viewController.hideHUD()
     if let code = (task?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     strongSelf.moveToHomeScreen(kUnauthorizedError)
     }else{
     strongSelf.ShowErrorInfo(viewController, error: error)
     }
     }else{
     strongSelf.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     func insertOrUpdateBillingAddress(_ viewController: UIViewController, url: String, parameters: Dictionary<String, Any>, successBlock: @escaping (_ jsonData: Any?) -> Void, failureBlock: @escaping(_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: {(task, response) in
     viewController.hideHUD()
     successBlock(response)
     
     }, failure: { [weak self] (task, error) in
     
     guard let strongSelf = self else { return }
     print(error)
     viewController.hideHUD()
     if let code = (task?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     strongSelf.moveToHomeScreen(kUnauthorizedError)
     }else{
     strongSelf.ShowErrorInfo(viewController, error: error)
     }
     }else{
     strongSelf.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     func completeOrder(_ viewController: UIViewController, url: String, parameters: Dictionary<String, Any>, successBlock: @escaping (_ completeOrderDetails: Array<CompleteOrderModel>) -> Void, failureBlock: @escaping(_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     if(SVProgressHUD.isVisible() == false){
     viewController.showHud(kLoading)
     }
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: {(task, response) in
     
     let completeOrderDetailsArray = NetworkResponseParser.sharedInstance.parseCompleteOrderDetails(object: response as AnyObject?)
     successBlock(completeOrderDetailsArray)
     
     }, failure: { [weak self] (task, error) in
     
     guard let strongSelf = self else { return }
     print(error)
     viewController.hideHUD()
     if let code = (task?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     strongSelf.moveToHomeScreen(kUnauthorizedError)
     }else{
     strongSelf.ShowErrorInfo(viewController, error: error)
     }
     }else{
     strongSelf.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     // MARK Finalize Order API
     
     func finalizeOrderRequest(_ viewController: UIViewController, url: String, parameters: Array<Dictionary<String, Any>>, successBlock: @escaping (_ jsonData: Any?) -> Void, failureBlock: @escaping(_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: {(task, response) in
     viewController.hideHUD()
     successBlock(response)
     
     }, failure: { [weak self] (task, error) in
     
     guard let strongSelf = self else { return }
     print(error)
     viewController.hideHUD()
     if let code = (task?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     strongSelf.moveToHomeScreen(kUnauthorizedError)
     }else{
     strongSelf.ShowErrorInfo(viewController, error: error)
     }
     }else{
     strongSelf.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     
     // MARK savescr Order API
     
     func saveCompleteScrInfo(_ viewController: UIViewController, url: String, parameters: Array<Dictionary<String, Any>>, successBlock: @escaping (_ jsonData: Any?) -> Void, failureBlock: @escaping(_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     //viewController.showHud(kLoading)
     
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: {(task, response) in
     //viewController.hideHUD()
     successBlock(response)
     
     }, failure: { [weak self] (task, error) in
     
     guard let strongSelf = self else { return }
     print(error)
     viewController.hideHUD()
     if let code = (task?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     strongSelf.moveToHomeScreen(kUnauthorizedError)
     }else{
     strongSelf.ShowErrorInfo(viewController, error: error)
     }
     }else{
     strongSelf.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     
     
     })
     }
     }
     
     // MARK deletescr Order API
     
     func deleteCompleteScrInfo(_ viewController: UIViewController, url: String, parameters: Dictionary<String, Any>, successBlock: @escaping (_ jsonData: Any?) -> Void, failureBlock: @escaping(_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: {(task, response) in
     // viewController.hideHUD()
     successBlock(response)
     
     }, failure: { [weak self] (task, error) in
     
     guard let strongSelf = self else { return }
     print(error)
     viewController.hideHUD()
     if let code = (task?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     strongSelf.moveToHomeScreen(kUnauthorizedError)
     }else{
     strongSelf.ShowErrorInfo(viewController, error: error)
     }
     }else{
     strongSelf.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     func getReinstateMainSeq(_ viewController: UIViewController, url : String, successBlock: @escaping (_  jsonData: Any?) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     if(SVProgressHUD.isVisible() == false){
     viewController.showHud(kLoading)
     }
     sessionManager.get(url, parameters: nil, progress: nil, success: { (task, response) in
     viewController.hideHUD()
     successBlock(response)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     func sendOutOfBusinessNotificationOrNotMyCustomer(_ viewController: UIViewController, url : String,parameters: Dictionary<String, Any>, successBlock: @escaping (_  jsonData: Any?) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: { (task, response) in
     viewController.hideHUD()
     successBlock(response)
     
     }, failure: { (sessionDataTask, error) in
     
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     func getListOrdersInfo(_ viewController: UIViewController, url : String,parameters: Dictionary<String, Any>, successBlock: @escaping (_ listOrderDetails: Array<ListOrdersModel>)-> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: { (task, response) in
     viewController.hideHUD()
     let listOrderDetailsArray = NetworkResponseParser.sharedInstance.parseListOrderDetails(object: response as AnyObject?)
     successBlock(listOrderDetailsArray)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorForOrders(viewController, error: error)
  conn   }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     
     failureBlock(true)
     })
     }
     }
     
     func getListOrders(_ viewController: UIViewController, url : String,parameters: Dictionary<String, Any>, successBlock: @escaping (_ listOrderDetails: Array<ListOrdersModel>)-> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: { (task, response) in
     viewController.hideHUD()
     let listOrderDetailsArray = NetworkResponseParser.sharedInstance.parseListOrderDetails(object: response as AnyObject?)
     successBlock(listOrderDetailsArray)
     
     }, failure: { (sessionDataTask, error) in
     
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorForOrders(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     func getCustomerCreditCardDetails(_ viewController: UIViewController, url : String,parameters: Dictionary<String, Any>, successBlock: @escaping (_ creditCards: Array<CreditCardModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: { (task, response) in
     viewController.hideHUD()
     let creditCardsArray = NetworkResponseParser.sharedInstance.parseCreditCardDetails(object: response as AnyObject?)
     successBlock(creditCardsArray)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     func deleteCustomerCard(_ viewController: UIViewController, url: String, parameters: Dictionary<String, Any>, successBlock: @escaping (_ jsonData: Any?) -> Void, failureBlock: @escaping(_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: {(task, response) in
     viewController.hideHUD()
     successBlock(response)
     
     }, failure: { [weak self] (task, error) in
     
     guard let strongSelf = self else { return }
     print(error)
     viewController.hideHUD()
     if let code = (task?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     strongSelf.moveToHomeScreen(kUnauthorizedError)
     }else{
     strongSelf.ShowErrorInfo(viewController, error: error)
     }
     }else{
     strongSelf.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     func creditCardInsertUpdate(_ viewController: UIViewController, url: String, parameters: Dictionary<String, Any>, successBlock: @escaping (_ jsonData: Any?) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: {(task, response) in
     viewController.hideHUD()
     successBlock(response)
     
     }, failure: { [weak self] (task,error) in
     
     guard let strongSelf = self else { return }
     
     print(error)
     viewController.hideHUD()
     if let code = (task?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     strongSelf.moveToHomeScreen(kUnauthorizedError)
     }else{
     strongSelf.ShowErrorInfo(viewController, error: error)
     }
     }else{
     strongSelf.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     
     
     })
     }
     }
     
     func getCustomerMainAddressDetails(_ viewController: UIViewController, url : String, successBlock: @escaping (_ creditCards: Array<CustomerAddressModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     sessionManager.get(url, parameters: nil, progress: nil, success: { (task, response) in
     viewController.hideHUD()
     let addressDetailsArray = NetworkResponseParser.sharedInstance.parseCustomerMainAddressDetails(object: response as AnyObject?)
     successBlock(addressDetailsArray)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     func getClaimReturnAddressDetails(_ viewController: UIViewController, url : String, successBlock: @escaping (_ creditCards: Array<ClaimReturnAddressModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     sessionManager.get(url, parameters: nil, progress: nil, success: { (task, response) in
     viewController.hideHUD()
     let addressDetailsArray = NetworkResponseParser.sharedInstance.parseClaimReturnAddressDetails(object: response as AnyObject?)
     successBlock(addressDetailsArray)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     func updateCustomerAddress(_ viewController: UIViewController, url: String, parameters: Dictionary<String, Any>, successBlock: @escaping (_ jsonData: Any?) -> Void, failureBlock: @escaping(_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: {(task, response) in
     viewController.hideHUD()
     successBlock(response)
     
     }, failure: { [weak self] (task, error) in
     
     guard let strongSelf = self else { return }
     print(error)
     viewController.hideHUD()
     if let code = (task?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     strongSelf.moveToHomeScreen(kUnauthorizedError)
     }else{
     strongSelf.ShowErrorInfo(viewController, error: error)
     }
     }else{
     strongSelf.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     func getCustomerContactsDetails(_ viewController: UIViewController, url : String, parameters: Dictionary<String, Any>,  successBlock: @escaping (_ contacts: Array<CustomerContactsModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: {(task, response) in
     viewController.hideHUD()
     let contactsArray = NetworkResponseParser.sharedInstance.parseContactsDetails(object: response as AnyObject?)
     successBlock(contactsArray)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     func getLifeStyles(_ viewController: UIViewController, url: String, successBlock: @escaping (_ lifeStyles: Array<LifeStyleModel>) -> Void, failureBlock: @escaping(_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     sessionManager.get(url, parameters: nil, progress: nil, success: { (task, response) in
     viewController.hideHUD()
     let lifeStylesArray = NetworkResponseParser.sharedInstance.parseLifeStyles(object: response as AnyObject?)
     successBlock(lifeStylesArray)
     
     }, failure: { [weak self] (task, error) in
     guard let strongSelf = self else { return }
     if let code = (task?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     strongSelf.moveToHomeScreen(kUnauthorizedError)
     }else{
     strongSelf.ShowErrorInfo(viewController, error: error)
     }
     }else{
     strongSelf.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     func getShippingHistory(_ viewController: UIViewController, url: String, successBlock: @escaping (_ shippingHistory: Array<BookingAndShippingHistoryModel>) -> Void, failureBlock: @escaping(_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     sessionManager.get(url, parameters: nil, progress: nil, success: { (task, response) in
     viewController.hideHUD()
     let historyArray = NetworkResponseParser.sharedInstance.parseShippingHistory(object: response as AnyObject?)
     successBlock(historyArray)
     
     }, failure: { [weak self] (task, error) in
     
     guard let strongSelf = self else { return }
     print(error)
     viewController.hideHUD()
     if let code = (task?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     strongSelf.moveToHomeScreen(kUnauthorizedError)
     }else{
     strongSelf.ShowErrorInfo(viewController, error: error)
     }
     }else{
     strongSelf.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     func getClaimsInfo(_ viewController: UIViewController, url : String,parameters: Dictionary<String, Any>, successBlock: @escaping (_ claimsInfo: Array<ViewClaimsModel>)-> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: { (task, response) in
     viewController.hideHUD()
     let claimsInfoArray = NetworkResponseParser.sharedInstance.parseClaimsDetails(object: response as AnyObject?)
     successBlock(claimsInfoArray)
     
     }, failure: { (sessionDataTask, error) in
     
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     func postAccountsRequest(_ viewController: UIViewController, url: String, parameters: Dictionary<String, Any>, successBlock: @escaping (_ customerAccountDetails: Array<AccountsModel>) -> Void, failureBlock: @escaping(_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     
     if(SVProgressHUD.isVisible() == false){
     viewController.showHud(kLoading)
     }
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: {(task, response) in
     
     
     viewController.hideHUD()
     let parseAccountDetailsArray = NetworkResponseParser.sharedInstance.parseAccountDetails(object: response as AnyObject?)
     successBlock(parseAccountDetailsArray)
     
     }, failure: { [weak self] (task, error) in
     
     guard let strongSelf = self else { return }
     print(error)
     viewController.hideHUD()
     if let code = (task?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     strongSelf.moveToHomeScreen(kUnauthorizedError)
     }else{
     strongSelf.ShowErrorInfo(viewController, error: error)
     }
     }else{
     strongSelf.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     
     })
     }
     }
     
     func getClaimsCountInfo(_ viewController: UIViewController, url : String,parameters: Dictionary<String, Any>, successBlock: @escaping (_ claimsInfo: Array<ViewClaimsModel>)-> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: { (task, response) in
     let claimsInfoArray = NetworkResponseParser.sharedInstance.parseClaimsDetails(object: response as AnyObject?)
     successBlock(claimsInfoArray)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     func getClaimsDetails(_ viewController: UIViewController, parameters: Dictionary<String, Any>, successBlock: @escaping (_ claimedItemDetails: Array<ListClaimedItemsModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     if(SVProgressHUD.isVisible() == false){
     viewController.showHud(kLoading)
     }
     
     let url = BASE_CLAIMS_URL + API_GETCUSTOMERCLAIMINVOICEITEMINFORMATION
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: { (sessionDataTask, response) in
     
     viewController.hideHUD()
     let claimsListDetailsArray = NetworkResponseParser.sharedInstance.parseClaimsListDetails(object: response as AnyObject?)
     successBlock(claimsListDetailsArray)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     func getListClaimsDetails(_ viewController: UIViewController, parameters: Dictionary<String, Any>, successBlock: @escaping (_ claimedListDetails: Array<ClaimedListModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     let url = BASE_CLAIMS_URL + API_GETCUSTOMERCLAIMITEMS
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: { (sessionDataTask, response) in
     
     viewController.hideHUD()
     let claimsListDetailsArray = NetworkResponseParser.sharedInstance.parseClaimedListDetails(object: response as AnyObject?)
     successBlock(claimsListDetailsArray)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     //MARK: Get Order Summary API
     
     func fetchOrderSummary(_ viewcontroller: UIViewController, url: String, successBlock: @escaping (_ resultObject: Array<OrderSummaryModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewcontroller.showHud(kLoading)
     
     sessionManager.get(url, parameters: nil, progress: nil, success: { (task, response) in
     viewcontroller.hideHUD()
     let summaryModel = NetworkResponseParser.sharedInstance.parseOrderSummary(object: response as AnyObject)
     successBlock(summaryModel)
     }, failure: { (task, error) in
     if let code = (task?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewcontroller.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewcontroller, error: error)
     }
     }else{
     self.ShowError(viewcontroller, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     
     }
     
     }
     
     //MAR: Get Last Year and Current Year Summary
     
     func fetchLastAndCurrentYearSummary(_ viewcontroller: UIViewController, url: String, successBlock: @escaping (_ resultObject:LastVsCurrentYearSummaryModel) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewcontroller.showHud(kLoading)
     
     sessionManager.get(url, parameters: nil, progress: nil, success: { (task, response) in
     
     viewcontroller.hideHUD()
     let summaryModel = NetworkResponseParser.sharedInstance.parseLastVsCurrentYearSumary(object: response as AnyObject)
     successBlock(summaryModel)
     }, failure: { (task, error) in
     
     if let code = (task?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewcontroller.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewcontroller, error: error)
     }
     }else{
     self.ShowError(viewcontroller, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     func getSalesPersonFavItems(_ viewController: UIViewController, url: String, successBlock: @escaping (_ repFavorites: Array<FavoriteModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     
     sessionManager.get(url, parameters: nil, progress: nil, success: { (sessionDataTask, response) in
     
     viewController.hideHUD()
     let favsDetailsArray = NetworkResponseParser.sharedInstance.parseSalesRepFavorites(object: response as AnyObject?)
     successBlock(favsDetailsArray)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     func getNotificationsList(_ viewController: UIViewController, url: String, successBlock: @escaping (_ notificationsList: Array<NotificationsListModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     
     sessionManager.get(url, parameters: nil, progress: nil, success: { (sessionDataTask, response) in
     
     viewController.hideHUD()
     let notificationsListDetailsArray = NetworkResponseParser.sharedInstance.parseNotificationsList(object: response as AnyObject?)
     successBlock(notificationsListDetailsArray)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     func getOrderDetails(_ viewController: UIViewController, parameters: Dictionary<String, Any>, successBlock: @escaping (_ totalOrdersDetails: Array<TotalOrdersModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     viewController.showHud(kLoading)
     let url = BASE_URL + API_GETTOTALCATEGORIES
     sessionManager.post(url, parameters: parameters, progress: nil, success: { (sessionDataTask, response) in
     
     viewController.hideHUD()
     
     let totalOrdersModelArray = NetworkResponseParser.sharedInstance.parseTotalOrderDetails(object: response as AnyObject?)
     
     successBlock(totalOrdersModelArray)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     func getProfileDetails(_ viewController: UIViewController, url: String, successBlock: @escaping (_ address: Array<ProfileModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     
     sessionManager.get(url, parameters: nil, progress: nil, success: { (task, response) in
     
     viewController.hideHUD()
     let profileArray = NetworkResponseParser.sharedInstance.parseProfileDetails(object: response as AnyObject?)
     successBlock(profileArray)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     func postShareRequest(_ viewController: UIViewController, parameters: Dictionary<String, Any>, url: String, successBlock: @escaping (_ jsonData: Any?) -> Void, failureBlock: @escaping(_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: { (sessionDataTask, response) in
     viewController.hideHUD()
     successBlock(response)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     func postFavShareRequest(_ viewController: UIViewController, parameters: Dictionary<String, Any>, url: String, successBlock: @escaping (_ jsonData: Any?) -> Void, failureBlock: @escaping(_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: { (sessionDataTask, response) in
     successBlock(response)
     
     }, failure: { (sessionDataTask, error) in
     
     viewController.hideHUD()
     print(error)
     
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     func getState(_ viewController: UIViewController, successBlock: @escaping (_ states: Array<StatesModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     let url = BASE_URL + API_GET_STATES
     
     sessionManager.get(url, parameters: nil, progress: nil, success: { (task, response) in
     
     
     let statesArray = NetworkResponseParser.sharedInstance.parseStates(object: response as AnyObject?)
     successBlock(statesArray)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     func getCountry(_ viewController: UIViewController, successBlock: @escaping (_ countries: Array<CountryModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     
     let url = BASE_URL + API_GET_COUNTRIES
     
     sessionManager.get(url, parameters: nil, progress: nil, success: { (task, response) in
     
     
     let countriesArray = NetworkResponseParser.sharedInstance.parseCountries(object: response as AnyObject?)
     successBlock(countriesArray)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     func getShipViaType(_ viewController: UIViewController, successBlock: @escaping (_ states: Array<ShipViaTypeModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     
     let url = BASE_URL + API_GETSHIPVIATYPES
     
     sessionManager.get(url, parameters: nil, progress: nil, success: { (task, response) in
     
     
     let shipViaTypeArray = NetworkResponseParser.sharedInstance.parseShipViaTypes(object: response as AnyObject?)
     successBlock(shipViaTypeArray)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     func getAddressType(_ viewController: UIViewController, successBlock: @escaping (_ address: Array<AddressTypeModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     let url = BASE_URL + API_GETADDRESSTYPES
     
     sessionManager.get(url, parameters: nil, progress: nil, success: { (task, response) in
     
     
     let addressArray = NetworkResponseParser.sharedInstance.parseAddressTypes(object: response as AnyObject?)
     successBlock(addressArray)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     func postCustomerHeaderRequest(_ viewController: UIViewController, url: String, parameters: Dictionary<String, Any>, successBlock: @escaping (_ jsonData: Any?) -> Void, failureBlock: @escaping(_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: {(task, response) in
     
     successBlock(response)
     
     }, failure: { [weak self] (task, error) in
     
     guard let strongSelf = self else { return }
     print(error)
     viewController.hideHUD()
     if let code = (task?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     strongSelf.moveToHomeScreen(kUnauthorizedError)
     }else{
     strongSelf.ShowErrorInfo(viewController, error: error)
     }
     }else{
     strongSelf.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     
     })
     }
     }
     
     func postCustomerDiscountAndRefundRequest(_ viewController: UIViewController, url: String, parameters: Dictionary<String, Any>, successBlock: @escaping (_ jsonData: Any?) -> Void, failureBlock: @escaping(_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     viewController.showHud(kLoading)
     sessionManager.post(url, parameters: parameters, progress: nil, success: {(task, response) in
     viewController.hideHUD()
     successBlock(response)
     
     }, failure: { [weak self] (task, error) in
     
     guard let strongSelf = self else { return }
     print(error)
     viewController.hideHUD()
     if let code = (task?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     strongSelf.moveToHomeScreen(kUnauthorizedError)
     }else{
     strongSelf.ShowErrorInfo(viewController, error: error)
     }
     }else{
     strongSelf.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     
     })
     }
     }
     
     func postCompleteClaim(_ viewController: UIViewController, url: String, parameters: Dictionary<String, Any>, successBlock: @escaping (_ jsonData: Any?) -> Void, failureBlock: @escaping(_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     viewController.showHud(kLoading)
     sessionManager.post(url, parameters: parameters, progress: nil, success: {(task, response) in
     viewController.hideHUD()
     successBlock(response)
     
     }, failure: { [weak self] (task, error) in
     
     guard let strongSelf = self else { return }
     print(error)
     viewController.hideHUD()
     if let code = (task?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     strongSelf.moveToHomeScreen(kUnauthorizedError)
     }else{
     strongSelf.ShowErrorInfo(viewController, error: error)
     }
     }else{
     strongSelf.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     
     })
     }
     }
     
     func getClaimItemAdd(_ viewController: UIViewController, url : String, successBlock: @escaping (_ address: Array<ClaimInformationModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     sessionManager.get(url, parameters: nil, progress: nil, success: { (task, response) in
     viewController.hideHUD()
     let itemArray = NetworkResponseParser.sharedInstance.parseClaimItem(object: response as AnyObject?)
     successBlock(itemArray)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     func deleteClaim(_ viewController: UIViewController, url: String, parameters: Dictionary<String, Any>, successBlock: @escaping (_ jsonData: Any?) -> Void, failureBlock: @escaping(_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     viewController.showHud(kLoading)
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: {(task, response) in
     viewController.hideHUD()
     successBlock(response)
     
     }, failure: { [weak self] (task, error) in
     
     guard let strongSelf = self else { return }
     print(error)
     viewController.hideHUD()
     if let code = (task?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     strongSelf.moveToHomeScreen(kUnauthorizedError)
     }else{
     strongSelf.ShowErrorInfo(viewController, error: error)
     }
     }else{
     strongSelf.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     
     
     })
     }
     }
     func postClaimRequest(_ viewController: UIViewController, url: String, parameters: Dictionary<String, Any>, successBlock: @escaping (_ jsonData: Any?) -> Void, failureBlock: @escaping(_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     
     if(SVProgressHUD.isVisible() == false){
     viewController.showHud(kLoading)
     }
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: {(task, response) in
     
     successBlock(response)
     
     }, failure: { [weak self] (task, error) in
     
     guard let strongSelf = self else { return }
     print(error)
     viewController.hideHUD()
     if let code = (task?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     strongSelf.moveToHomeScreen(kUnauthorizedError)
     }else{
     strongSelf.ShowErrorInfo(viewController, error: error)
     }
     }else{
     strongSelf.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     
     })
     }
     }
     
     func postImageRequest(_ viewController: UIViewController, url: String, parameters:  [[String: Any]], successBlock: @escaping (_ jsonData: Any?) -> Void, failureBlock: @escaping(_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     
     if(SVProgressHUD.isVisible() == false){
     viewController.showHud(kLoading)
     }
     
     sessionManager.post(url, parameters: parameters, progress: nil, success: {(task, response) in
     
     successBlock(response)
     viewController.hideHUD()
     
     }, failure: { [weak self] (task, error) in
     
     guard let strongSelf = self else { return }
     print(error)
     viewController.hideHUD()
     if let code = (task?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     strongSelf.moveToHomeScreen(kUnauthorizedError)
     }else{
     strongSelf.ShowErrorInfo(viewController, error: error)
     }
     }else{
     strongSelf.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     
     })
     }
     }
     
     func getEditClaimSubcodes(_ viewController: UIViewController,url: String, successBlock: @escaping (_ subcodes: Array<ClaimSubcodeModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     
     viewController.showHud(kLoading)
     
     
     sessionManager.get(url, parameters: nil, progress: nil, success: { (task, response) in
     let subCodesArray = NetworkResponseParser.sharedInstance.parseClaimSubCodeTypes(object: response as AnyObject?)
     successBlock(subCodesArray)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     viewController.hideHUD()
     if let code = (sessionDataTask?.response as? HTTPURLResponse)?.statusCode{
     if(code == 401){
     viewController.hideHUD()
     self.moveToHomeScreen(kUnauthorizedError)
     }else{
     self.ShowErrorInfo(viewController, error: error)
     }
     }else{
     self.ShowError(viewController, message: error.localizedDescription)
     }
     failureBlock(true)
     })
     }
     }
     
     
     func getListClaimSubcodes(_ viewController: UIViewController,url: String, successBlock: @escaping (_ subcodes: Array<ClaimSubcodeModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
     
     if let sessionManager = networkSharedInstance() {
     
     sessionManager.get(url, parameters: nil, progress: nil, success: { (task, response) in
     let subCodesArray = NetworkResponseParser.sharedInstance.parseClaimSubCodeTypes(object: response as AnyObject?)
     successBlock(subCodesArray)
     
     }, failure: { (sessionDataTask, error) in
     
     print(error)
     failureBlock(true)
     })
     }
     }
     */
    
    
    
    //MARK: - Show Error Message
    
    //    func ShowErrorInfo(_ viewController: UIViewController, error: Error) {
    //
    //        viewController.hideHUD()
    //
    //      if let data =  (error as NSError).userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey]{
    //            if let statusesDict = try? JSONSerialization.jsonObject(with: data as! Data, options: .allowFragments) as? [String: Any]{
    //
    //                let statusCode = statusesDict?["statusCode"] as? Int
    //                if let message = statusCode{
    //                    if(message == 401){
    //                        moveToHomeScreen(kUnauthorizedError)
    //                    }else if(message == 503){
    //                          self.ShowError(viewController, message: kInternalServerError)
    //                    }else{
    //                        let statusMessage = statusesDict?["statusMessage"] as? String
    //                         if let msg = statusMessage{
    //                            self.ShowError(viewController, message: msg)
    //                        }
    //                    }
    //
    //                }
    //
    //            }
    //
    //        }
    //
    //    }
    //
    //    func ShowErrorForOrders(_ viewController: UIViewController, error: Error) {
    //
    //        viewController.hideHUD()
    //
    //        if let data =  (error as NSError).userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey]{
    //            if let statusesDict = try? JSONSerialization.jsonObject(with: data as! Data, options: .allowFragments) as? [String: Any]{
    //
    //                let statusCode = statusesDict?["statusCode"] as? Int
    //                if let message = statusCode{
    //                    if(message == 401){
    //                        moveToHomeScreen(kUnauthorizedError)
    //                    }else if(message == 503){
    //                        self.ShowError(viewController, message: kInternalServerError)
    //                    }else{
    //                        let statusMessage = statusesDict?["statusMessage"] as? String
    //                        if let msg = statusMessage{
    //                            if(msg != "No orders found"){
    //                                 self.ShowError(viewController, message: msg)
    //                            }
    //                        }
    //                    }
    //
    //                }
    //
    //            }
    //
    //        }
    //
    //
    //    }
    
    
    
    func ShowError(_ viewController: UIViewController, message: String) {
        
        viewController.hideHUD()
        
        
        let imagePopOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImagePopUp") as! ImagePopUpViewController
        imagePopOverVC.alertTle = kAppTitle
        imagePopOverVC.alertMsg = message
        imagePopOverVC.cancelTitle = ""
        imagePopOverVC.hideCancel = true
        imagePopOverVC.okTitle = "OK"
        imagePopOverVC.heightConstraint = 155
        imagePopOverVC.alignment = "Left"
        viewController.addChildViewController(imagePopOverVC)
        imagePopOverVC.view.frame = CGRect(x: 0, y: 0, width: viewController.view.frame.width, height: viewController.view.frame.height)
        viewController.view.addSubview(imagePopOverVC.view)
        imagePopOverVC.didMove(toParentViewController: viewController)
        
//        Utilities.sharedInstance.alertWithOkButtonAction(vc: viewController, alertTitle: kAppTitle, messege: message, clickAction: {
//            
//        })
    }
    
    
    
    func ShowNetworkError() {
        
        let viewController = UIApplication.shared.windows[0].rootViewController! as UIViewController
        
        
        viewController.hideHUD()
        
        let imagePopOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImagePopUp") as! ImagePopUpViewController
        imagePopOverVC.alertTle = kAppTitle
        imagePopOverVC.alertMsg = kNetworkError
        imagePopOverVC.cancelTitle = ""
        imagePopOverVC.hideCancel = true
        imagePopOverVC.okTitle = "OK"
        imagePopOverVC.heightConstraint = 155
        imagePopOverVC.alignment = "Left"
        viewController.addChildViewController(imagePopOverVC)
        imagePopOverVC.view.frame = CGRect(x: 0, y: 0, width: viewController.view.frame.width, height: viewController.view.frame.height)
        viewController.view.addSubview(imagePopOverVC.view)
        imagePopOverVC.didMove(toParentViewController: viewController)
        
//        Utilities.sharedInstance.alertWithOkButtonAction(vc: viewController,
//                                                         alertTitle: kAppTitle,
//                                                         messege: kNetworkError, clickAction: {
//                                                            
//        })
    }
    
    func ShowError() {
        
        
        let viewController = UIApplication.shared.windows[0].rootViewController! as UIViewController
        
        viewController.hideHUD()
        
        if let topController = UIApplication.topViewController() {
            if topController is ViewController{
                
                let imagePopOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImagePopUp") as! ImagePopUpViewController
                imagePopOverVC.alertTle = kAppTitle
                imagePopOverVC.alertMsg = kNetworkError
                imagePopOverVC.cancelTitle = ""
                imagePopOverVC.hideCancel = true
                imagePopOverVC.okTitle = "OK"
                imagePopOverVC.heightConstraint = 155
                imagePopOverVC.alignment = "Center"
                viewController.addChildViewController(imagePopOverVC)
                imagePopOverVC.view.frame = CGRect(x: 0, y: 0, width: viewController.view.frame.width, height: viewController.view.frame.height)
                viewController.view.addSubview(imagePopOverVC.view)
                imagePopOverVC.didMove(toParentViewController: viewController)
                
//                Utilities.sharedInstance.alertWithOkButtonAction(vc: viewController,
//                                                                 alertTitle: kAppTitle,
//                                                                 messege: kNetworkError, clickAction: {
//                                                                    
//                })
                
            }else{
                
                moveToHomeScreen(kNetworkError)
            }
        }
        
        
        
    }
    
    func moveToHomeScreen(_ message: String){
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "rootVC") as! CCKFNavDrawer
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = viewController
        
        Utilities.sharedInstance.alertWithOkButtonAction(vc: viewController,
                                                         alertTitle: kAppTitle,
                                                         messege: message, clickAction: {
                                                            
        })
    }
    
    func convertStringToDictionary(_ json: String) -> [String: AnyObject]? {
        if let data = json.data(using: String.Encoding.utf8) {
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? [String: AnyObject]
                return json
            }catch {
                print(error)
            }
        }
        return nil
    }
    
    
    
    
    */
    
}











