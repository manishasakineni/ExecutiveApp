//
//  AgentBankResultVo.swift
//  Agent Payzan
//
//  Created by CalibrageMac02 on 21/11/17.
//  Copyright © 2017 Naveen. All rights reserved.
//

import Foundation
class AgentBankResultVo: Mappable {
    
//    "Result": {
//    "AgentId": "e39e192a-ac0b-4160-bf39-dc21f1bfaa92",
//    "BankId": 15,
//    "AccountHolderName": "madhu",
//    "AccountNumber": "3443333333",
//    "Id": 147,
//    "IsActive": true,
//    "CreatedBy": "05e3b552-21f3-486f-9b6c-41cdf738f2b8",
//    "ModifiedBy": "05e3b552-21f3-486f-9b6c-41cdf738f2b8",
//    "Created": "2017-11-21T17:32:36.2830273+05:30",
//    "Modified": "2017-11-21T17:32:36.2830578+05:30"
//    }
    
    
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
        self.AccountNumber = AccountNumber!
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
