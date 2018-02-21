//
//  UpdateAgentBankResultVo.swift
//  PayZan
//
//  Created by Manoj on 22/11/17.
//  Copyright © 2017 CalibrageMac02. All rights reserved.
//

import Foundation

class UpdateAgentBankResultVo: Mappable {
    
    
    var AgentId: String?
    var BankId: Int?
    var AccountHolderName: String?
    var AccountNumber: String?
    var Id: Int?
    var IsActive: Bool?
    var CreatedBy: String?
    var ModifiedBy: String?
    var Created: String?
    var Modified: String?
    
    
    init(AgentId:String?,BankId:Int?,AccountHolderName:String?,AccountNumber:String?,Id:Int?,IsActive:Bool?,CreatedBy:String?,ModifiedBy:String?,Created:String?,Modified:String?) {
        
        self.AgentId = AgentId
        self.BankId = BankId
        self.AccountHolderName = AccountHolderName
        self.AccountNumber = AccountNumber
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
        BankId <- map["BankId"]
        AccountHolderName <- map["AccountHolderName"]
        AccountNumber <- map["AccountNumber"]
        Id <- map["Id"]
        IsActive <- map["IsActive"]
        CreatedBy <- map["CreatedBy"]
        ModifiedBy <- map["ModifiedBy"]
        Created <- map["Created"]
        Modified <- map["Modified"]
        
        
        
    }
    
}
