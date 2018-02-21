//
//  DeleteIdProofResultVo.swift
//  Agent Payzan
//
//  Created by N@n!'$ Mac on 24/11/17.
//  Copyright © 2017 Naveen. All rights reserved.
//

import Foundation
class DeleteIdProofResultVo: Mappable {
    
    
    
    var AgentId: String?
    var IdProofTypeId: Int?
    var IdProofNumber: String?

    var Id: Int?
    var IsActive: Bool?
    var CreatedBy: String?
    var ModifiedBy: String?
    var Created: String?
    var Modified: String?
    
    
    init(AgentId:String?,IdProofTypeId:Int?,IdProofNumber:String?,Id:Int?,IsActive:Bool?,CreatedBy:String?,ModifiedBy:String?,Created:String?,Modified:String?) {
        
        self.AgentId = AgentId
        self.IdProofTypeId = IdProofTypeId
        self.IdProofNumber = IdProofNumber
        
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
        IdProofTypeId <- map["IdProofTypeId"]
        IdProofNumber <- map["IdProofNumber"]
        Id <- map["Id"]
        IsActive <- map["IsActive"]
        CreatedBy <- map["CreatedBy"]
        ModifiedBy <- map["ModifiedBy"]
        Created <- map["Created"]
        Modified <- map["Modified"]
        
    }
    
}

