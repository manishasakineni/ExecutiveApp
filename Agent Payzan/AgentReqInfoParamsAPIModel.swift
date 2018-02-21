//
//  AgentReqInfoParamsAPIModel.swift
//  Agent Payzan
//
//  Created by CalibrageMac02 on 02/11/17.
//  Copyright © 2017 Naveen. All rights reserved.
//

import UIKit

class AgentReqInfoParamsAPIModel: NSObject {
    
    //////  Agent Request Inf Parameters ///
    
    static let sharedInstance = AgentReqInfoParamsAPIModel()
    
    let kAgentRequestCategoryName = "AgentRequestCategoryName"
    let kTitleType = "TitleType"
    let kCountryName = "CountryName"
    let kProvinceId = "ProvinceId"
    let kProvinceName = "ProvinceName"
    let kDistrictId = "DistrictId"
    let kDistrictName = "DistrictName"
    let kMandalId = "MandalId"
    let kMandalName = "MandalName"
    let kVillageId = "VillageId"
    let kVillageName = "VillageName"
    let kStatusTypeId = "StatusTypeId"
    let kStatusType = "StatusType"
    let kAssignToUserId = "AssignToUserId"
    let kAssignToUserName = "AssignToUserName"
    let kIsActive = "IsActive"
    let kCreatedBy = "CreatedBy"
    let kModifiedBy = "ModifiedBy"
    let kModified = "Modified"
    let kId = "Id"
    let kAgentRequestCategoryId = "AgentRequestCategoryId"
    let kTitleTypeId = "TitleTypeId"
    let kFirstName = "FirstName"
    let kMiddleName = "MiddleName"
    let kLastName = "LastName"
    let kMobileNumber = "MobileNumber"
    let kEmail = "Email"
    let kAddressLine1 = "AddressLine1"
    let kAddressLine2 = "AddressLine2"
    let kLandmark = "Landmark"
  
    let kPostCode  = "PostCode"
    let kComments = "Comments"
    let kCreated = "Created"
    let KPageIndex = "PageIndex"
    let KPageSize = "PageSize"
    let KTotalPages = "TotalPages"
    let KTotalRecords = "TotalRecords"
    
    
    
    var agentRequestCategoryName    : String = ""
    var titleType                   : String = ""
    var countryName                 : String = ""
    var provinceName                : String = ""
    var districtName                : String = ""
    var mandalName                  : String = ""
    var villageName                 : String = ""
    var statusTypeId                : Int? = nil
    var statusType                  : String = ""
    var assignToUserId              : String = ""
    var assignToUserName            : String = ""
    var isActive                    : String = ""
    var createdBy                   : String = ""
    var modifiedBy                  : String = ""
    var id                          : Int? = nil
    var modified                    : String = ""
    var agentRequestCategoryId      : String = ""
    var titleTypeId                 : String = ""
    var firstName                   : String = ""
    var middleName                  : String = ""
    var lastName                    : String = ""
    var mobileNumber                : String = ""
    var email                       : String = ""
    var addressLine1                : String = ""
    var addressLine2                : String = ""
    var landmark                    : String = ""
    var villageId                   : Int? = nil
    var postCode                    : Int? = nil
    var comments                    : String = ""
    var created                     : String = ""
    var pageIndex                   : Int? = nil
    var pageSize                    : Int? = nil
    var totalPages                  : Int? = nil
    var totalRecords                : Int? = nil
    var provinceId                  : Int? = nil
    var districtId                  : Int? = nil
    var mandalId                    : Int? = nil
    
    
    
    
    
