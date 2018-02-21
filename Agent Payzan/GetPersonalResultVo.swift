//
//  GetPersonalResultVo.swift
//  PayZan
//
//  Created by Manoj on 21/11/17.
//  Copyright © 2017 CalibrageMac02. All rights reserved.
//

import Foundation


class GetPersonalResultVo: Mappable {
    
    var UserName: String?
    var TitleTypeName: String?
    var GenderType: String?
    var BusinessCategoryTypeId: Int?
    var BusinessCategoryName: String?
    var StateName: String?
    var StateId: Int?
    var ProvinceName: String?
    var ProvinceId: Int?
    var DistrictName: String?
    var DistrictId: Int?
    var CountryId: Int?
    var CountryName: String?
    var VillageName: String?
    var MandalName: String?
    var MandalId: Int?
    var PostCode: Int?
    var AgentRequestId: Int?
    var ParentAspNetUserFirstName: String?
    var ParentAspNetUserMiddleName: String?
    var ParentAspNetUserLastName: String?
    var ParentAspNetUserPhoneNumber: String?
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

    
    
    
    init(UserName:String?,TitleTypeName:String?,GenderType:String?,BusinessCategoryTypeId:Int?,BusinessCategoryName:String?,StateName:String?,StateId:Int?,ProvinceName:String?,ProvinceId:Int?,DistrictName:String?,DistrictId:Int?,CountryName:String?,VillageName:String?,MandalName:String?,MandalId:Int?,PostCode:Int?,AgentRequestId:Int?,ParentAspNetUserFirstName:String?,ParentAspNetUserMiddleName:String?,ParentAspNetUserLastName:String?,ParentAspNetUserPhoneNumber:String?,AspNetUserId:String?,TitleTypeId:Int?,FirstName:String?,MiddleName:String?,LastName:String?,Phone:String?,Email:String?,GenderTypeId:Int?,DOB:String?,Address1:String?,Address2:String?,Landmark:String?,VillageId:Int?,ParentAspNetUserId:String?,EducationTypeId:Int?,Id:Int?,IsActive:Bool?,CreatedBy:String?,ModifiedBy:String?,Created:String?,Modified:String?) {
        
        self.UserName = UserName
        self.TitleTypeName = TitleTypeName
        self.GenderType = GenderType
        self.BusinessCategoryTypeId = BusinessCategoryTypeId
        self.BusinessCategoryName = BusinessCategoryName
        self.StateName = StateName!
        self.StateId = StateId
        self.ProvinceName = ProvinceName
        self.ProvinceId = ProvinceId
        self.DistrictName = DistrictName
        self.DistrictId = DistrictId
        self.CountryName = CountryName
        self.VillageName = VillageName
        self.MandalName = MandalName
        self.MandalId = MandalId!
        self.PostCode = PostCode
        self.AgentRequestId = AgentRequestId
        self.ParentAspNetUserFirstName = ParentAspNetUserFirstName
        self.ParentAspNetUserMiddleName = ParentAspNetUserMiddleName
        self.ParentAspNetUserLastName = ParentAspNetUserLastName
        self.ParentAspNetUserPhoneNumber = ParentAspNetUserPhoneNumber
        self.AspNetUserId = AspNetUserId
        self.TitleTypeId = TitleTypeId
        self.FirstName = FirstName!
        self.MiddleName = MiddleName
        self.LastName = LastName
        self.Phone = Phone
        self.Email = Email
        self.GenderTypeId = GenderTypeId
        self.DOB = DOB
        self.Address1 = Address1
        self.Address2 = Address2
        self.Landmark = Landmark!
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
        
        UserName <- map["UserName"]
        TitleTypeName <- map["TitleTypeName"]
        GenderType <- map["GenderType"]
        BusinessCategoryTypeId <- map["BusinessCategoryTypeId"]
        BusinessCategoryName <- map["BusinessCategoryName"]
        StateName <- map["StateName"]
        StateId <- map["StateId"]
        ProvinceName <- map["ProvinceName"]
        ProvinceId <- map["ProvinceId"]
        DistrictName <- map["DistrictName"]
        DistrictId <- map["DistrictId"]
        CountryName <- map["CountryName"]
        VillageName <- map["VillageName"]
        MandalName <- map["MandalName"]
        MandalId <- map["MandalId"]
        PostCode <- map["PostCode"]
        AgentRequestId <- map["AgentRequestId"]
        ParentAspNetUserFirstName <- map["ParentAspNetUserFirstName"]
        ParentAspNetUserMiddleName <- map["ParentAspNetUserMiddleName"]
        ParentAspNetUserLastName <- map["ParentAspNetUserLastName"]
        ParentAspNetUserPhoneNumber <- map["ParentAspNetUserPhoneNumber"]
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




