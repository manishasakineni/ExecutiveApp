//
//  ParsingModelClass.swift
//  Agent Payzan
//
//  Created by Nani Mac on 10/10/17.
//  Copyright © 2017 Naveen. All rights reserved.
//

import UIKit

class ParsingModelClass: NSObject {
    
    
    static let sharedInstance = ParsingModelClass()

   // Mark : - Parsing Model 
    
    func homeRequestAPIModelParsing(object: AnyObject?) -> Array<HomeRequestAPIModel> {
        
        var homeRequestsAPIModelArray = Array<HomeRequestAPIModel>()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
            if let response = object as? NSDictionary {
                
                let data = response["Result"]
                
                if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
                    
                    
                    if let response = data as? NSArray {
                        if Utilities.sharedInstance.isObjectNull(response) {
                            
                            for responses in response{
                            
                                let homeRequestAPImodel = HomeRequestAPIModel(dict: responses as? NSDictionary)
                                homeRequestsAPIModelArray.append(homeRequestAPImodel)
                            }
                            
                       
                                    
                             
                        }
                    }
                }
            }
        }
        
        return homeRequestsAPIModelArray
    }
    
    
    
    func updateAgentRequesgtInfoAPIModelParsing(object: AnyObject?) -> Array<UpdateAgentReqInfoParamsAPIModel> {
        
        var updateAgentRequesgtInfoAPIModelArray = Array<UpdateAgentReqInfoParamsAPIModel>()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
            if let response = object as? NSDictionary {
                
                let data = response["Result"]
                
                if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
                    
                    
                    if let response = data as? NSArray {
                        if Utilities.sharedInstance.isObjectNull(response) {
                            
                            if let response = data as? NSDictionary {
                                if Utilities.sharedInstance.isObjectNull(response) {
                                    
                                    let updateAgentRequesgtsArray = UpdateAgentReqInfoParamsAPIModel(dict: response)
                                    updateAgentRequesgtInfoAPIModelArray.append(updateAgentRequesgtsArray)
                                    
                                    
                                }
                            }
                        }
                    }
                }
            }
        }
        
        return updateAgentRequesgtInfoAPIModelArray
    }
    
    
    func agentRequesgtInfoAPIModelParsing(object: AnyObject?) -> Array<AgentReqInfoParamsAPIModel> {
        
        var agentRequesgtInfoAPIModelArray = Array<AgentReqInfoParamsAPIModel>()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
            if let response = object as? NSDictionary {
                
                let data = response["Result"]
                
                if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
                    
                    
                    if let response = data as? NSDictionary {
                        if Utilities.sharedInstance.isObjectNull(response) {
                            
                            if let agentRequestsResp = response["AgentRequestDetails"] as? NSArray {
                            
                            for agentRequesgts in agentRequestsResp {
                                
                                if Utilities.sharedInstance.isObjectNull(agentRequesgts as AnyObject?) {
                                    
                                    let agentRequesgtsArray = AgentReqInfoParamsAPIModel(dict: agentRequesgts as? NSDictionary)
                                    agentRequesgtInfoAPIModelArray.append(agentRequesgtsArray)
                                }
                            }
                            
                        }
                        }
                    }
                }
            }
        }
        
        return agentRequesgtInfoAPIModelArray
    }
    
    
    
    
    
    func getStatesAPIModelParsing(object: AnyObject?) -> Array<ParametersAPIModel> {
        
        var getStatesAPIModelArray = Array<ParametersAPIModel>()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
             if let response = object as? NSDictionary {
                
                let data = response["ListResult"]
                
                if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
                    
//                    if let response = data as? NSArray {
//                        
//                        if Utilities.sharedInstance.isObjectNull(response) {
//                            
//                            let getStatesArray = GetStatesAPIModel(dict: response)
//                            
//                            getStatesAPIModelArray.append(getStatesArray)
//                            
//                            
//                        }
//                    }
                    
                    if let response = data as? NSArray {
                        if Utilities.sharedInstance.isObjectNull(response) {
                            
                            for States in response {
                                
                                if Utilities.sharedInstance.isObjectNull(States as AnyObject?) {
                                    
                                    let getStatesArray = ParametersAPIModel(dict: States as? NSDictionary)
                                    getStatesAPIModelArray.append(getStatesArray)
                                }
                            }
                        }
                    }
                }
            }
        }
        
        return getStatesAPIModelArray
    }
    
    
