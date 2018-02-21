//
//  GetBankIdProofsVo.swift
//  PayZan
//
//  Created by Manoj on 21/11/17.
//  Copyright © 2017 CalibrageMac02. All rights reserved.
//

import Foundation
class GetIdProofsVo: Mappable {
    
    
    var ListResult:[GetIdProofResultVo]?
    
    
    var IsSuccess:Bool?
    var AffectedRecords:Int?
    var EndUserMessage:String?
    var ValidationErrors:AnyObject?
    var Exception:Any?
    
    
    
    init(ListResult:[GetIdProofResultVo]?, IsSuccess:Bool?, AffectedRecords:Int?,EndUserMessage:String?,ValidationErrors:AnyObject?, Exception:Any?) {
        
        self.ListResult = ListResult
        self.IsSuccess = IsSuccess
        self.AffectedRecords = AffectedRecords
        self.EndUserMessage = EndUserMessage
        self.ValidationErrors = ValidationErrors
        self.Exception = Exception
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        ListResult <- map["ListResult"]
        IsSuccess <- map["IsSuccess"]
        AffectedRecords <- map["AffectedRecords"]
        EndUserMessage <- map["EndUserMessage"]
        ValidationErrors <- map["ValidationErrors"]
        Exception <- map["Exception"]
        
    }
}
