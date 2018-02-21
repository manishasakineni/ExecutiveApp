//
//  UpdateAgentReqInfoParamsAPIModel.swift
//  Agent Payzan
//
//  Created by N@n!'$ Mac on 02/11/17.
//  Copyright © 2017 Naveen. All rights reserved.
//

import UIKit

class UpdateAgentReqInfoParamsAPIModel: NSObject {
    
    static let sharedInstance = UpdateAgentReqInfoParamsAPIModel()
  
    
    
    let kAgentRequestId = "AgentRequestId"
    let kStatusTypeId    = "StatusTypeId"
    let kAssignToUserId = "AssignToUserId"
    let kComments = "Comments"
    let kId = "Id"
    let kIsActive = "IsActive"
    let kCreatedBy = "CreatedBy"
    let kModifiedBy = "ModifiedBy"
    let kCreated = "Created"
    let kModified = "Modified"
    
    
    let kResult = "Result"
    let kIsSuccess = "IsSuccess"
    let kAffectedRecords = "AffectedRecords"
    let kEndUserMessage = "EndUserMessage"
    let kValidationErrors = "ValidationErrors"
    let kException = "Exception"
    
    
    var result             : String = ""
    var isSuccess          : String = ""
    var affectedRecords    : Int? = nil
    var endUserMessage     : String = ""
    var validationErrors    : String = ""
    var exception          : String = ""
    
    var agentRequestId    : Int? = nil
    var statusTypeId      : Int? = nil
    var assignToUserId    : String = ""
    var comments          : String = ""
    var id                : Int? = nil
    var isActive          : String = ""
    var createdBy         : String = ""
    var modifiedBy        : String = ""
    var created           : String = ""
    var modified          : String = ""
    
    
    
    override init() {
        
    }
    
    
    init(dict : NSDictionary?){
        
        super.init()
        
        
        if dict != nil {
            
            // Mark : -  Update   Agent Request Info Parameters 
            
            
            
            if Utilities.sharedInstance.isObjectNull("\(dict![kResult])" as AnyObject?) {
                
                if let parameterString = dict![kResult] as? String{
                    
                    
                    result = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![kIsSuccess])" as AnyObject?) {
                
                if let parameterString = dict![kIsSuccess] as? String{
                    
                    
                    isSuccess = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![kAffectedRecords])" as AnyObject?) {
                
                if let parameterString = dict![kAffectedRecords] as? Int{
                    
                    
                    affectedRecords = parameterString
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![kEndUserMessage])" as AnyObject?) {
                
                if let parameterString = dict![kEndUserMessage] as? String{
                    
                    
                    endUserMessage = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![kValidationErrors])" as AnyObject?) {
                
                if let parameterString = dict![kValidationErrors] as? String{
                    
                    
                    validationErrors = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![kException])" as AnyObject?) {
                
                if let parameterString = dict![kException] as? String{
                    
                    
                    exception = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![kAgentRequestId])" as AnyObject?) {
                
                if let parameterString = dict![kAgentRequestId] as? Int{
                    
                    
                    agentRequestId = parameterString
                    
                }
                
            }
            
                    
            if Utilities.sharedInstance.isObjectNull("\(dict![kStatusTypeId])" as AnyObject?) {
                
                if let parameterString = dict![kStatusTypeId] as? Int{
                    
                    
                    statusTypeId = parameterString
                    
                }
                
            }
            
            
            if Utilities.sharedInstance.isObjectNull("\(dict![kAssignToUserId])" as AnyObject?) {
                
                if let parameterString = dict![kAssignToUserId] as? String{
                    
                    
                    assignToUserId = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![kComments])" as AnyObject?) {
                
                if let parameterString = dict![kComments] as? String{
                    
                    
                    comments = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            if Utilities.sharedInstance.isObjectNull("\(dict![kId])" as AnyObject?) {
                
                if let parameterString = dict![kId] as? Int {
                    
                    
                    id = parameterString
                    
                }
                
            }
            
            
            if Utilities.sharedInstance.isObjectNull("\(dict![kIsActive])" as AnyObject?) {
                
                if let parameterString = dict![kIsActive] as? String{
                    
                    isActive = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![kCreatedBy])" as AnyObject?) {
                
                if let parameterString = dict![kCreatedBy] as? String{
                    
                    
                    createdBy = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            
            if Utilities.sharedInstance.isObjectNull("\(dict![kModifiedBy])" as AnyObject?) {
                
                if let parameterString = dict![kModifiedBy] as? String{
                    
                    
                    modifiedBy = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![kModified])" as AnyObject?) {
                
                if let parameterString = dict![kModified] as? String{
                    
                    
                    modified = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(kCreated)" as AnyObject?) {
                
                if let parameterString = dict![kCreated] as? String{
                    
                    
                    created = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
        
            
          
        
        
    }
    
    
    
    }
    
}
