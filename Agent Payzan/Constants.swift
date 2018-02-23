//
//  Constants.swift
//  YISCustomerApp
//
//  Created by Calibrage Mac on 17/08/17.
//  Copyright © 2017 Calibrage Mac. All rights reserved.
//

import Foundation

// MARK: - AppDelegate Constant

// API Urls

let BASE_API = "http://payzan.azurewebsites.net/api/"
//let BASE_API = "http://192.168.1.126/PayZanAPI/api/"
//let BASE_API = "http://192.168.1.126/PayZanService/api/"




let Registartion_API        =  BASE_API + "Register/Register"
let LOGIN_API               =  BASE_API + "Register/Login"
let HOME_API                =  BASE_API + "AgentRequestInfo/GetAgentRequestCountsByUserId/"
let COUNTRIES_API           =  BASE_API + "Countries/GetCountries/"
let STATES_API              =  BASE_API + "States/GetStates/"
let ADDAGENT_API            =  BASE_API + "Agent/AddAgent"
let BUSINESSCATEGORY_API    =  BASE_API + "TypeCdDmts/GetTypeCdDmtsByClassType/"
let BANKNAMES_API           =  BASE_API + "TypeCdDmts/GetTypeCdDmtsByClassType/"
let BANKBRANCHES_API        =  BASE_API + "Banks/GetBanksByBankTypeId/"
let PERSONALIDS_API         =  BASE_API + "TypeCdDmts/GetTypeCdDmtsByClassType/"
let FINANCIALIDS_API        =  BASE_API + "TypeCdDmts/GetTypeCdDmtsByClassType/"
let PROVINCE_API            =  BASE_API + "Province/GetProvinces/null"
let DISTRICTS_API           =  BASE_API + "Province/GetDistrictsByProvinceId/"
let MANDALS_API             =  BASE_API + "Mandals/GetMandalByDistrict/"
let VILLAGES_API            =  BASE_API + "Villages/GetVillageByMandal/"
let TITLETYPE_API           =  BASE_API + "TypeCdDmts/GetTypeCdDmtsByClassType/"
let GENDER_API              =  BASE_API + "TypeCdDmts/GetTypeCdDmtsByClassType/"
let AGENTREQUESTINFO_API    =  BASE_API + "AgentRequestInfo/GetAgentRequestInfo/"
let AGENTDOCUMENTS_API      =  BASE_API + "AgentFileRepository/AddAgentDocuments"
let UPDATEAGENTREQUESTINFO_API =  BASE_API + "AgentRequestInfo/UpdateAgentRequestStatus"

let REGISTERAGENT_API         = BASE_API + "Agent/RegisterAgent"

let GETAGENTPERSONALINFO_API  = BASE_API + "Agent/GetAgentsPersonalInfo/"
let ADDAGENTPERSONALINFO_API  = BASE_API + "Agent/GetAgentsPersonalInfoByUserName/"
let GETAGENTBANKINFO_API      = BASE_API + "AgentBank/GetAgentBankByAgentId/"
let GETAGENTIDPROOFS_API      = BASE_API + "AgentIdProof/GetAgentIdProofsByAgentId/"
let REGISTERBANK_API          = BASE_API + "AgentBank/insert"
let ADDIDPROOFS_API           = BASE_API + "AgentIdProof/AddAgentIdProofs"
let REGISTERIDPROOF_API       = BASE_API + "AgentIdProof/insert"


let UPDATEPERSONALINFO_API   = BASE_API + "Agent/UpdateAgentPersonalInfo"
let UPDATEBANKINFO_API       = BASE_API + "AgentBank/UpdateAgentBank"
let UPDATEIDPROOFS_API       = BASE_API + "AgentIdProof/UpdateAgentIdProofs"

let GETDOCUMENTS_API         = BASE_API + "AgentFileRepository/GetAgentFileRepository/"

let DELETEIDPROOF_API        = BASE_API + "AgentIdProof/delete/"
let DELETEDOCUMENT_API       = BASE_API + "AgentFileRepository/DeleteAgentDocument/"

let GETHISTORY_API           = BASE_API + "AgentRequestInfo/GetAgentRequestStatusHistory/"

let REFRESHTOKEN_API         = BASE_API + "Register/RequestRefreshToken"


let AuserName : String = "AuserName"
let AId : String       = "AId"
let AmobileNumber : String = "AmobileNumber"
let Aemail : String    = "Aemail"
let ArefreshToken : String = "ArefreshToken"
let AExpiresIn    : String = "AExpiresIn"


let kToastDuration  = 3.0
let kNetworkStatusMessage = "app.Pleasecheckyourinternetconnection!".localize()

let SVHUDMESSAGE = "Loading..."
let KFirstTimeLogin = "first Time Login"
let KAccessToken = "KAccessToken"
let KTokenType = "KTokenType"


let kRequestTimedOutMessage = "app.Therequesttimedout".localize()


