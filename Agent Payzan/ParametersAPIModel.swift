//
//  ParametersAPIModel.swift
//  Agent Payzan
//
//  Created by Nani Mac on 10/10/17.
//  Copyright © 2017 Naveen. All rights reserved.
//  GetStatesAPIModel

import UIKit

class ParametersAPIModel: NSObject {
    
    
    let kName     =    "Name"
    let KDescription = "Description"
    let KBranchName = "BranchName"
    let KSwiftCode = "SwiftCode"
    let KClassTypeId = "ClassTypeId"
    
// Mark : -  Login Response Parameters 
    
    
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
    let KPostCode         =   "PostCode"
    
    
   
    
    
    var name             : String = ""
    var descriptions     : String = ""
    var branchName       : String = ""
    var swiftCode        : String = ""
    var personalIDName   : String = ""
    var financialIDName  : String = ""
    var provinceName     : String = ""
    var gender           : String = ""
    
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
    
    var postCode         : String = ""
    var classTypeId      : String = ""
    
    
    
    override init() {
        
    }
    
    
    init(dict : NSDictionary?){
    
    super.init()
        
        
        if dict != nil {
            
          /// kName
            if Utilities.sharedInstance.isObjectNull("\(dict![kName])" as AnyObject?) {
                
                if let parameterString = dict![kName] as? String {
                    
                    name = (parameterString.characters.count) > 0 ? parameterString : ""
                }
            }
            
            
            if Utilities.sharedInstance.isObjectNull("\(dict![KDescription])" as AnyObject?) {
                
            if let parameterString = dict![KDescription] as? String {
                    
            descriptions  = (parameterString.characters.count) > 0 ? parameterString : ""
                }
            }
            
            
            if Utilities.sharedInstance.isObjectNull("\(dict![KBranchName])" as AnyObject?) {
                
                if let parameterString = dict![KBranchName] as? String {
                    
                branchName  = (parameterString.characters.count) > 0 ? parameterString : ""
                }
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![KSwiftCode])" as AnyObject?) {
                
                if let parameterString = dict![KSwiftCode] as? String {
                    
                    swiftCode  = (parameterString.characters.count) > 0 ? parameterString : ""
                }
            }
            
            
            if Utilities.sharedInstance.isObjectNull("\(dict![KDescription])" as AnyObject?) {
                
                if let parameterString = dict![KDescription] as? String {
                    
                    personalIDName  = (parameterString.characters.count) > 0 ? parameterString : ""
                }
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![KDescription])" as AnyObject?) {
            
                if let parameterString = dict![KDescription] as? String{
                
                
                    financialIDName = (parameterString.characters.count) > 0 ? parameterString : ""
                
                }

            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![kName])" as AnyObject?) {
                
                if let parameterString = dict![kName] as? String{
                    
                    
                    provinceName = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            
            if Utilities.sharedInstance.isObjectNull("\(dict![KDescription])" as AnyObject?) {
                
                if let parameterString = dict![KDescription] as? String{
                    
                    
                    gender = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
             
            if Utilities.sharedInstance.isObjectNull("\(dict![KId])" as AnyObject){
            
            
                if let parameterString = dict![KId] as? NSNumber{
                
                id = parameterString.stringValue
                }
                    
                else if let parameterString = dict![KId] as? String {
                
                    id = (parameterString.characters.count) > 0 ? parameterString : ""
                
                }
            
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![KPostCode])" as AnyObject){
                
                
                if let parameterString = dict![KPostCode] as? NSNumber{
                    
                    postCode = parameterString.stringValue
                }
                    
                else if let parameterString = dict![KPostCode] as? String {
                    
                    postCode = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![KClassTypeId])" as AnyObject){
                
                
                if let parameterString = dict![KClassTypeId] as? NSNumber{
                    
                    classTypeId = parameterString.stringValue
                }
                    
                else if let parameterString = dict![KClassTypeId] as? String {
                    
                    classTypeId = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }

            
//            if Utilities.sharedInstance.isObjectNull("\(dict![kNotificationID])" as AnyObject?) {
//                
//                if let notificationIDNumber = dict![kNotificationID] as? NSNumber {
//                    
//                    notificationID = notificationIDNumber.stringValue
//                    
//                } else if let notificationIDString = dict![kNotificationID] as? String {
//                    
//                    notificationID = (notificationIDString.characters.count) > 0 ? notificationIDString : ""
//                    
//                } else {
//                    
//                    notificationID = ""
//                }
//            }
            
            
            
        }
    
    
    
    
    
    
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
