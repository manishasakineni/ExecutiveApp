//
//  GetBankResultVo.swift
//  PayZan
//
//  Created by Manoj on 21/11/17.
//  Copyright © 2017 CalibrageMac02. All rights reserved.
//

import Foundation

class GetBankResultVo: Mappable {
    
    
    var BankTypeId: Int?
    var BankName: String?
    var BranchName: String?
    var SwiftCode: String?
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
    
    
    init(BankTypeId:Int?,BankName:String?,BranchName:String?,SwiftCode:String?,AgentId:String?,BankId:Int?,AccountHolderName:String?,AccountNumber:String?,Id:Int?,IsActive:Bool?,CreatedBy:String?,ModifiedBy:String?,Created:String?,Modified:String?) {
        
        self.BankTypeId = BankTypeId
        self.BankName = BankName
        self.BranchName = BranchName
        self.SwiftCode = SwiftCode
        self.AgentId = AgentId
        self.BankId = BankId!
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
        
        BankTypeId <- map["BankTypeId"]
        BankName <- map["BankName"]
        BranchName <- map["BranchName"]
        SwiftCode <- map["SwiftCode"]
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




