//
//  HomeRequestAPIModel.swift
//  Agent Payzan
//
//  Created by N@n!'$ Mac on 15/11/17.
//  Copyright © 2017 Naveen. All rights reserved.
//

import UIKit

class HomeRequestAPIModel: NSObject {
    
    
    let KCount = "Count"
    let KStatusType = "StatusType"
    let KStatusTypeId = "StatusTypeId"
    
    
    var  count       : String = ""
    var statusType   : String = ""
    var statusTypeId : String = ""
    
    override init() {
        
    }
    
    
    init(dict : NSDictionary?){
        
        super.init()
        
        
        if dict != nil {
            
        // Mark : - Home Requests Parameters 
            
            if Utilities.sharedInstance.isObjectNull("\(dict![KCount])" as AnyObject){
                
                
                if let parameterString = dict![KCount] as? NSNumber{
                    
                    count = parameterString.stringValue
                }
                    
                else if let parameterString = dict![KCount] as? String {
                    
                    count = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![KStatusType])" as AnyObject){
                
                
                if let parameterString = dict![KStatusType] as? NSNumber{
                    
                    statusType = parameterString.stringValue
                }
                    
                else if let parameterString = dict![KStatusType] as? String {
                    
                    statusType = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            if Utilities.sharedInstance.isObjectNull("\(dict![KStatusTypeId])" as AnyObject){
                
                
                if let parameterString = dict![KStatusTypeId] as? NSNumber{
                    
                    statusTypeId = parameterString.stringValue
                }
                    
                else if let parameterString = dict![KStatusTypeId] as? String {
                    
                    statusTypeId = (parameterString.characters.count) > 0 ? parameterString : ""
                    
                }
                
            }
            
            
            
        }
    }
}