//////////     Bank Names Parsing /////////
    
    
    func getBankNamesAPIModelParsing(object: AnyObject?) -> Array<ParametersAPIModel> {
        
        var getBankNamesAPIModelArray = Array<ParametersAPIModel>()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
            if let response = object as? NSDictionary {
                
                let data = response["ListResult"]
                
                if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
                    
                    //                    if let response = data as? NSArray {
                    //
                    //                        if Utilities.sharedInstance.isObjectNull(response) {
                    //
                    //                            let getStatesArray = GetStatesAPIModel(dict: response)
                    //
                    //                            getStatesAPIModelArray.append(getStatesArray)
                    //
                    //
                    //                        }
                    //                    }
                    
                    if let response = data as? NSArray {
                        if Utilities.sharedInstance.isObjectNull(response) {
                            
                            for banks in response {
                                
                                if Utilities.sharedInstance.isObjectNull(banks as AnyObject?) {
                                    
                                    let getBankNamesArray = ParametersAPIModel(dict: banks as? NSDictionary)
                                    getBankNamesAPIModelArray.append(getBankNamesArray)
                                }
                            }
                        }
                    }
                }
            }
        }
        
        return getBankNamesAPIModelArray
    }
    
    
    func getBankBranchesAPIModelParsing(object: AnyObject?) -> Array<ParametersAPIModel> {
        
        var getBankBranchesAPIModelArray = Array<ParametersAPIModel>()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
            if let response = object as? NSDictionary {
                
                let data = response["ListResult"]

                    if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
                        
                        
                        if let response = data as? NSArray {
                            if Utilities.sharedInstance.isObjectNull(response) {
                                
                                for BusinessCategory in response {
                                    
                                    if Utilities.sharedInstance.isObjectNull(BusinessCategory as AnyObject?) {
                                        
                                        let getBankBranchesArray = ParametersAPIModel(dict: BusinessCategory as? NSDictionary)
                                        getBankBranchesAPIModelArray.append(getBankBranchesArray)
                                    }
                                }
                            }
                        }
                    }
                   
                        
                        
                                    
                
                    
                    
                    
                    
                
            }
        }
        
        return getBankBranchesAPIModelArray
    }
    
    
    func getBusinessCategoryAPIModelParsing(object: AnyObject?) -> Array<ParametersAPIModel> {
        
        var getBusinessCategoryAPIModelArray = Array<ParametersAPIModel>()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
            if let response = object as? NSDictionary {
                
                let data = response["ListResult"]
                
                if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
                    
                    
                    if let response = data as? NSArray {
                        if Utilities.sharedInstance.isObjectNull(response) {
                            
                            for BusinessCategory in response {
                                
                                if Utilities.sharedInstance.isObjectNull(BusinessCategory as AnyObject?) {
                                    
                                    let BusinessCategoryArray = ParametersAPIModel(dict: BusinessCategory as? NSDictionary)
                                    getBusinessCategoryAPIModelArray.append(BusinessCategoryArray)
                                }
                            }
                        }
                    }
                }
            }
        }
        
        return getBusinessCategoryAPIModelArray
    }

    
    func getPersonalIDNameAPIModelParsing(object: AnyObject?) -> Array<ParametersAPIModel> {
        
        var getPersonalIDNameAPIModelArray = Array<ParametersAPIModel>()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
            if let response = object as? NSDictionary {
                
                let data = response["ListResult"]
                
                if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
     
                    if let response = data as? NSArray {
                        if Utilities.sharedInstance.isObjectNull(response) {
                            
                            for personalIDName in response {
                                
                                if Utilities.sharedInstance.isObjectNull(personalIDName as AnyObject?) {
                                    
                                    let personalIDNamesArray = ParametersAPIModel(dict: personalIDName as? NSDictionary)
                                    
                                    getPersonalIDNameAPIModelArray.append(personalIDNamesArray)
                                }
                            }
                        }
                    }
                }
            }
        }
        
        return getPersonalIDNameAPIModelArray
    }
    
    
    func getFinancialIDNameAPIModelParsing(object: AnyObject?) -> Array<ParametersAPIModel> {
        
        var getFinancialIDNameAPIModelArray = Array<ParametersAPIModel>()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
            if let response = object as? NSDictionary {
                
                let data = response["ListResult"]
                
                if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
                    

                    
                    if let response = data as? NSArray {
                        if Utilities.sharedInstance.isObjectNull(response) {
                            
                            for financialIDName in response {
                                
                                if Utilities.sharedInstance.isObjectNull(financialIDName as AnyObject?) {
                                    
                                    let financialIDNamesArray = ParametersAPIModel(dict: financialIDName as? NSDictionary)
                                    
                                    getFinancialIDNameAPIModelArray.append(financialIDNamesArray)
                                }
                            }
                        }
                    }
                }
            }
        }
        
        return getFinancialIDNameAPIModelArray
    }
    
    
    
    func getProvinceNameAPIModelParsing(object: AnyObject?) -> Array<ParametersAPIModel> {
        
        var getProvinceNameAPIModelArray = Array<ParametersAPIModel>()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
            if let response = object as? NSDictionary {
                
                let data = response["ListResult"]
                
                if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
                    
                    
                    
                    if let response = data as? NSArray {
                        if Utilities.sharedInstance.isObjectNull(response) {
                            
                            for provinceName in response {
                                
                                if Utilities.sharedInstance.isObjectNull(provinceName as AnyObject?) {
                                    
                                    let provinceNamesArray = ParametersAPIModel(dict: provinceName as? NSDictionary)
                                    
                                    getProvinceNameAPIModelArray.append(provinceNamesArray)
                                }
                            }
                        }
                    }
                }
            }
        }
        
        return getProvinceNameAPIModelArray
    }
    
    func getDistrictsAPIModelParsing(object: AnyObject?) -> Array<ParametersAPIModel> {
        
        var getDistrictsAPIModelArray = Array<ParametersAPIModel>()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
            if let response = object as? NSDictionary {
                
                let data = response["ListResult"]
                
                if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
                    
                    
                    
                    if let response = data as? NSArray {
                        if Utilities.sharedInstance.isObjectNull(response) {
                            
                            for districtName in response {
                                
                                if Utilities.sharedInstance.isObjectNull(districtName as AnyObject?) {
                                    
                                    let districtNamesArray = ParametersAPIModel(dict: districtName as? NSDictionary)
                                    
                                    getDistrictsAPIModelArray.append(districtNamesArray)
                                }
                            }
                        }
                    }
                }
            }
        }
        
        return getDistrictsAPIModelArray
    }
    
    func getMandalsAPIModelParsing(object: AnyObject?) -> Array<ParametersAPIModel> {
        
        var getMandalsAPIModelArray = Array<ParametersAPIModel>()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
            if let response = object as? NSDictionary {
                
                let data = response["ListResult"]
                
                if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
                    
                    
                    
                    if let response = data as? NSArray {
                        if Utilities.sharedInstance.isObjectNull(response) {
                            
                            for mandalName in response {
                                
                                if Utilities.sharedInstance.isObjectNull(mandalName as AnyObject?) {
                                    
                                    let mandalsNamesArray = ParametersAPIModel(dict: mandalName as? NSDictionary)
                                    
                                    getMandalsAPIModelArray.append(mandalsNamesArray)
                                }
                            }
                        }
                    }
                }
            }
        }
        
        return getMandalsAPIModelArray
    }

    func getVillagesAPIModelParsing(object: AnyObject?) -> Array<ParametersAPIModel> {
        
        var getVillagesAPIModelArray = Array<ParametersAPIModel>()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
            if let response = object as? NSDictionary {
                
                let data = response["ListResult"]
                
                if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
                    
                    
                    
                    if let response = data as? NSArray {
                        if Utilities.sharedInstance.isObjectNull(response) {
                            
                            for villageName in response {
                                
                                if Utilities.sharedInstance.isObjectNull(villageName as AnyObject?) {
                                    
                                    let villagesArray = ParametersAPIModel(dict: villageName as? NSDictionary)
                                    
                                    getVillagesAPIModelArray.append(villagesArray)
                                }
                            }
                        }
                    }
                }
            }
        }
        
        return getVillagesAPIModelArray
    }
    
    
    func getTitleTypeAPIModelParsing(object: AnyObject?) -> Array<ParametersAPIModel> {
        
        var getTitleTypeAPIModelArray = Array<ParametersAPIModel>()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
            if let response = object as? NSDictionary {
                
                let data = response["ListResult"]
                
                if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
                    
                    
                    
                    if let response = data as? NSArray {
                        if Utilities.sharedInstance.isObjectNull(response) {
                            
                            for titleType in response {
                                
                                if Utilities.sharedInstance.isObjectNull(titleType as AnyObject?) {
                                    
                                    let titleTypeArray = ParametersAPIModel(dict: titleType as? NSDictionary)
                                    
                                    getTitleTypeAPIModelArray.append(titleTypeArray)
                                }
                            }
                        }
                    }
                }
            }
        }
        
        return getTitleTypeAPIModelArray
    }
    
    func getGenderTypeAPIModelParsing(object: AnyObject?) -> Array<ParametersAPIModel> {
        
        var getGenderAPIModelArray = Array<ParametersAPIModel>()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
            if let response = object as? NSDictionary {
                
                let data = response["ListResult"]
                
                if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
                    
                    
                    
                    if let response = data as? NSArray {
                        if Utilities.sharedInstance.isObjectNull(response) {
                            
                            for gender in response {
                                
                                if Utilities.sharedInstance.isObjectNull(gender as AnyObject?) {
                                    
                                    let genderArray = ParametersAPIModel(dict: gender as? NSDictionary)
                                    
                                    getGenderAPIModelArray.append(genderArray)
                                }
                            }
                        }
                    }
                }
            }
        }
        
        return getGenderAPIModelArray
    }
    
}
