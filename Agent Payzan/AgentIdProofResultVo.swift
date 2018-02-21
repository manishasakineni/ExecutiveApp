//
//  AgentIdProofResultVo.swift
//  Agent Payzan
//
//  Created by CalibrageMac02 on 21/11/17.
//  Copyright © 2017 Naveen. All rights reserved.
//

import Foundation

class AgentIdProofResultVo: Mappable {
    
//    "AgentId": "e39e192a-ac0b-4160-bf39-dc21f1bfaa92",
    //        "IdProofTypeId": 28,
    //        "IdProofNumber": "33333WWW",
    //        "Id": 155,
    //        "IsActive": true,
    //        "CreatedBy": "05e3b552-21f3-486f-9b6c-41cdf738f2b8",
    //        "ModifiedBy": "05e3b552-21f3-486f-9b6c-41cdf738f2b8",
    //        "Created": "2017-11-21T18:08:09.2122391+05:30",
    //        "Modified": "2017-11-21T18:08:09.2122433+05:30"
    
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
