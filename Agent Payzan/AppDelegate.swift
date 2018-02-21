  //
//  AppDelegate.swift
//  Agent Payzan
//
//  Created by Nani Mac on 05/10/17.
//  Copyright © 2017 Naveen. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SystemConfiguration
import Localize



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var backgroundTaskIdentifier: UIBackgroundTaskIdentifier?
    var timer               : Timer = Timer.init()
    
    var isManualLogin       : Bool = false
    
    var reachability: Reachability?
    
    var navc : UINavigationController?
     
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().toolbarTintColor = #colorLiteral(red: 0.5021751523, green: 0.01639934443, blue: 0, alpha: 1)
        
        
        if UserDefaults.standard.value(forKey: KFirstTimeLogin) as? String == "true" {
            
                let homeNav : UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeNav") as! UINavigationController
                
                self.window?.rootViewController = homeNav

        }
        
        else{
        
            let LoginNav : UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginNav") as! UINavigationController
           
            self.window?.rootViewController = LoginNav

        }
        
        let localize = Localize.shared
        // Set your localize provider.
        localize.update(provider: .json)
        // Set your file name
        localize.update(fileName: "lang")
        // Set your default languaje.
        //        localize.update(defaultLanguage: "fr")
        // If you want change a user language, different to default in phone use thimethod.
//        localize.update(language: "en")
//        localize.update(defaultLanguage: "si")
//        localize.update(defaultLanguage: "ta")
        // If you want remove storaged languaje use
       // localize.resetLanguage()
        // The used language
        print(localize.language())
        // List of aviable languajes
        print(localize.availableLanguages())
        


        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // MARK: - Check Internet Connectivity
    
    func checkInternetConnectivity() -> Bool {
        
//        var zeroAddress = sockaddr_in()
//        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
//        zeroAddress.sin_family = sa_family_t(AF_INET)
//        
//        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
//            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
//                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
//            }
//        }
//        
//        var flags = SCNetworkReachabilityFlags()
//        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
//            return false
//        }
//        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
//        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
//        return (isReachable && !needsConnection)
        
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


// MARK: - Check Refresh Token For Login
    
    func refreshTokenForLogin(){
        
        
        if(appDelegate.checkInternetConnectivity()){
            
            let refreshToken : String = UserDefaults.standard.value(forKey: ArefreshToken) as! String
            
            let refreshParams = ["clientId"     : "payzan.mobile",
                                 "clientSecret" : "PayZan!@",
                                 "RefreshToken" : refreshToken] as Dictionary<String, AnyObject>
            
            APIModel().postRequest((self.window?.rootViewController)!, withUrl: REFRESHTOKEN_API, parameters: refreshParams, successBlock: { (json) in
                
                
                
            }, failureBlock: { (failureMsg) in
                
                
                
            })
            
            
            
        }
            
            
        else {
            
            
            
            
            
        }
        
        
    }
    

}

