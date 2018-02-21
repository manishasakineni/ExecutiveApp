//
//  AgentRequestStatusHistoryResultVo.swift
//  PayZan
//
//  Created by Manoj on 23/11/17.
//  Copyright © 2017 CalibrageMac02. All rights reserved.
//

import Foundation

class AgentRequestStatusHistoryResultVo: Mappable {


var StatusType: String?
var AssignToUser: String?
var AgentRequestId: Int?
var StatusTypeId: Int?
var AssignToUserId: String?
var Comments: String?
var Id: Int?
var IsActive: Bool?
var CreatedBy: String?
var ModifiedBy: String?
var Created: String?
var Modified: String?


init(StatusType:String?,AssignToUser:String?,AgentRequestId:Int?,StatusTypeId:Int?,AssignToUserId:String?,Comments:String?,Id:Int?,IsActive:Bool?,CreatedBy:String?,ModifiedBy:String?,Created:String?,Modified:String?) {
    
    self.StatusType = StatusType
    self.AssignToUser = AssignToUser
    self.AgentRequestId = AgentRequestId
    self.StatusTypeId = StatusTypeId
    self.AssignToUserId = AssignToUserId
    self.Comments = Comments
    self.Id = Id
    self.IsActive = IsActive
    self.CreatedBy = CreatedBy
    self.ModifiedBy = ModifiedBy
    self.Created = Created
    self.Modified = Modified
    
}

required init?(map: Map) {
    
}

func mapping(map: Map) {
    
    
    StatusType <- map["StatusType"]
    AssignToUser <- map["AssignToUser"]
    AgentRequestId <- map["AgentRequestId"]
    StatusTypeId <- map["StatusTypeId"]
    AssignToUserId <- map["AssignToUserId"]
    Comments <- map["Comments"]
    Id <- map["Id"]
    IsActive <- map["IsActive"]
    CreatedBy <- map["CreatedBy"]
    ModifiedBy <- map["ModifiedBy"]
    Created <- map["Created"]
    Modified <- map["Modified"]
    
    
    
}

}
