//
//  AgentReqCountResultVo.swift
//  Agent Payzan
//
//  Created by CalibrageMac02 on 23/11/17.
//  Copyright © 2017 Naveen. All rights reserved.
//

import Foundation
class AgentReqCountResultVo: Mappable {
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
    
    var StatusCounts:[AgentReqStatusCountVo]?
    var Agents:Int?
    var Consumers:Int?
    
    
    init(StatusCounts:[AgentReqStatusCountVo?],Agents:Int?,Consumers:Int?) {
        
        self.StatusCounts = StatusCounts as? [AgentReqStatusCountVo]
        self.Agents = Agents
        self.Consumers = Consumers
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        StatusCounts <- map["StatusCounts"]
        
        
    }
}
