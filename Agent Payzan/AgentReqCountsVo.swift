//
//  AgentReqCountsVo.swift
//  Agent Payzan
//
//  Created by CalibrageMac02 on 23/11/17.
//  Copyright © 2017 Naveen. All rights reserved.
//

import Foundation

//{
//    "Result": {
//        "StatusCounts": [
//        {
//        "StatusTypeId": 50,
//        "StatusType": "Hold for Review",
//        "Count": 0
//        }
//        ],
//        "Agents": 0,
//        "Consumers": 0
//    },
//    "IsSuccess": true,
//    "AffectedRecords": 1,
//    "EndUserMessage": "Get Agent Request Counts Success",
//    "ValidationErrors": [],
//    "Exception": null
//}
class AgentReqCountsVo: Mappable {
    
    var Result:AgentReqCountResultVo?
    
    var IsSuccess:Bool?
    var AffectedRecords:Int?
    var EndUserMessage:String?
    var ValidationErrors:AnyObject?
    
    
    
    init(Result:AgentReqCountResultVo?, IsSuccess:Bool?, AffectedRecords:Int?,EndUserMessage:String?,ValidationErrors:AnyObject?) {
        
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
