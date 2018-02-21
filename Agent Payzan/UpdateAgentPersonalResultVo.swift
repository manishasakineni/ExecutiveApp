//
//  UpdateAgentPersonalResultVo.swift
//  PayZan
//
//  Created by Manoj on 22/11/17.
//  Copyright © 2017 CalibrageMac02. All rights reserved.
//

import Foundation

class UpdateAgentPersonalResultVo: Mappable {
    
    
    
    
    var AspNetUserId: String?
    var TitleTypeId: Int?
    var FirstName: String?
    var MiddleName: String?
    var LastName: String?
    var Phone: String?
    var Email: String?
    var GenderTypeId: Int?
    var DOB: String?
    var Address1: String?
    var Address2: String?
    var Landmark: String?
    var VillageId: Int?
    var ParentAspNetUserId: String?
    var EducationTypeId: Int?
    var Id: Int?
    var IsActive: Bool?
    var CreatedBy: String?
    var ModifiedBy: String?
    var Created: String?
    var Modified: String?
    
    
    init(AspNetUserId:String?,TitleTypeId:Int?,FirstName:String?,MiddleName:String?,LastName:String?,Phone:String?,Email:String?,GenderTypeId:Int?,DOB:String?,Address1:String?,Address2:String?,Landmark:String?,VillageId:Int?,ParentAspNetUserId:String?,EducationTypeId:Int?,Id:Int?,IsActive:Bool?,CreatedBy:String?,ModifiedBy:String?,Created:String?,Modified:String?) {
        
        self.AspNetUserId = AspNetUserId
        self.TitleTypeId = TitleTypeId
        self.FirstName = FirstName
        self.MiddleName = MiddleName
        self.LastName = LastName
        self.Phone = Phone
        self.Email = Email
        self.GenderTypeId = GenderTypeId
        self.DOB = DOB
        self.Address1 = Address1
        self.Address2 = Address2
        self.Landmark = Landmark
        self.VillageId = VillageId
        self.ParentAspNetUserId = ParentAspNetUserId
        self.EducationTypeId = EducationTypeId
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
        
        AspNetUserId <- map["AspNetUserId"]
        TitleTypeId <- map["TitleTypeId"]
        FirstName <- map["FirstName"]
        MiddleName <- map["MiddleName"]
        LastName <- map["LastName"]
        Phone <- map["Phone"]
        Email <- map["Email"]
        GenderTypeId <- map["GenderTypeId"]
        DOB <- map["DOB"]
        Address1 <- map["Address1"]
        Address2 <- map["Address2"]
        Landmark <- map["Landmark"]
        VillageId <- map["VillageId"]
        ParentAspNetUserId <- map["ParentAspNetUserId"]
        EducationTypeId <- map["EducationTypeId"]
        Id <- map["Id"]
        IsActive <- map["IsActive"]
        CreatedBy <- map["CreatedBy"]
        ModifiedBy <- map["ModifiedBy"]
        Created <- map["Created"]
        Modified <- map["Modified"]
        
        
        
    }
    
}