    override init() {
        
    }
    
    
    init(dict : NSDictionary?){
        
        super.init()
        
        
        if dict != nil {
            
            // Mark : -    Agent Request Info Parameters 
            
            
            
            if Utilities.sharedInstance.isObjectNull("\(dict![kAgentRequestCategoryName])" as AnyObject?) {
                
                if let parameterString = dict![kAgentRequestCategoryName] as? String{
                    
                    
                    agentRequestCategoryName = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![kTitleType])" as AnyObject?) {
                
                if let parameterString = dict![kTitleType] as? String{
                    
                    
                    titleType = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![kCountryName])" as AnyObject?) {
                
                if let parameterString = dict![kCountryName] as? String{
                    
                    
                    countryName = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![kProvinceName])" as AnyObject?) {
                
                if let parameterString = dict![kProvinceName] as? String{
                    
                    
                    provinceName = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![kDistrictName])" as AnyObject?) {
                
                if let parameterString = dict![kDistrictName] as? String{
                    
                    
                    districtName = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![kMandalName])" as AnyObject?) {
                
                if let parameterString = dict![kMandalName] as? String{
                    
                    
                    mandalName = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![kVillageName])" as AnyObject?) {
                
                if let parameterString = dict![kVillageName] as? String{
                    
                    
                    villageName = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![kStatusTypeId])" as AnyObject?) {
                
                if let parameterString = dict![kStatusTypeId] as? Int{
                    
                    
                    statusTypeId = parameterString
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![kStatusType])" as AnyObject?) {
                
                if let parameterString = dict![kStatusType] as? String{
                    
                    
                    statusType = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![kAssignToUserId])" as AnyObject?) {
                
                if let parameterString = dict![kAssignToUserId] as? String{
                    
                    
                    assignToUserId = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![kAssignToUserName])" as AnyObject?) {
                
                if let parameterString = dict![kAssignToUserName] as? String{
                    
                    
                    assignToUserName = (parameterString.characters.count) > 0 ? parameterString : ""
                    
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
            
            if Utilities.sharedInstance.isObjectNull("\(dict![kId])" as AnyObject?) {
                
                if let parameterString = dict![kId] as? Int{
                    
                    
                    id = parameterString
                    
                }
                
            }
            
            
            if Utilities.sharedInstance.isObjectNull("\(dict![kAgentRequestCategoryId])" as AnyObject?) {
                
                if let parameterString = dict![kAgentRequestCategoryId] as? String{
                    
                    
                    agentRequestCategoryId = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }

            if Utilities.sharedInstance.isObjectNull("\(dict![kTitleTypeId])" as AnyObject?) {
                
                if let parameterString = dict![kTitleTypeId] as? String{
                    
                    
                    titleTypeId = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            
            if Utilities.sharedInstance.isObjectNull("\(dict![kFirstName])" as AnyObject?) {
                
                if let parameterString = dict![kFirstName] as? String{
                    
                    
                    firstName = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![kMiddleName])" as AnyObject?) {
                
                if let parameterString = dict![kMiddleName] as? String{
                    
                    
                    middleName = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![kLastName])" as AnyObject?) {
                
                if let parameterString = dict![kLastName] as? String{
                    
                    
                    lastName = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            
            if Utilities.sharedInstance.isObjectNull("\(dict![kMobileNumber])" as AnyObject?) {
                
                if let parameterString = dict![kMobileNumber] as? String{
                    
                    
                    mobileNumber = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![kEmail])" as AnyObject?) {
                
                if let parameterString = dict![kEmail] as? String{
                    
                    
                    email = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![kAddressLine1])" as AnyObject?) {
                
                if let parameterString = dict![kAddressLine1] as? String{
                    
                    
                    addressLine1 = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            
            if Utilities.sharedInstance.isObjectNull("\(dict![kAddressLine2])" as AnyObject?) {
                
                if let parameterString = dict![kAddressLine2] as? String{
                    
                    
                    addressLine2 = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }

            
            if Utilities.sharedInstance.isObjectNull("\(dict![kLandmark])" as AnyObject?) {
                
                if let parameterString = dict![kLandmark] as? String{
                    
                    
                    landmark = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![kVillageId])" as AnyObject?) {
                
                if let parameterString = dict![kVillageId] as? Int {
                    
                    
                    villageId = parameterString
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![kPostCode])" as AnyObject?) {
                
                if let parameterString = dict![kPostCode] as? Int {
                    
                    
                    postCode = parameterString
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![kComments])" as AnyObject?) {
                
                if let parameterString = dict![kComments] as? String{
                    
                    
                    comments = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            
            if Utilities.sharedInstance.isObjectNull("\(dict![kCreated])" as AnyObject?) {
                
                if let parameterString = dict![kCreated] as? String{
                    
                    
                    created = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![KPageIndex])" as AnyObject?) {
                
                if let parameterString = dict![KPageIndex] as? Int{
                    
                    
                    pageIndex = parameterString
                    
                }
                
            }

            
            if Utilities.sharedInstance.isObjectNull("\(dict![KPageSize])" as AnyObject?) {
                
                if let parameterString = dict![KPageSize] as? Int{
                    
                    
                    pageSize = parameterString
                    
                }
                
            }

            
            if Utilities.sharedInstance.isObjectNull("\(dict![KTotalPages])" as AnyObject?) {
                
                if let parameterString = dict![KTotalPages] as? Int{
                    
                    
                    totalPages = parameterString
                    
                }
                
            }

            
            if Utilities.sharedInstance.isObjectNull("\(dict![KTotalRecords])" as AnyObject?) {
                
                if let parameterString = dict![KTotalRecords] as? Int{
                    
                    
                    totalRecords = parameterString
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![kProvinceId])" as AnyObject?) {
                
                if let parameterString = dict![kProvinceId] as? Int{
                    
                    
                    provinceId = parameterString
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![kDistrictId])" as AnyObject?) {
                
                if let parameterString = dict![kDistrictId] as? Int{
                    
                    
                    districtId = parameterString
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![kMandalId])" as AnyObject?) {
                
                if let parameterString = dict![kMandalId] as? Int{
                    
                    
                    mandalId = parameterString
                    
                }
                
            }


        
        }

        
    }
}
