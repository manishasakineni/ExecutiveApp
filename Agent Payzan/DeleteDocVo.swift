//
//  AgentRepositoryInfoVo.swift
//  PayZan
//
//  Created by Manoj on 23/11/17.
//  Copyright © 2017 CalibrageMac02. All rights reserved.
//

import Foundation


class DeleteDocVo: Mappable {
    
    // MARK: - Diclaration of Delete Documents Objects
    
    var ListResult:[DeleteDocResultVo]?
    
    var IsSuccess:Bool?
    var AffectedRecords:Int?
    var EndUserMessage:String?
    var ValidationErrors:AnyObject?
    
    // MARK: - Intialization of Delete Documents Objects
    
    init(ListResult:[DeleteDocResultVo]?, IsSuccess:Bool?, AffectedRecords:Int?,EndUserMessage:String?,ValidationErrors:AnyObject?) {
        
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

