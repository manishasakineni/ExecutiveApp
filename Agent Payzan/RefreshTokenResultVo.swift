//
//  RefreshTokenResultVo.swift
//  Agent Payzan
//
//  Created by N@n!'$ Mac on 28/12/17.
//  Copyright © 2017 Naveen. All rights reserved.
//

import Foundation

class RefreshTokenResultVo: Mappable {



    var AccessToken: String?
    var RefreshToken: String?
    var ExpiresIn: Int?
    var TokenType: String?
  
    
    
    init(AccessToken:String?,RefreshToken:String?,ExpiresIn:Int?,TokenType:String?) {
        
        self.AccessToken = AccessToken
        self.RefreshToken = RefreshToken
        self.ExpiresIn = ExpiresIn
        self.TokenType = TokenType
        
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        AccessToken <- map["AccessToken"]
        RefreshToken <- map["RefreshToken"]
        ExpiresIn <- map["ExpiresIn"]
        TokenType <- map["TokenType"]
        
        
        
        
    }





}
