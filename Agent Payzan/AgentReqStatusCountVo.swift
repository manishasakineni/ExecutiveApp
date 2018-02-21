//
//  AgentReqStatusCountVo.swift
//  Agent Payzan
//
//  Created by CalibrageMac02 on 23/11/17.
//  Copyright © 2017 Naveen. All rights reserved.
//

import Foundation

class AgentReqStatusCountVo: Mappable {
    
    
    //        "StatusCounts": [
    //        {
    //        "StatusTypeId": 50,
    //        "StatusType": "Hold for Review",
    //        "Count": 0
    //        }
    //        ]
   
    var StatusTypeId:Int?
    var StatusType:String?
    var Count:Int?
    
    
    
    init(StatusTypeId:Int?, StatusType:String?,Count:Int?) {
        
        self.StatusTypeId = StatusTypeId
        self.StatusType = StatusType
        self.Count = Count
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        StatusTypeId <- map["StatusTypeId"]
        StatusType <- map["StatusType"]
        Count <- map["Count"]
        
        
    }
}
