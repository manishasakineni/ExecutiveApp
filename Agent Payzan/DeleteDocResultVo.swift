//
//  AgentRepositoryResultVo.swift
//  PayZan
//
//  Created by Manoj on 23/11/17.
//  Copyright © 2017 CalibrageMac02. All rights reserved.
//

import Foundation


class DeleteDocResultVo: Mappable {
    
    
    
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
    
    
    init(AgentId:String?,FileName:String?,FileLocation:String?,FileExtension:String?,FileTypeId:Int?,Id:Int?,IsActive:Bool?,CreatedBy:String?,ModifiedBy:String?,Created:String?,Modified:String?) {
        
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

