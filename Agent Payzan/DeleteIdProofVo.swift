//
//  DeleteIdProofVo.swift
//  Agent Payzan
//
//  Created by N@n!'$ Mac on 24/11/17.
//  Copyright © 2017 Naveen. All rights reserved.
//

import Foundation


class DeleteIdProofVo: Mappable {
    
    var Result:DeleteIdProofResultVo?
    
    
    var IsSuccess:Bool?
    var AffectedRecords:Int?
    var EndUserMessage:String?
    var ValidationErrors:AnyObject?
    
    
    
    init(Result:DeleteIdProofResultVo?, IsSuccess:Bool?, AffectedRecords:Int?,EndUserMessage:String?,ValidationErrors:AnyObject?) {
        
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

/*
{
    "Result": {
        "AgentId": "string",
        "IdProofTypeId": 0,
        "IdProofNumber": "string",
        "Id": 0,
        "IsActive": true,
        "CreatedBy": "string",
        "ModifiedBy": "string",
        "Created": "2017-11-24T16:56:21.752Z",
        "Modified": "2017-11-24T16:56:21.752Z"
    },
    "IsSuccess": true,
    "AffectedRecords": 0,
    "EndUserMessage": "string",
    "ValidationErrors": [
    {
    "Name": "string",
    "Description": "string"
    }
    ],
    "Exception": {}
}
 
 */
