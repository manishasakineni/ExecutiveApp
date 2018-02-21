//
//  AgentDocResultVo.swift
//  Agent Payzan
//
//  Created by CalibrageMac02 on 22/11/17.
//  Copyright © 2017 Naveen. All rights reserved.
//

import Foundation

class AgentDocResultVo: Mappable {
    
//    {
    //    "AgentId": "string",
    //    "FileName": "string",
    //    "FileLocation": "string",
    //    "FileExtension": "string",
    //    "FileTypeId": 0,
    //    "Id": 0,
    //    "IsActive": true,
    //    "CreatedBy": "string",
    //    "ModifiedBy": "string",
    //    "Created": "2017-11-22T05:22:50.400Z",
    //    "Modified": "2017-11-22T05:22:50.400Z"
    //    }
    
    var AgentId: String?
    var FileName: String?
    var FileLocation: String?
    var FileExtension: String?
    var FileTypeId: Int?
    
    var Id: Int?
    var IsActive: Bool?
    var CreatedBy: String?
    var ModifiedBy: String?
    var Created: String?
    var Modified: String?
    
    init(AgentId:String?,FileName:String?,FileLocation:String?, FileExtension:String?,FileTypeId:Int?,Id:Int?,IsActive:Bool?,CreatedBy:String?,ModifiedBy:String?,Created:String?,Modified:String?) {
        
        self.AgentId = AgentId
        self.FileName = FileName
        self.FileLocation = FileLocation
        self.FileExtension = FileExtension
        self.FileTypeId = FileTypeId
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
        
        AgentId <- map["AgentId"]
        FileName <- map["FileName"]
        FileLocation <- map["FileLocation"]
        FileExtension <- map["FileExtension"]
        FileTypeId <- map["FileTypeId"]
        Id <- map["Id"]
        IsActive <- map["IsActive"]
        CreatedBy <- map["CreatedBy"]
        ModifiedBy <- map["ModifiedBy"]
        Created <- map["Created"]
        Modified <- map["Modified"]
        
        
    }
    
}
