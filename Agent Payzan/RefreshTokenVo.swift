//
//  RefreshTokenVo.swift
//  Agent Payzan
//
//  Created by N@n!'$ Mac on 28/12/17.
//  Copyright © 2017 Naveen. All rights reserved.
//

import Foundation

class RefreshTokenVo: Mappable {
    
    
    var Result:RefreshTokenResultVo?
    
    
    var IsSuccess:Bool?
    var AffectedRecords:Int?
    var EndUserMessage:String?
    var ValidationErrors:AnyObject?
    var Exception:Any?
    
    
    
    init(Result:RefreshTokenResultVo?, IsSuccess:Bool?, AffectedRecords:Int?,EndUserMessage:String?,ValidationErrors:AnyObject?, Exception:Any?) {
        
        self.Result = Result
        self.IsSuccess = IsSuccess
        self.AffectedRecords = AffectedRecords
        self.EndUserMessage = EndUserMessage
        self.ValidationErrors = ValidationErrors
        self.Exception = Exception
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        Result <- map["Result"]
        IsSuccess <- map["IsSuccess"]
        AffectedRecords <- map["AffectedRecords"]
        EndUserMessage <- map["EndUserMessage"]
        ValidationErrors <- map["ValidationErrors"]
        Exception <- map["Exception"]
        
    }
}
