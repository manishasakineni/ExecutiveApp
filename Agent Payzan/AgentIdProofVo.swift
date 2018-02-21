//
//  AgentIdProofVo.swift
//  Agent Payzan
//
//  Created by CalibrageMac02 on 21/11/17.
//  Copyright © 2017 Naveen. All rights reserved.
//

import Foundation
//{
//    "Result": {
//        "AgentId": "e39e192a-ac0b-4160-bf39-dc21f1bfaa92",
//        "IdProofTypeId": 28,
//        "IdProofNumber": "33333WWW",
//        "Id": 155,
//        "IsActive": true,
//        "CreatedBy": "05e3b552-21f3-486f-9b6c-41cdf738f2b8",
//        "ModifiedBy": "05e3b552-21f3-486f-9b6c-41cdf738f2b8",
//        "Created": "2017-11-21T18:08:09.2122391+05:30",
//        "Modified": "2017-11-21T18:08:09.2122433+05:30"
//    },
//    "IsSuccess": true,
//    "AffectedRecords": 1,
//    "EndUserMessage": "Record Saved Successfully",
//    "ValidationErrors": [],
//    "Exception": null
//}


class AgentIdProofVo: Mappable {
    
    var ListResult: [AgentIdProofResultVo]?
    var IsSuccess: Bool?
    var AffectedRecords: Int?
    var EndUserMessage: String?
    var ValidationErrors: Any?
    var Exception: Any?
    
    
    
    init(ListResult:[AgentIdProofResultVo]?, IsSuccess:Bool?,AffectedRecords:Int?, EndUserMessage:String?,ValidationErrors:Any?, Exception:Any?) {
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
