//
//  AgentDocumentsVo.swift
//  Agent Payzan
//
//  Created by CalibrageMac02 on 22/11/17.
//  Copyright © 2017 Naveen. All rights reserved.
//

import Foundation
//{
//    "ListResult": [
//    {
//    "AgentId": "string",
//    "FileName": "string",
//    "FileLocation": "string",
//    "FileExtension": "string",
//    "FileTypeId": 0,
//    "Id": 0,
//    "IsActive": true,
//    "CreatedBy": "string",
//    "ModifiedBy": "string",
//    "Created": "2017-11-22T05:22:50.400Z",
//    "Modified": "2017-11-22T05:22:50.400Z"
//    }
//    ],
//    "IsSuccess": true,
//    "AffectedRecords": 0,
//    "EndUserMessage": "string",
//    "ValidationErrors": [
//    {
//    "Name": "string",
//    "Description": "string"
//    }
//    ],
//    "Exception": {}
//}

class AgentDocumentsVo: Mappable {
    
    var ListResult: [AgentDocResultVo]?
    var IsSuccess: Bool?
    var AffectedRecords: Int?
    var EndUserMessage: String?
    var ValidationErrors: Any?
    var Exception: Any?
    
    
    
    init(ListResult:[AgentDocResultVo]?, IsSuccess:Bool?,AffectedRecords:Int?, EndUserMessage:String?,ValidationErrors:Any?, Exception:Any?) {
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

