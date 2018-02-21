//
//  AgentRequestStatusHistoryInfoVo.swift
//  PayZan
//
//  Created by Manoj on 23/11/17.
//  Copyright © 2017 CalibrageMac02. All rights reserved.
//

import Foundation


class AgentRequestStatusHistoryInfoVo: Mappable {
    
    var ListResult:AgentRequestStatusHistoryResultVo?
    
    var IsSuccess:Bool?
    var AffectedRecords:Int?
    var EndUserMessage:String?
    var ValidationErrors:AnyObject?
    
    
    
    init(ListResult:AgentRequestStatusHistoryResultVo?, IsSuccess:Bool?, AffectedRecords:Int?,EndUserMessage:String?,ValidationErrors:AnyObject?) {
        
        self.ListResult = ListResult
        self.IsSuccess = IsSuccess
        self.AffectedRecords = AffectedRecords
        self.EndUserMessage = EndUserMessage
        self.ValidationErrors = ValidationErrors
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        ListResult <- map["ListResult"]
        IsSuccess <- map["IsSuccess"]
        AffectedRecords <- map["AffectedRecords"]
        EndUserMessage <- map["EndUserMessage"]
        ValidationErrors <- map["ValidationErrors"]
        
        
    }
}

