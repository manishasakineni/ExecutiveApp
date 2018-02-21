//
//  UpdateAgentPersonalInfoVo.swift
//  PayZan
//
//  Created by Manoj on 22/11/17.
//  Copyright © 2017 CalibrageMac02. All rights reserved.
//

import Foundation

class UpdateAgentPersonalInfoVo: Mappable {
    
    
    var Result:UpdateAgentPersonalResultVo?
    
    
    var IsSuccess:Bool?
    var AffectedRecords:Int?
    var EndUserMessage:String?
    var ValidationErrors:AnyObject?
    
    
    
    init(Result:UpdateAgentPersonalResultVo?, IsSuccess:Bool?, AffectedRecords:Int?,EndUserMessage:String?,ValidationErrors:AnyObject?) {
        
        self.Result = Result
        self.IsSuccess = IsSuccess
        self.AffectedRecords = AffectedRecords
        self.EndUserMessage = EndUserMessage
        self.ValidationErrors = ValidationErrors
        
            }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        Result <- map["Result"]
        IsSuccess <- map["IsSuccess"]
        AffectedRecords <- map["AffectedRecords"]
        EndUserMessage <- map["EndUserMessage"]
        ValidationErrors <- map["ValidationErrors"]
        
        
           }
}






