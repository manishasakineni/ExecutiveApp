//
//  LoginParamsAPIModel.swift
//  Agent Payzan
//
//  Created by CalibrageMac02 on 02/11/17.
//  Copyright © 2017 Naveen. All rights reserved.
//

import UIKit

class LoginParamsAPIModel: NSObject {
    
     
    let KAccessToken      =   "AccessToken"
    let KActivityRightId  =   "ActivityRightId"
    let KCreatedBy        =   "CreatedBy"
    let KModifiedBy       =   "ModifiedBy"
    let KRoleId           =   "RoleId"
    let KEmail            =   "Email"
    let KId               =   "Id"
    let KPhoneNumber      =   "PhoneNumber"
    let KUserName         =   "UserName"
    let KBalance          =   "Balance"
    let KWalletId         =   "WalletId"
    let KRefreshToken     =   "RefreshToken"
    let KExpiresIn        =   "ExpiresIn"
    
    var accessToken      : String = ""
    var activityRightId  : String = ""
    var createdBy        : String = ""
    var modifiedBy       : String = ""
    var roleId           : String = ""
    var email            : String = ""
    var id               : String = ""
    var phoneNumber      : String = ""
    var userName         : String = ""
    var balance          : String = ""
    var walletId         : String = ""
    var refreshToken     : String = ""
    var expiresIn        : String = ""
    
    
    override init() {
        
    }
    
    
    init(dict : NSDictionary?){
        
        super.init()
        
        
        if dict != nil {
        
        
    // Mark : -  Login Api Parameters 
            
            
            if Utilities.sharedInstance.isObjectNull("\(dict![KAccessToken])" as AnyObject?) {
                
                if let parameterString = dict![KAccessToken] as? String{
                    
                    
                    accessToken = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![KActivityRightId])" as AnyObject?) {
                
                if let parameterString = dict![KActivityRightId] as? String{
                    
                    
                    activityRightId = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![KCreatedBy])" as AnyObject?) {
                
                if let parameterString = dict![KCreatedBy] as? String{
                    
                    
                    createdBy = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![KModifiedBy])" as AnyObject?) {
                
                if let parameterString = dict![KModifiedBy] as? String{
                    
                    
                    modifiedBy = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![KRoleId])" as AnyObject?) {
                
                if let parameterString = dict![KRoleId] as? String{
                    
                    
                    roleId = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![KEmail])" as AnyObject?) {
                
                if let parameterString = dict![KEmail] as? String{
                    
                    
                    email = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![KId])" as AnyObject?) {
                
                if let parameterString = dict![KId] as? String{
                    
                    
                    id = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![KPhoneNumber])" as AnyObject?) {
                
                if let parameterString = dict![KPhoneNumber] as? String{
                    
                    
                    phoneNumber = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![KUserName])" as AnyObject?) {
                
                if let parameterString = dict![KUserName] as? String{
                    
                    
                    userName = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![KBalance])" as AnyObject?) {
                
                if let parameterString = dict![KBalance] as? String{
                    
                    
                    balance = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![KWalletId])" as AnyObject?) {
                
                if let parameterString = dict![KWalletId] as? String{
                    
                    
                    walletId = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![KRefreshToken])" as AnyObject?) {
                
                if let parameterString = dict![KRefreshToken] as? String{
                    
                    
                    refreshToken = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }

            if Utilities.sharedInstance.isObjectNull("\(dict![KExpiresIn])" as AnyObject?) {
                
                if let parameterString = dict![KExpiresIn] as? String{
                    
                    
                    expiresIn = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            

        
        }

}

}
