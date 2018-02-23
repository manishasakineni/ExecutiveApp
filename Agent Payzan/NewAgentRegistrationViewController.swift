//
//  NewAgentRegistrationViewController.swift
//  Agent Payzan
//
//  Created by Nani Mac on 05/10/17.
//  Copyright © 2017 Naveen. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import TextFieldEffects

class NewAgentRegistrationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,MKMapViewDelegate,CLLocationManagerDelegate,UITextFieldDelegate {
    
    let todayDate = NSDate()
    var alertTag = Int()
    
    var newVC1           : Int    = 0
    var userName         : String = ""
    var password         : String = ""
    var mobileNumber     : String = ""
    var genderType       : String = ""
    var fName            : String = ""
    var mName            : String = ""
    var lName            : String = ""
    var titleType        : String = ""
    var eMail            : String = ""
    var DOB              : String = ""
    var phoneNo          : String = ""
  //  var agentReqId       : Int = 0
    var address1Str      : String = ""
    var address2Str      : String = ""
    var landMarkStr      : String = ""
    var agencyName       : String = ""
    
    var state          : String = ""
    var postalCode     : String = ""
    var latlan         : String = ""
    var titleTypeID    : Int    = 0
    var provinceID     : Int    = 0
    var districtID     : Int    = 0
    var mandalID       : Int    = 0
    var businessID     : Int    = 0
    var villageID      : Int    = 0
    var genderTypeID   : Int    = 0
    var pincode        : String = ""
   
    
    var aspNetUserId    : String = ""
    var createdById     : String = ""
    var parentNetUSerId : String = ""
    var isActiveUpdate  : Bool!
    var idUpdate        : Int = 0
    var educationIdUpdate :Int = 0
    var agentReqIdUpdate  :Int = 0
    
    var villageIdUpdate   :Int = 0
    var businessIdUpdate  :Int = 0
    var titleTypeIdUpdate :Int = 0
    var gendertypeIdUpdate :Int = 0
    
    var updateDict = [String : Any]()
    var hideUpdateBtn = Bool()
    var hideNextBtn = Bool()
    
    var selectedBusinessStr = ""
    var selectedProvinceStr = ""
    var selectedGenderStr   = ""
    var selectedDistrictStr = ""
    var selectedMandalStr   = ""
    var selectedVillageStr  = ""
    var selectedPostalCode  = ""
    var selectedtitleTypeStr  = ""
    var selectedDOBStr      = ""
    
    var dddd      = ""
    
    var formatter = DateFormatter()
    
    var dateOfBirth = ""
    
    var agentMobileNo:String = ""
    
    @IBOutlet weak var headerImgHeight: NSLayoutConstraint!
    
    @IBOutlet weak var headerImgVW: UIImageView!
    
    let locationManager = CLLocationManager()
    
    var serviceController = ServiceController()
    
    @IBOutlet weak var newRegTableview: UITableView!
    
    var userCurrentLatitude = ""
    var userCurrentLongitude = ""
    var lanLatStr = ""
    var userCurrentaddressDict = NSDictionary()

    let newRegPicker = UIPickerView()
    var toolBar = UIToolbar()
    var pickerData : Array<String> = Array()
    
    let datePicker = UIDatePicker()
    
    var businessCategoryAry = Array<String>()
    var provinceNamesAry = Array<String>()
   
    var districtsAry  = Array<String>()
    var mandalsAry    = Array<String>()
    var villagesAry   = Array<String>()
    var postalCodeAry = Array<String>()
    var genderArray   = Array<String>()
    var titleArray    = Array<String>()
    
    var titletypeIdAry = Array<String>()
    
    var businessIDAry   = [ParametersAPIModel]()
    var genderTypeIDAry = [ParametersAPIModel]()
    var provinceIDArray = [ParametersAPIModel]()
    var districtIDArray = [ParametersAPIModel]()
    var mandalIDArray   = [ParametersAPIModel]()
    var villageIDArray  = [ParametersAPIModel]()
    
    var activeTextField = UITextField()
    var activeLabel = UILabel()
    
    var userRegistrationData : Dictionary = Dictionary<String,Any>()
    
    var fromBack : Bool = false
    var eyeiconClick : Bool!
    
    @IBOutlet weak var personalBtn: UIButton!
    
    @IBOutlet weak var bankBtn: UIButton!
    
    @IBOutlet weak var idProofsBtn: UIButton!
    
    @IBOutlet weak var documentsBtn: UIButton!
    
    var placeholdersAry  = Array<String>()

    var placeholdersAry2  = Array<String>()
    var userLocationCoordinate : CLLocationCoordinate2D?
    
    var userID : String = ""
    var agentUniqueID : String = ""
    
    var passwordIndexPath : Bool = true
    
    let mapTableViewCell = MapTableViewCell()
    
    var isResponseFromServer = false
    var isWaitingForResponse = false
    
    var response : String = ""
    
    var refresher:UIRefreshControl!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        hideUpdateBtn = true
       // hideNextBtn   = true
        
        navigationItem.leftBarButtonItems = []
        navigationItem.hidesBackButton = true
        for subview in (self.navigationController?.navigationBar.subviews)! {
            
                subview.isHidden = true
        }
        
        let defaults = UserDefaults.standard
        
        if let userid = defaults.string(forKey: AId) {
            
            userID = userid
            
            print("defaults savedString: \(userID)")
        }
        
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        

        
        newRegPicker.delegate = self
        newRegPicker.dataSource = self

        newRegTableview.register(UINib.init(nibName: "NewRegTableViewCell", bundle: nil),
                                          forCellReuseIdentifier: "NewRegTableViewCell")
        
        newRegTableview.register(UINib.init(nibName: "MapTableViewCell", bundle: nil),
                                 forCellReuseIdentifier: "MapTableViewCell")
        
        forIpodAndIphone()
        
        
        self.refresher = UIRefreshControl()
        
        self.refresher.tintColor = #colorLiteral(red: 0.5019607843, green: 0, blue: 0, alpha: 0.9251123716)
         self.refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
        self.newRegTableview.addSubview(self.refresher)
        

    }
    
    func forIpodAndIphone(){
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
            
            
            self.headerImgVW.image =  UIImage(named: "1536X250.jpg")
            self.headerImgHeight.constant = 130
            
        }
            
        else {
            
            self.headerImgVW.image =  UIImage(named: "384X100.jpg")
            self.headerImgHeight.constant = 80
            
        }
        
    }
    
    
    func loadData() {
        //code to execute during refresher
               //Call this to stop refresher
        
        getPersonalInfoService()
    }
    
    func stopRefresher() {
        if self.refresher.isRefreshing
        {
            self.refresher.endRefreshing()
        }
    }
    
  
    func setupRegistrationData(){
        
       
//        userRegistrationData.updateValue("", forKey: "AgentBusinessCategoryId")
//        userRegistrationData.updateValue("", forKey: "AgentRequestId")
//        userRegistrationData.updateValue("", forKey: "Id")
//        userRegistrationData.updateValue("", forKey: "AspNetUserId")
//        userRegistrationData.updateValue("", forKey: "genderTypeId")
//        userRegistrationData.updateValue("", forKey: "FirstName")
//        userRegistrationData.updateValue("", forKey: "MiddleName")
//        userRegistrationData.updateValue("", forKey: "LastName")
//        userRegistrationData.updateValue("", forKey: "Phone")
//        userRegistrationData.updateValue("", forKey: "Email")
//        userRegistrationData.updateValue("", forKey: "GenderTypeId")
//        userRegistrationData.updateValue("", forKey: "DOB")
//        userRegistrationData.updateValue("", forKey: "Address1")
//        userRegistrationData.updateValue("", forKey: "Address2")
//        userRegistrationData.updateValue("", forKey: "Landmark")
//        userRegistrationData.updateValue("", forKey: "VillageId")
//        userRegistrationData.updateValue("", forKey: "ParentAspNetUserId")
//        userRegistrationData.updateValue("", forKey: "IsActive")
//        userRegistrationData.updateValue("", forKey: "CreatedBy")
//        userRegistrationData.updateValue("", forKey: "Created")
//        userRegistrationData.updateValue("", forKey: "ModifiedBy")
//        userRegistrationData.updateValue("", forKey: "Modified")
        
    
    }


    
    override func viewWillAppear(_ animated: Bool) {
        
      //  self.response = "nil"
        eyeiconClick = true
        
        
        newRegTableview.setContentOffset(CGPoint.zero, animated: true)
        
   
        
      self.placeholdersAry =   ["TitleType".localize(value: "Title Type"),"FirstName".localize(value: "First Name"),"MiddleName".localize(value: "Middle Name"),"LastName".localize(value: "Last Name"),"BusinessCategory".localize(value: "Business Category"),"MobileNumber".localize(value: "Mobile Number"),"Password".localize(value: "Password"),"Gender".localize(value: "Gender"),"EmailId".localize(value: "Email Id"),"Dateofbirth".localize(value: "D.O.B"),"Address1".localize(value: "Address 1"),"Address2".localize(value: "Address 2"),"LandMark".localize(value: "LandMark"),"ProvinanceName".localize(value: "Provinance Name"),"DistrictName".localize(value: "District Name"),"MandalName".localize(value: "Mandal Name"),"VillageName".localize(value: "Village Name"),"PostalCode".localize(value: "Postal Code"),""]
        
      self.placeholdersAry2 =   ["TitleType".localize(value: "Title Type"),"FirstName".localize(value: "First Name"),"MiddleName".localize(value: "Middle Name"),"LastName".localize(value: "Last Name"),"BusinessCategory".localize(value: "Business Category"),"MobileNumber".localize(value: "Mobile Number"),"Gender".localize(value: "Gender"),"EmailId".localize(value: "Email Id"),"Dateofbirth".localize(value: "D.O.B"),"Address1".localize(value: "Address 1"),"Address2".localize(value: "Address 2"),"LandMark".localize(value: "LandMark"),"ProvinanceName".localize(value: "Provinance Name"),"DistrictName".localize(value: "District Name"),"MandalName".localize(value: "Mandal Name"),"VillageName".localize(value: "Village Name"),"PostalCode".localize(value: "Postal Code"),""]
        
        navigationItem.leftBarButtonItems = []
        navigationItem.hidesBackButton = true
        
        for subview in (self.navigationController?.navigationBar.subviews)! {
            
            subview.isHidden = true
        }
        
        if hideUpdateBtn == false{
            
        self.bankBtn.isUserInteractionEnabled = false
        
        }
        
        if fromBack == false {
            // isWaitingForResponse = true
             getPersonalInfoService()
            
        }
         
        
       else if fromBack == true {
            // isWaitingForResponse = true
            getPersonalInfoService()
            
            self.personalBtn.isUserInteractionEnabled = false
            self.bankBtn.isUserInteractionEnabled = false 
            self.idProofsBtn.isUserInteractionEnabled = true
            self.documentsBtn.isUserInteractionEnabled = true
            
            
//            if selectedProvinceStr != ""{
//                
//                if (provinceIDArray.count > 0){
//                    if let value = Int(provinceIDArray[0].id){
//                        
//                        provinceID = value
//                    }
//                }
//            
//            getDistrictsAPICall()
//            
//            }
//            
//            if selectedProvinceStr != ""{
//                
//                getDistrictsAPICall()
//                
//            }
//            
//            if selectedDistrictStr != ""{
//                
//                getMandalsAPICall()
//                
//            }
//            
//            if selectedMandalStr != ""{
//                
//                getVillagesAPICall()
//                
//            }
            
            
        }
        
        
        
    }
    
//MARK: - Api call for get Personal Information
    
    func getPersonalInfoService(){
        
        if(appDelegate.checkInternetConnectivity()){
            
            
            
            if agentMobileNo != ""{
                
                passwordIndexPath = false
                
                let strUrl = ADDAGENTPERSONALINFO_API + agentMobileNo

                
                serviceController.requestGETURL(self, strURL:strUrl, success:{(result) in
                    DispatchQueue.main.async()
                        {
                             
                            let respVO : GetPersonalInfoVo = Mapper().map(JSONObject: result)!
                            
                            self.isWaitingForResponse = false
                            
                            let isActive = respVO.IsSuccess
                            
                            if respVO.Result == nil {
                                
                                self.response = "nil"
                                
                                self.bankBtn.isUserInteractionEnabled = false
                                
                                self.newRegTableview.reloadData()
                                
                                let indexPath : IndexPath = IndexPath(row: 18, section: 0)
                                
//                                   self.newRegTableview.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: false)
                                
                                if let mapTableViewCell : MapTableViewCell = self.newRegTableview.cellForRow(at: indexPath) as? MapTableViewCell {
                                    
                                    mapTableViewCell.updateBtn.isHidden = true
                                    self.hideUpdateBtn = false
                                    
                                    mapTableViewCell.nextClicked.isHidden = false
                                    
                                    //  self.hideNextBtn = true
                                    
                                }
                                 
                                self.gettitleTypeAPICall()
                                
                                self.getProvinceNamesAPICall()
                                self.getDistrictsAPICall()
                                self.getMandalsAPICall()
                                self.getVillagesAPICall()
                            }
                            else {
                                
                                self.isResponseFromServer = true
                                self.newRegTableview.reloadData()
                                self.bankBtn.isUserInteractionEnabled = true
                                
                                
                                
                                if(isActive == true){
                                    
                                    self.fromBack = true
                                    
                                    //  self.bankBtn.isUserInteractionEnabled = true
                                    
                                    
                                    
                                    let indexPath : IndexPath = IndexPath(row: 17, section: 0)
                                    
//                                    self.newRegTableview.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: false)
                                    
                                    if let mapTableViewCell : MapTableViewCell = self.newRegTableview.cellForRow(at: indexPath) as? MapTableViewCell {
                                        
                                        mapTableViewCell.updateBtn.isHidden = false
                                        self.hideUpdateBtn = false
                                        
                                        mapTableViewCell.nextClicked.isHidden = true
                                        
                                      //  self.hideNextBtn = true
                                        
                                    }
                                    
                                    
                                    
                                    
                                    let IDInfo = respVO.Result
                                    
                                    let agentIdddd = IDInfo?.AspNetUserId
                                    
                                    
                                    
                                    
                                    UserDefaults.standard.set(agentIdddd, forKey: "AspNetUserId")
                                    UserDefaults.standard.synchronize()
                                    
                                    self.selectedtitleTypeStr = (IDInfo?.TitleTypeName)!
                                    self.fName = (IDInfo?.FirstName)!
                                    
                                    if (IDInfo?.MiddleName) != nil {
                                        
                                        self.mName = (IDInfo?.MiddleName)!
                                    }
                                    
                                    if (IDInfo?.LastName) != nil {
                                        
                                        self.lName = (IDInfo?.LastName)!
                                    }
                                    
                                    self.selectedBusinessStr = (IDInfo?.BusinessCategoryName)!
                                    self.userName            = (IDInfo?.UserName)!
                                    
                                    self.selectedGenderStr   = (IDInfo?.GenderType)!
                                    self.phoneNo             = (IDInfo?.Phone)!
                                    self.eMail               = (IDInfo?.Email)!
                                    
                                    self.agentMobileNo = self.phoneNo
                                    
                                    UserDefaults.standard.set(self.phoneNo, forKey: "kMobileNumber")
                            
                                    UserDefaults.standard.synchronize()
                                    
                                    let fff = (IDInfo?.DOB)!
                                    
                                    let stringB = self.formattedDateFromString(dateString: fff, withFormat: "MMM dd, yyyy")
                                    
                                    if stringB != nil {
                                        
                                        self.selectedDOBStr = stringB!
                                        
                                    }
                                    
                                    self.address1Str         = (IDInfo?.Address1)!
                                    self.address2Str         = (IDInfo?.Address2)!
                                    self.landMarkStr         = (IDInfo?.Landmark)!
                                    self.selectedProvinceStr = (IDInfo?.ProvinceName)!
                                    self.selectedDistrictStr = (IDInfo?.DistrictName)!
                                    
                                    self.selectedMandalStr   = (IDInfo?.MandalName)!
                                    self.selectedVillageStr  = (IDInfo?.VillageName)!
                                    self.selectedPostalCode  = String(describing: (IDInfo?.PostCode)!)
                                    self.aspNetUserId        = (IDInfo?.AspNetUserId)!
                                    self.agentReqIdUpdate    = (IDInfo?.AgentRequestId)!
                                    self.createdById         = (IDInfo?.CreatedBy)!
                                    self.isActiveUpdate      = (IDInfo?.IsActive)!
                                    self.idUpdate            = (IDInfo?.Id)!
                                    
                                    self.provinceID          = (IDInfo?.ProvinceId)!
                                    self.districtID          = (IDInfo?.DistrictId)!
                                    self.mandalID          = (IDInfo?.MandalId)!
                                    self.villageID           = (IDInfo?.VillageId)!
                                    self.businessID          = (IDInfo?.BusinessCategoryTypeId)!
                                    self.titleTypeID         = (IDInfo?.TitleTypeId)!
                                    self.genderTypeID        = (IDInfo?.GenderTypeId)!
                                    
                                    
                                    if (IDInfo?.ParentAspNetUserId != nil) && (IDInfo?.EducationTypeId != nil) && (IDInfo?.Id != nil) {
                                        
                                        self.parentNetUSerId = (IDInfo?.ParentAspNetUserId)!
                                        self.educationIdUpdate = (IDInfo?.EducationTypeId)!
                                        self.idUpdate = (IDInfo?.Id)!
                                        
                                    }
                                    
                                    self.newRegTableview.reloadData()
                                    
                                    self.titleArray.removeAll()
                                     
                                    self.gettitleTypeAPICall()
                                    
                                    self.getProvinceNamesAPICall()
                                    self.getDistrictsAPICall()
                                    self.getMandalsAPICall()
                                    self.getVillagesAPICall()
                                    
                                    
                                } else if(isActive == false) {
                                    
                                    let failMsg = respVO.EndUserMessage
                                    
                                    self.gettitleTypeAPICall()
                                     
                                    Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(), messege: failMsg!, clickAction: {
                                        
                                        
                                    })
                                    
                                }
                            }
                    }
                    
                },
                failure:  {(error) in
                     
                    if error == "unAuthorized" {
                        
                        self.serviceController.refreshTokenForLogin(self, successHandler: { (json) in
                            
                            self.getPersonalInfoService()
                            
                            
                        }, failureHandler: { (failureMassage) in
                            
                            Utilities.sharedInstance.goToLoginScreen()
                            
                        })
                        
                    }
                                                    
                })
                
            }
            else {
                
                self.gettitleTypeAPICall()
                self.getProvinceNamesAPICall()
                self.getDistrictsAPICall()
                self.getMandalsAPICall()
                self.getVillagesAPICall()
                
                
                
                
             //   self.hideUpdateBtn = true
              //  mapTableViewCell.nextClicked.isHidden = false
            }
            
            
            
            
            
        }
        else {
            
            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(), messege: "app.Pleasecheckyourinternetconnection!".localize(), clickAction: {
                
                 self.stopRefresher()

            })
            
        }
        
        
       
    }

//MARK: - Date Formarter 
    
    func formattedDateFromString(dateString: String, withFormat format: String) -> String? {
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        if let date = inputFormatter.date(from: dateString) {
            
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format
            
            return outputFormatter.string(from: date)
        }
        
        return nil
    }
    
//MARK: - Api call for get title Types
    
    func gettitleTypeAPICall(){
    
    let classTypeID = "4"
    
    APIModel().getRequest(self, withUrl: TITLETYPE_API + classTypeID, successBlock: { (json) in
        
        if (json.count > 0){
             
            self.getBusinessCategoryAPICall()
        
        let titleAPIModelArray = ParsingModelClass.sharedInstance.getTitleTypeAPIModelParsing(object: json as AnyObject)
            
            if titleAPIModelArray.count > 0{
                
              self.titleArray.removeAll()
              self.titletypeIdAry.removeAll()
                
            for titleType in titleAPIModelArray{
                
                self.titleArray.append(titleType.descriptions)
                self.titletypeIdAry.append(titleType.id)
               
           
            }
            
            }
        
        
        }
        
         
  
    }) { (failureMessage) in
        
        self.stopRefresher()
//        print("getTitle Details Failed")
//        Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(),
//            messege: failureMessage , clickAction: {
//                                                            
//        })
        
        if failureMessage == "unAuthorized" {
            
            self.serviceController.refreshTokenForLogin(self, successHandler: { (json) in
                
                self.gettitleTypeAPICall()
                
                
            }, failureHandler: { (failureMassage) in
                
                Utilities.sharedInstance.goToLoginScreen()
                
            })
            
        }

        }
    
    }
    
    func getGenderAPICall(){
        
        let classTypeID = "5"
        
        APIModel().getRequest(self, withUrl: GENDER_API + classTypeID, successBlock: { (json) in
            
            if (json.count > 0){
                 
                self.getProvinceNamesAPICall()
                
                let genderAPIModelArray = ParsingModelClass.sharedInstance.getGenderTypeAPIModelParsing(object: json as AnyObject)
                
                self.genderTypeIDAry.removeAll()
                self.genderArray.removeAll()
                
                if genderAPIModelArray.count > 0{
                    
                    
                    self.genderTypeIDAry = genderAPIModelArray
                    
                    for genderType in genderAPIModelArray{
                        
                        self.genderArray.append(genderType.descriptions)
                        
                        
                    }
                    
                }
                
                
            }
            
             
            
        }) { (failureMessage) in
            self.stopRefresher()
//            print("getGender Details Failed")
//            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "Warning",
//                                                             messege: failureMessage , clickAction: {
//                                                                
//            })
            
            if failureMessage == "unAuthorized" {
                
                self.serviceController.refreshTokenForLogin(self, successHandler: { (json) in
                    
                    self.getGenderAPICall()
                    
                    
                }, failureHandler: { (failureMassage) in
                    
                    Utilities.sharedInstance.goToLoginScreen()
                    
                })
                
            }
        }
        
        
    }
 
    
    func getBusinessCategoryAPICall(){
    
    let classTypeID = "3"
        
    APIModel().getRequest(self, withUrl: BUSINESSCATEGORY_API + classTypeID, successBlock: { (json) in
        
        if(json.count > 0){
             
            self.getGenderAPICall()
            
            let businessCategoryAPIModelArray = ParsingModelClass.sharedInstance.getBankNamesAPIModelParsing(object: json as AnyObject?)
            
            print(businessCategoryAPIModelArray.count)
            
            self.businessIDAry.removeAll()
            self.businessCategoryAry.removeAll()
            
            if(businessCategoryAPIModelArray.count > 0){
                
                self.businessIDAry = businessCategoryAPIModelArray
                
                for businessCategory in businessCategoryAPIModelArray{
                    
                    self.businessCategoryAry.append(businessCategory.descriptions)
                 
                    
                    
                }
                
            }
   
            else{
                print("No items")
            }
            
            
        }
        
         
  
    }) { (failureMessage) in
        
        self.stopRefresher()
        
        print("json Failed")
        
        if failureMessage == "unAuthorized" {
            
            self.serviceController.refreshTokenForLogin(self, successHandler: { (json) in
                
                self.getBusinessCategoryAPICall()
                
                
            }, failureHandler: { (failureMassage) in
                
                Utilities.sharedInstance.goToLoginScreen()
                
            })
            
        }
        
        
        }
        
        
        
    }
    
    
    
    func getProvinceNamesAPICall(){

        
        APIModel().getRequest(self, withUrl: PROVINCE_API, successBlock: { (json) in
            
            if (json.count > 0){
             
             let provinceNameModelArray = ParsingModelClass.sharedInstance.getProvinceNameAPIModelParsing(object: json as AnyObject?)
                
                self.provinceIDArray.removeAll()
                self.provinceNamesAry.removeAll()
                
                if(provinceNameModelArray.count > 0){
                    
                self.provinceIDArray = provinceNameModelArray
                
                for provinceName in provinceNameModelArray{
                
                self.provinceNamesAry.append(provinceName.name)
                    
                
                    }
                }
 
            }
            else{
                print("No items")
            }
            
            self.stopRefresher()
            
        }) { (failureMessage) in
            
            self.stopRefresher()
//            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(), messege: failureMessage, clickAction: {
//                 
//                
//            })
            
            if failureMessage == "unAuthorized" {
                
                self.serviceController.refreshTokenForLogin(self, successHandler: { (json) in
                    
                    self.getProvinceNamesAPICall()
                    
                    
                }, failureHandler: { (failureMassage) in
                    
                    Utilities.sharedInstance.goToLoginScreen()
                    
                })
                
            }

        }
        
    
    }
    
    func getDistrictsAPICall(){
    

        let classTypeID = String(provinceID)
        
        let strUrl = DISTRICTS_API + "" + classTypeID
        
        print("strUrl:\(strUrl)")
        
        
        APIModel().getRequest(self, withUrl: strUrl, successBlock: { (json) in
            
            if (json.count > 0){
             
            let districtsNamesModelArray = ParsingModelClass.sharedInstance.getDistrictsAPIModelParsing(object: json as AnyObject?)
                
                self.districtIDArray.removeAll()
                self.districtsAry.removeAll()
                
                if (districtsNamesModelArray.count > 0){
                    
                    self.districtIDArray = districtsNamesModelArray
                
                    for districtName in districtsNamesModelArray{
                    
                    self.districtsAry.append(districtName.name)
                    
                    }
                
                
                
                
                }
            
            }
            
             
        }) { (failureMessage) in
          
            self.stopRefresher()
            
            if failureMessage == "unAuthorized" {
                
                self.serviceController.refreshTokenForLogin(self, successHandler: { (json) in
                    
                    self.getDistrictsAPICall()
                    
                    
                }, failureHandler: { (failureMassage) in
                    
                    Utilities.sharedInstance.goToLoginScreen()
                    
                })
                
            }

            
        }
    
    }
    
    
    func getMandalsAPICall(){
    
     let classTypeID = String(districtID)
        
        let strUrl = MANDALS_API + "" + classTypeID
        
        print("strUrl:\(strUrl)")
        
        APIModel().getRequest(self, withUrl: strUrl, successBlock: { (
            json) in
            
            if (json.count > 0){
               
              let mandalsAPIModelArray = ParsingModelClass.sharedInstance.getMandalsAPIModelParsing(object: json as AnyObject?)
                
                self.mandalIDArray.removeAll()
                self.mandalsAry.removeAll()
                
                if (mandalsAPIModelArray.count > 0){
                
                self.mandalIDArray = mandalsAPIModelArray
                    
                    for mandal in mandalsAPIModelArray{
                    
                    self.mandalsAry.append(mandal.name)
                    
                    }
                
                
                }
            
            }
             
            
        }) { (failureMessage) in
            
            self.stopRefresher()
            
            if failureMessage == "unAuthorized" {
                
                self.serviceController.refreshTokenForLogin(self, successHandler: { (json) in
                    
                    self.getMandalsAPICall()
                    
                    
                }, failureHandler: { (failureMassage) in
                    
                    Utilities.sharedInstance.goToLoginScreen()
                    
                })
                
            }
            
            
        }
    
    
    
    }
    
    
    func getVillagesAPICall(){
    
        
        let classTypeID = String(mandalID)
        
        let strUrl = VILLAGES_API + "" + classTypeID
        
        print("strUrl:\(strUrl)")
        
        APIModel().getRequest(self, withUrl: strUrl, successBlock: { (json) in
            
            if (json.count > 0){
             
                let villagesAPIModelArray = ParsingModelClass.sharedInstance.getVillagesAPIModelParsing(object: json as AnyObject?)
                
                self.villageIDArray.removeAll()
                self.villagesAry.removeAll()
                 self.postalCodeAry.removeAll()
                
                if (villagesAPIModelArray.count > 0){
                    
                    self.villageIDArray = villagesAPIModelArray
                
                    for village in villagesAPIModelArray{
                    
                    self.villagesAry.append(village.name)
                    self.postalCodeAry.append(village.postCode)
           
                    }
                }
            }
     
             
            
        }) { (failureMessage) in
            
            self.stopRefresher()
            
            if failureMessage == "unAuthorized" {
                
                self.serviceController.refreshTokenForLogin(self, successHandler: { (json) in
                    
                    self.getVillagesAPICall()
                    
                    
                }, failureHandler: { (failureMassage) in
                    
                    Utilities.sharedInstance.goToLoginScreen()
                    
                })
                
            }
            
            
        }
    
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//MARK: - UITextfield delegate methods
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        //  datePicker.endEditing(true)
          activeTextField = textField
        self.datePicker.endEditing(true)
        
        if self.isResponseFromServer == true{
        
            if textField.tag == 0{
                
                
                textField.clearButtonMode = .never
                textField.inputView = newRegPicker
                pickerData = titleArray
                self.pickUp(activeTextField)
                newRegPicker.reloadAllComponents()
                newRegPicker.selectRow(0, inComponent: 0, animated: false)
                
            }
                
            else if textField.tag == 1 {
                
                textField.inputView = nil
                textField.keyboardType = .default
            }
                
            else if textField.tag == 2 {
                
                textField.inputView = nil
                textField.keyboardType = .default
            }
                
            else if textField.tag == 3 {
                
                textField.inputView = nil
                textField.keyboardType = .default
            }
                
            else if textField.tag == 4{
                
                textField.clearButtonMode = .never
                textField.inputView = newRegPicker
                pickerData = businessCategoryAry
                self.pickUp(activeTextField)
                newRegPicker.reloadAllComponents()
                newRegPicker.selectRow(0, inComponent: 0, animated: false)
                
            }
                
                //        else if textField.tag == 5{
                //
                //            textField.inputView = nil
                //            textField.keyboardType = .default
                //
                //        }
                
                
            else if textField.tag == 5{
                textField.inputView = nil
                textField.keyboardType = .phonePad
                
            }
                

                
            else if textField.tag == 6{
                textField.clearButtonMode = .never
                textField.inputView = newRegPicker
                
                pickerData = genderArray
                self.pickUp(activeTextField)
                newRegPicker.reloadAllComponents()
                newRegPicker.selectRow(0, inComponent: 0, animated: false)
                
            }
                
                
            else if textField.tag == 7{
                textField.inputView = nil
                textField.keyboardType = .emailAddress
                
            }
                
            else if textField.tag == 8{
                
                textField.clearButtonMode = .never
                textField.inputView = datePicker
                
               // let todayDate = NSDate()
                self.datePicker.maximumDate = todayDate as Date
                datePicker.datePickerMode = .date
                let toolBar = UIToolbar()
                toolBar.tintColor = #colorLiteral(red: 0.5021751523, green: 0.01639934443, blue: 0, alpha: 1)
                
                toolBar.sizeToFit()
                
                let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(dateDoneClicked))
                
                let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
                
                let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(dateCancelClicked))
                
                toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
                
                textField.inputAccessoryView = toolBar
                
            }
                
            else if textField.tag == 9{
                textField.inputView = nil
                textField.keyboardType = .default
                
            }
            else if textField.tag == 10{
                textField.inputView = nil
                textField.keyboardType = .default
                
                
            }
            else if textField.tag == 11{
                textField.inputView = nil
                textField.keyboardType = .default
                
            }
                
            else if textField.tag == 12 {
                
                textField.clearButtonMode = .never
                textField.inputView = newRegPicker
                pickerData = provinceNamesAry
                self.pickUp(activeTextField)
                newRegPicker.reloadAllComponents()
                newRegPicker.selectRow(0, inComponent: 0, animated: false)
                
            }
                
            else if textField.tag == 13 {
                
                textField.clearButtonMode = .never
                textField.inputView = newRegPicker
                pickerData = districtsAry
                self.pickUp(activeTextField)
                newRegPicker.reloadAllComponents()
                newRegPicker.selectRow(0, inComponent: 0, animated: false)
                
            }
                
            else if textField.tag == 14 {
                
                textField.clearButtonMode = .never
                textField.inputView = newRegPicker
                pickerData = mandalsAry
                self.pickUp(activeTextField)
                newRegPicker.reloadAllComponents()
                newRegPicker.selectRow(0, inComponent: 0, animated: false)
                
            }
                
            else if textField.tag == 15 {
                
                textField.clearButtonMode = .never
                textField.inputView = newRegPicker
                pickerData = villagesAry
                self.pickUp(activeTextField)
                newRegPicker.reloadAllComponents()
                newRegPicker.selectRow(0, inComponent: 0, animated: false)
                
            }
                
            else if textField.tag == 16{
                
                textField.clearButtonMode = .never
                //  textField.inputView = newRegPicker
                pickerData = postalCodeAry
                // self.pickUp(activeTextField)
               // textField.isUserInteractionEnabled = false
                newRegPicker.reloadAllComponents()
                newRegPicker.selectRow(0, inComponent: 0, animated: false)
            }
                
            else if textField.tag == 17{
                textField.inputView = nil
                textField.keyboardType = .numberPad
                
            }
            
        }
        
        else {
        if textField.tag == 0{
            
            textField.clearButtonMode = .never
            textField.inputView = newRegPicker
            pickerData = titleArray
            self.pickUp(activeTextField)
            newRegPicker.reloadAllComponents()
            newRegPicker.selectRow(0, inComponent: 0, animated: false)
            
        }
        
        else if textField.tag == 1 {
          
           textField.inputView = nil
           textField.keyboardType = .default
        }
            
        else if textField.tag == 2 {
           
            textField.inputView = nil
            textField.keyboardType = .default
        }
            
        else if textField.tag == 3 {
            
            textField.inputView = nil
            textField.keyboardType = .default
        }
            
        else if textField.tag == 4{
            
            textField.clearButtonMode = .never
            textField.inputView = newRegPicker
            pickerData = businessCategoryAry
            self.pickUp(activeTextField)
            newRegPicker.reloadAllComponents()
            newRegPicker.selectRow(0, inComponent: 0, animated: false)
            
        }
            
//        else if textField.tag == 5{
//            
//            textField.inputView = nil
//            textField.keyboardType = .default
//            
//        }
            

        else if textField.tag == 5{
            textField.inputView = nil
            textField.keyboardType = .phonePad
            
        }
        
        else if textField.tag == 6{
            textField.inputView = nil
            textField.keyboardType = .default
           
            
        }
            
        else if textField.tag == 7{
            textField.clearButtonMode = .never
            textField.inputView = newRegPicker
            
            pickerData = genderArray 
            self.pickUp(activeTextField)
            newRegPicker.reloadAllComponents()
            newRegPicker.selectRow(0, inComponent: 0, animated: false)
            
        }
            
            
        else if textField.tag == 8{
            textField.inputView = nil
            textField.keyboardType = .emailAddress
            
        }
            
        else if textField.tag == 9{
            
            textField.clearButtonMode = .never
            textField.inputView = datePicker
            
            
            self.datePicker.maximumDate = todayDate as Date
            datePicker.datePickerMode = .date
            let toolBar = UIToolbar()
            toolBar.barStyle = .default
            toolBar.isTranslucent = true
            toolBar.tintColor = #colorLiteral(red: 0.5021751523, green: 0.01639934443, blue: 0, alpha: 1)
            toolBar.sizeToFit()
            
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(dateDoneClicked))

            let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            
            let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(dateCancelClicked))
            
            toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
            
            textField.inputAccessoryView = toolBar
            
        }
            
        else if textField.tag == 10{
            textField.inputView = nil
            textField.keyboardType = .default
            
        }
        else if textField.tag == 11{
            textField.inputView = nil
            textField.keyboardType = .default
            
            
        }
        else if textField.tag == 12{
            textField.inputView = nil
            textField.keyboardType = .default
            
        }
     
            else if textField.tag == 13 {
            
            textField.clearButtonMode = .never
            textField.inputView = newRegPicker
            pickerData = provinceNamesAry
            self.pickUp(activeTextField)
            newRegPicker.reloadAllComponents()
            newRegPicker.selectRow(0, inComponent: 0, animated: false)
            
            }
        
           else if textField.tag == 14 {
        
                textField.clearButtonMode = .never
                textField.inputView = newRegPicker
                pickerData = districtsAry
                self.pickUp(activeTextField)
                newRegPicker.reloadAllComponents()
                newRegPicker.selectRow(0, inComponent: 0, animated: false)
            
        }
        
           else if textField.tag == 15 {
            
            textField.clearButtonMode = .never
            textField.inputView = newRegPicker
            pickerData = mandalsAry
            self.pickUp(activeTextField)
            newRegPicker.reloadAllComponents()
            newRegPicker.selectRow(0, inComponent: 0, animated: false)
            
        }
        
           else if textField.tag == 16 {
            
            textField.clearButtonMode = .never
            textField.inputView = newRegPicker
            pickerData = villagesAry
            self.pickUp(activeTextField)
            newRegPicker.reloadAllComponents()
            newRegPicker.selectRow(0, inComponent: 0, animated: false)
            
        }
        
        else if textField.tag == 17{
            
            textField.clearButtonMode = .never
          //  textField.inputView = newRegPicker
            pickerData = postalCodeAry
           // self.pickUp(activeTextField)
          //  textField.isUserInteractionEnabled = false
            newRegPicker.reloadAllComponents()
            newRegPicker.selectRow(0, inComponent: 0, animated: false)
        }
        
        else if textField.tag == 18{
            textField.inputView = nil
            textField.keyboardType = .numberPad
            
        }
    }
    
      // newRegPicker.endEditing(true)
    }

    
    func dateDoneClicked(){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        selectedDOBStr = dateFormatter.string(from: datePicker.date)
        
        self.view.endEditing(true)
        self.datePicker.endEditing(true) 
        newRegTableview.reloadData()
        activeTextField.endEditing(true)
        
        resignFirstResponder()
    }
    
    func dateCancelClicked(){
    
        self.view.endEditing(true)
        self.datePicker.endEditing(true)
        
        newRegTableview.reloadData()
        activeTextField.endEditing(true)
        
        resignFirstResponder()
    
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        self.datePicker.endEditing(true)
        
        if !((textField.text?.isEmpty)!){
        
          
        
        }

        
        if let _ : NewRegTableViewCell = textField.superview?.superview as? NewRegTableViewCell {

            if self.isResponseFromServer == true{
                
                if textField.tag == 0{
                    
                    if textField.text == selectedtitleTypeStr{
                        
                        activeTextField.text = selectedtitleTypeStr
                        
                    }
                        
                    else{
                        
                        titleType = textField.text!
                        
                    }
                    
                    
                }
                else if textField.tag == 1{
                    
                    fName = textField.text!
                    
                }
                    
                else if textField.tag == 2{
                    
                    mName = textField.text!
                    
                }
                    
                else if textField.tag == 3{
                    
                    lName = textField.text!
                    
                }
                    
                else if textField.tag == 4 {
                    
                    activeTextField.text = selectedBusinessStr
                    
                }
                    
                    //            else if textField.tag == 5{
                    //
                    //                userName = textField.text!
                    //
                    //            }
                    
                else if textField.tag == 5 {
                    
                    phoneNo = textField.text!
                    
                    
                }

                    
                else if textField.tag == 6 {
                    
                    activeTextField.text = selectedGenderStr
                    
                }
                    
                    
                    
                else if textField.tag == 7 {
                    
                    eMail = textField.text!
                    
                }
                    
                else if textField.tag == 8 {
                    
                    activeTextField.text = selectedDOBStr
                    
                }
                    
                else if textField.tag == 9 {
                    
                    address1Str = textField.text!
                    
                }
                    
                    
                else if textField.tag == 10 {
                    
                    address2Str = textField.text!
                    
                }
                    
                else if textField.tag == 11 {
                    
                    
                    landMarkStr = textField.text!
                    
                    
                }
                    
                else if textField.tag == 12 {
                    
                    activeTextField.text = selectedProvinceStr
                    
                    
                    
                }
                    
                else if textField.tag == 13 {
                    
                    activeTextField.text = selectedDistrictStr
                }
                    
                else if textField.tag == 14 {
                    
                    activeTextField.text = selectedMandalStr
                    
                }
                else if textField.tag == 15 {
                    
                    
                    activeTextField.text = selectedVillageStr
                    
                }
                else if textField.tag == 16 {
                    
                    
                    postalCode = textField.text!
                    activeTextField.text = selectedPostalCode
                    
                }
                newRegPicker.endEditing(true)

            
            }
            
            else {
            
            
            
            if textField.tag == 0{
                
                if textField.text == selectedtitleTypeStr{
            
                activeTextField.text = selectedtitleTypeStr
                    
                }
                
                else{
                    
                    titleType = textField.text!
                
                }
            
                
            }
            else if textField.tag == 1{
            
            fName = textField.text!
            
             }
                
            else if textField.tag == 2{
                
                mName = textField.text!
                
            }
                
            else if textField.tag == 3{
                
                lName = textField.text!
                
            }
            
            else if textField.tag == 4 {
                
               activeTextField.text = selectedBusinessStr

            }
              
//            else if textField.tag == 5{
//                
//                userName = textField.text!
//                
//            }
                
            else if textField.tag == 5 {
                
                phoneNo = textField.text!
                
                
            }
            else if textField.tag == 6{

                password = textField.text!
    
            }
            
            else if textField.tag == 7 {
                
                activeTextField.text = selectedGenderStr

            }
                

                
            else if textField.tag == 8 {
                
                eMail = textField.text!
   
            }
                
            else if textField.tag == 9 {
                
                activeTextField.text = selectedDOBStr
                
            }
                
            else if textField.tag == 10 {
                
                address1Str = textField.text!
     
            }
                
   
            else if textField.tag == 11 {
                
                address2Str = textField.text!
                
            }
                
            else if textField.tag == 12 {

                
             landMarkStr = textField.text!
                                
                                
            }
                
            else if textField.tag == 13 {

               activeTextField.text = selectedProvinceStr
                
              
                
            }
                
            else if textField.tag == 14 {

               activeTextField.text = selectedDistrictStr
            }
                
            else if textField.tag == 15 {

                activeTextField.text = selectedMandalStr
                
            }
            else if textField.tag == 16 {

                
                activeTextField.text = selectedVillageStr
 
            }
            else if textField.tag == 17 {

                
                postalCode = textField.text!
                activeTextField.text = selectedPostalCode
                
            }
            newRegPicker.endEditing(true)
  
        }
    }
    
        
         }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        /// 1. replacementString is NOT empty means we are entering text or pasting text: perform the logic
        /// 2. replacementString is empty means we are deleting text: return true
        
        if textField == activeTextField {
        
            if !string.canBeConverted(to: String.Encoding.ascii){
                return false
            }
            

        }
        if textField.tag == 1{
            
            
        if string.characters.count > 0 {
           
            let currentCharacterCount = textField.text?.characters.count ?? 0
            if (range.length + range.location > currentCharacterCount){
                return false
            }
            let newLength = currentCharacterCount + string.characters.count - range.length
            
            let allowedCharacters = CharacterSet.letters
            
            let space = CharacterSet.init(charactersIn: " ")
            let spaceStr = string.trimmingCharacters(in: space)
            
            let unwantedStr = string.trimmingCharacters(in: allowedCharacters)
            return newLength <= 40 && (unwantedStr.characters.count == 0 || spaceStr.characters.count == 0)
        }
        
        return true
        }
        
      else  if textField.tag == 2{
            if string.characters.count > 0 {
                
                let currentCharacterCount = textField.text?.characters.count ?? 0
                if (range.length + range.location > currentCharacterCount){
                    return false
                }
                let newLength = currentCharacterCount + string.characters.count - range.length
                
                let allowedCharacters = CharacterSet.letters
                
                let space = CharacterSet.init(charactersIn: " ")
                let spaceStr = string.trimmingCharacters(in: space)
                
                let unwantedStr = string.trimmingCharacters(in: allowedCharacters)
                return newLength <= 40 && (unwantedStr.characters.count == 0 || spaceStr.characters.count == 0)
            }
            
            return true
        }
        
      else  if textField.tag == 3{
            if string.characters.count > 0 {
                
                let currentCharacterCount = textField.text?.characters.count ?? 0
                if (range.length + range.location > currentCharacterCount){
                    return false
                }
                let newLength = currentCharacterCount + string.characters.count - range.length
                
                
                let allowedCharacters = CharacterSet.letters
                
                let space = CharacterSet.init(charactersIn: " ")
                let spaceStr = string.trimmingCharacters(in: space)
                
                let unwantedStr = string.trimmingCharacters(in: allowedCharacters)
                return newLength <= 40 && (unwantedStr.characters.count == 0 || spaceStr.characters.count == 0)
            }
            
            return true
        }
        
      else  if textField.tag == 5{
            if string.characters.count > 0 {
                
                let currentCharacterCount = textField.text?.characters.count ?? 0
                if (range.length + range.location > currentCharacterCount){
                    return false
                }
                let newLength = currentCharacterCount + string.characters.count - range.length
                
                let allowedCharacters = CharacterSet.decimalDigits
                
                let unwantedStr = string.trimmingCharacters(in: allowedCharacters)
                
                return newLength <= 10 && unwantedStr.characters.count == 0

            }
 
        }
        
        if(textField.tag == 7  || textField.tag == 8)
        {
            if range.location==0{
            if string.hasPrefix(".")
            {
                return false
            }
            
            
        }
        
        }
        
        if !(textField.tag == 5) {
                if string.characters.count > 0 {
        
                    let currentCharacterCount = textField.text?.characters.count ?? 0
                    if (range.length + range.location > currentCharacterCount){
                        return false
                    }
                    let newLength = currentCharacterCount + string.characters.count - range.length
        
        
                    return newLength <= 40
                }
                    }
        

        return true
    }

    func pickUp(_ textField : UITextField){
        
        textField.inputView = self.newRegPicker
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = #colorLiteral(red: 0.5021751523, green: 0.01639934443, blue: 0, alpha: 1)
        // UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "app.Done".localize(), style: .plain, target: self, action: #selector(NewAgentRegistrationViewController.doneClick))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "app.Cancel".localize(), style: .plain, target: self, action: #selector(NewAgentRegistrationViewController.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        if textField.inputView == newRegPicker{
        textField.inputAccessoryView = toolBar
    }
    }
    
    //MARK:- Button
    func doneClick() {
        

        if pickerData.count > 0 {
            
        
        if self.isResponseFromServer == true{
            switch activeTextField.tag {
     
            case 0:
                selectedtitleTypeStr = pickerData[0]
                if(0 < titletypeIdAry.count){
                    if let value = Int(titletypeIdAry[0]){
                        titleTypeID = value
                    }
                }

                break
                
            case 4:
                selectedBusinessStr  = pickerData[0]
                if(0 < businessIDAry.count){
                    if let value = Int(businessIDAry[0].id){
                        businessID = value
                    }
                }

                break
                
            case 6:
                selectedGenderStr    = pickerData[0]
                if(0 < genderTypeIDAry.count){
                    if let value = Int(genderTypeIDAry[0].id){
                        genderTypeID = value
                    }
                }

                break
                
            case 12:
                selectedProvinceStr  = pickerData[0]
                selectedDistrictStr = ""
                selectedVillageStr = ""
                selectedMandalStr = ""
                selectedPostalCode = ""
                
                if (provinceIDArray.count > 0){
                    if let value = Int(provinceIDArray[0].id){
                        
                        provinceID = value
                    }
                }
                
                getDistrictsAPICall()
                break
                
            case 13:
                selectedDistrictStr  = pickerData[0]
                selectedMandalStr = ""
                selectedVillageStr = ""
                selectedPostalCode = ""
                
                
                if (districtIDArray.count > 0){
                    
                    if let value = Int(districtIDArray[0].id){
                        
                        districtID = value
                    }
                }
                getMandalsAPICall()
                break
                
            case 14:
                selectedMandalStr    = pickerData[0]
                selectedVillageStr = ""
                selectedPostalCode = ""
                
                
                if (self.mandalIDArray.count > 0){
                    
                    if let value = Int(self.mandalIDArray[0].id){
                        mandalID = value
                    }
                }
                
                getVillagesAPICall()
                break
                
            case 15:
                selectedVillageStr   = pickerData[0]
                selectedPostalCode = postalCodeAry[0]
                
                if villageIDArray.count > 0{
                    
                    if let value = Int(self.villageIDArray[0].id){
                        
                        villageID = value
                        
                    }
                }
                break
                
                
            default:
                break
            }
        
        
        }
        
        else {
        
            switch activeTextField.tag {
                
            case 0:
                selectedtitleTypeStr = pickerData[0]
                if(0 < titletypeIdAry.count){
                    if let value = Int(titletypeIdAry[0]){
                        titleTypeID = value
                    }
                }
                break
                
            case 4:
                selectedBusinessStr  = pickerData[0]
                if(0 < businessIDAry.count){
                    if let value = Int(businessIDAry[0].id){
                        businessID = value
                    }
                }
                break
                
            case 7:
                selectedGenderStr    = pickerData[0]
                if(0 < genderTypeIDAry.count){
                    if let value = Int(genderTypeIDAry[0].id){
                        genderTypeID = value
                    }
                }
                break
                
            case 13:
                selectedProvinceStr  = pickerData[0]
                selectedDistrictStr = ""
                selectedVillageStr = ""
                selectedMandalStr = ""
                selectedPostalCode = ""
                if (provinceIDArray.count > 0){
                    if let value = Int(provinceIDArray[0].id){
                        
                        provinceID = value
                    }
                }
                
                getDistrictsAPICall()
                break
                
            case 14:
                selectedDistrictStr  = pickerData[0]
                selectedMandalStr = ""
                selectedVillageStr = ""
                selectedPostalCode = ""
                
                if (districtIDArray.count > 0){
                    
                    if let value = Int(districtIDArray[0].id){
                        
                        districtID = value
                    }
                }
                getMandalsAPICall()
                break
                
            case 15:
                selectedMandalStr    = pickerData[0]
                selectedVillageStr = ""
                selectedPostalCode = ""
                
                if (self.mandalIDArray.count > 0){
                    
                    if let value = Int(self.mandalIDArray[0].id){
                        mandalID = value
                    }
                }
                
                getVillagesAPICall()
                break
                
            case 16:
                selectedVillageStr   = pickerData[0]
                selectedPostalCode = postalCodeAry[0]
                if villageIDArray.count > 0{
                    
                    if let value = Int(self.villageIDArray[0].id){
                        
                        villageID = value
                        
                    }
                }
                
                
            default: break
                
            }
        
        }
        
    }
        
        
        else{
        
        
        
        
        }
    
      //   activeTextField.resignFirstResponder()
         newRegTableview.reloadData()
    }
    
    func cancelClick() {
        
      //  activeTextField.resignFirstResponder()
        newRegTableview.reloadData()

        
    }

//MARK: - Uitableview delegate methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
       
      
        
        return 1
       
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(self.isResponseFromServer == true){
            return 18
        }
            
            
        
        else {
           
            if self.response == "nil"{
                
            return 19
            
            }
            
            else
                
            {
                if (isWaitingForResponse == true){

                return 0
              
            }else{
                
                
                return 19
            }
            
            
            }
            
        }
        
//        if self.hideUpdateBtn == false{
//        
//        return 18
//        }
//        
//        else {
//        
//        return 19
//        }
    }


    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
     // for mapview cell
        
        if self.isResponseFromServer == true{
            
            
                
                if indexPath.row == 17 {
                    
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone) {
                        
                        return 60
                    }
                        
                    else {
                        
                        return 70
                    }
                    
                }
                    
                    // for normal cells
                    
                else {
                    
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone) {

                        
                        return 60
                        
                    }
                        
                    else {
                        

                        
                        return 70
                        
                    }
                    
                    
                    
                }
    
        
        }
        
        else {
        
        if indexPath.row == 18 {
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone) {
            
            return 60
        }
            
            else {
            
            return 70
            }
        
        }
        
    // for normal cells
            
        else {
            
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone) {
        
//            if self.hideUpdateBtn == false{
//                
//                if indexPath.row == 5 || indexPath.row == 6{
//                    
//                    return 5
//                    
//                }
//                
//                else if self.hideNextBtn != true {
//                return 60
//                }
//                
//            }
 
           return 60
            
        }
        
          else {

            
//            if self.hideUpdateBtn == false {
//                
//                if indexPath.row == 5 || indexPath.row == 6{
//                    
//                    return 5
//                    
//                }
//                
//                else if self.hideNextBtn != true{
//                
//                return 70
//                }
//                
//            }
            
               return 70
        
         }
            
          
        
        }
        
       
        
    }
    
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
  
        if self.isResponseFromServer == true{
 
            
            if(indexPath.row != 17){
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewRegTableViewCell") as! NewRegTableViewCell
                
                
                
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone) {
                    
                    cell.detailTFHeight.constant = 55
                    
                }
                    
                else {
                    
                    cell.detailTFHeight.constant = 65
                    
                }
                
                cell.eyeIconBtn.isHidden = true
                cell.detailsTextField.isSecureTextEntry = false
                
                cell.detailsTextField.delegate = self
                
                cell.detailsTextField.tag = indexPath.row
               
             
                
                cell.detailsTextField.placeholder = placeholdersAry2[indexPath.row]
                
                cell.eyeBtn.addTarget(self, action: #selector(eyeBtnClicked), for: .touchUpInside)
                
                if indexPath.row == 16 || indexPath.row == 5{
                    
                    cell.detailsTextField.isUserInteractionEnabled = false
                    
                    
                }
                
                else{
                    
                    cell.detailsTextField.isUserInteractionEnabled = true
                    
                }
                
                
                
                if indexPath.row == 0 {
                    
                    cell.dropDownImg.isHidden = false
                    cell.eyeBtn.isHidden = true
                    if titleType == "" {
                        
                        cell.detailsTextField.text = selectedtitleTypeStr
                    }
                        
                    else {
                        
                        
                        cell.detailsTextField.text = titleType
                    }
                    
                }
                
                else if indexPath.row == 1 {
                    cell.eyeBtn.isHidden = true
                    cell.dropDownImg.isHidden = true
                    cell.detailsTextField.text = fName
                    
                }
                
                else if indexPath.row == 2 {
                    cell.eyeBtn.isHidden = true
                    cell.dropDownImg.isHidden = true
                    cell.detailsTextField.text = mName
                    
                }
                
                else if indexPath.row == 3 {
                    cell.eyeBtn.isHidden = true
                    cell.dropDownImg.isHidden = true
                    cell.detailsTextField.text = lName
                    
                }
                    
                else if indexPath.row == 4 {
                    cell.eyeBtn.isHidden = true
                    cell.dropDownImg.isHidden = false
                    
                    cell.detailsTextField.text = selectedBusinessStr
                    
                }

                else if indexPath.row == 5 {
                 
                  //  cell.detailsTextField.isUserInteractionEnabled = false
                    cell.eyeBtn.isHidden = true
                    cell.dropDownImg.isHidden = true
                    cell.detailsTextField.text = phoneNo
                   // if phoneNo.characters.count > 0 {
                        
                    
                        
                    //}
                }
                    
                    
                else if indexPath.row == 6 {
                    cell.eyeBtn.isHidden = true
                    cell.dropDownImg.isHidden = false
                    cell.detailsTextField.text = selectedGenderStr
                }
                    
                else if indexPath.row == 7 {
                    cell.eyeBtn.isHidden = true
                    cell.dropDownImg.isHidden = true
                    
                    cell.detailsTextField.text = eMail
                }
                    
                else if indexPath.row == 8 {
                    cell.eyeBtn.isHidden = true
                    cell.dropDownImg.isHidden = false
                    
                    cell.detailsTextField.text = selectedDOBStr
                }
                    
                else if indexPath.row == 9{
                    cell.eyeBtn.isHidden = true
                    cell.dropDownImg.isHidden = true
                    cell.detailsTextField.text = address1Str
                    
                }
                    
                else if indexPath.row == 10 {
                    cell.eyeBtn.isHidden = true
                    cell.dropDownImg.isHidden = true
                    cell.detailsTextField.text = address2Str
                    
                }
                    
                else if indexPath.row == 11 {
                    cell.eyeBtn.isHidden = true
                    cell.dropDownImg.isHidden = true
                    cell.detailsTextField.text = landMarkStr
                }
                    
                else if indexPath.row == 12{
                    cell.eyeBtn.isHidden = true
                    cell.dropDownImg.isHidden = false
                    
                    cell.detailsTextField.text = selectedProvinceStr
                    
                    
                }
                else if indexPath.row == 13{
                    cell.eyeBtn.isHidden = true
                    cell.dropDownImg.isHidden = false
                    cell.detailsTextField.text = ""
                    
                    cell.detailsTextField.text = selectedDistrictStr
                    
                }
                    
                else if indexPath.row == 14{
                    cell.eyeBtn.isHidden = true
                    cell.dropDownImg.isHidden = false
                    cell.detailsTextField.text = ""
                    cell.detailsTextField.text = selectedMandalStr
                    
                }
                else if indexPath.row == 15{
                    cell.eyeBtn.isHidden = true
                    cell.dropDownImg.isHidden = false
                    cell.detailsTextField.text = ""
                    cell.detailsTextField.text = selectedVillageStr
                }
                    
                else if indexPath.row == 16{
                    
                    
                    cell.dropDownImg.isHidden = true
                    cell.eyeBtn.isHidden = true
//                    if self.postalCodeAry.count > 0{
//                        
//                        if let pincode = String(self.postalCodeAry[0]){
// 
//                            
//                            if selectedVillageStr.isEmpty{
//                                
//                                cell.detailsTextField.text = ""
//                            }
//                            else {
//                                
//                                cell.detailsTextField.text = String(pincode)
//                                
//                            }
//                        }
//                    }
//                        
//                    else {
//                        
//                        cell.detailsTextField.text = pincode
//                    }
                    cell.detailsTextField.text = selectedPostalCode
//                    if selectedVillageStr.isEmpty{
//                        
//                        cell.detailsTextField.text = ""
//                    }
//                    else {
//                        
//                        cell.detailsTextField.text = String(pincode)
//
//                    }
                }
                    
                    
//                else {
//                    cell.eyeBtn.isHidden = true
//                    //cell.dropDownImg.isHidden = true
//                    cell.detailsTextField.inputView = nil
//                    
//                    
//                }
                
                
                return cell
                
            }
                
                
            else {
                
                let mapCell = tableView.dequeueReusableCell(withIdentifier: "MapTableViewCell") as! MapTableViewCell
                
                mapCell.lanLatTF.delegate = self
                
                mapCell.lanLatTF.isUserInteractionEnabled = false
                mapCell.nextClicked.addTarget(self, action: #selector(nextBtnClicked), for: .touchUpInside)
                mapCell.updateBtn.addTarget(self, action: #selector(updateBtnClicked), for: .touchUpInside)
                mapCell.cancelBtn.addTarget(self, action: #selector(cancelBtnClicked), for: .touchUpInside)
                
                mapCell.currentLocationBtn.addTarget(self, action: #selector(getCurrentLocation), for: .touchUpInside)
                
                mapCell.userMapview.delegate = self
                
                mapCell.userMapview.showsUserLocation = true
                mapCell.nextClicked.isHidden = true
                mapCell.updateBtn.isHidden = false
                
                mapCell.currentLocationBtn.tag = indexPath.row
                
                mapCell.lanLatTF.text = lanLatStr
                mapCell.lanLatTF.tag = indexPath.row
                
                return mapCell
            }
            
            
            
            
        }
        
        else {
            
       //     self.hideUpdateBtn = true
            

            if self.response == "nil"{
            
                if(indexPath.row != 18){
                    
                    
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: "NewRegTableViewCell") as! NewRegTableViewCell
                    
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone) {
                        
                        cell.detailTFHeight.constant = 55
                        
                    }
                        
                    else {
                        
                        cell.detailTFHeight.constant = 65
                        
                    }
                    
                    cell.eyeIconBtn.isHidden = true
                    cell.detailsTextField.delegate = self
                    
                    cell.detailsTextField.tag = indexPath.row
                    
                    cell.detailsTextField.placeholder = placeholdersAry[indexPath.row]
                    
                    cell.eyeBtn.addTarget(self, action: #selector(eyeBtnClicked), for: .touchUpInside)
                    
                    if indexPath.row == 6 {
                        
                        cell.detailsTextField.isSecureTextEntry = true
                        
                        
                        
                        
                    }
                        
                    else{
                        cell.detailsTextField.isSecureTextEntry = false
                        
                        
                    }
                    
                    if indexPath.row == 17  || indexPath.row == 5{
                        
                        cell.detailsTextField.isUserInteractionEnabled = false
                        
                        
                    }
                        
                    else{
                        
                        cell.detailsTextField.isUserInteractionEnabled = true
                        
                    }
                    
                    if indexPath.row == 0 {
                        
                        cell.dropDownImg.isHidden = false
                        cell.eyeBtn.isHidden = true
                        if titleType == "" {
                            
                            cell.detailsTextField.text = selectedtitleTypeStr
                        }
                            
                        else {
                            
                            
                            cell.detailsTextField.text = titleType
                        }
                        
                    }
                    
                    else if indexPath.row == 1 {
                        cell.eyeBtn.isHidden = true
                        cell.dropDownImg.isHidden = true
                        cell.detailsTextField.text = fName
                        
                    }
                    
                    else if indexPath.row == 2 {
                        cell.eyeBtn.isHidden = true
                        cell.dropDownImg.isHidden = true
                        cell.detailsTextField.text = mName
                        
                    }
                    
                    else if indexPath.row == 3 {
                        cell.eyeBtn.isHidden = true
                        cell.dropDownImg.isHidden = true
                        cell.detailsTextField.text = lName
                        
                    }
                        
                    else if indexPath.row == 4 {
                        cell.eyeBtn.isHidden = true
                        cell.dropDownImg.isHidden = false
                        
                        cell.detailsTextField.text = selectedBusinessStr
                        
                    }
                        //            else if indexPath.row == 5 {
                        //                cell.eyeBtn.isHidden = true
                        //                cell.dropDownImg.isHidden = true
                        //                cell.detailsTextField.text = userName
                        //            }
                        
                    else if indexPath.row == 5 {
                        
                        cell.eyeBtn.isHidden = true
                        cell.dropDownImg.isHidden = true
                      //  if phoneNo.characters.count > 0 {
                            
                            cell.detailsTextField.text = phoneNo
                            
                      //  }
                    }
                        
                    else if indexPath.row == 6 {
                        
                        cell.eyeBtn.isHidden = false
                        cell.dropDownImg.isHidden = true
                        cell.detailsTextField.text = password
                        
                    }
                        
                    else if indexPath.row == 7 {
                        cell.eyeBtn.isHidden = true
                        cell.dropDownImg.isHidden = false
                        cell.detailsTextField.text = selectedGenderStr
                    }
                        
                    else if indexPath.row == 8 {
                        cell.eyeBtn.isHidden = true
                        cell.dropDownImg.isHidden = true
                        
                        cell.detailsTextField.text = eMail
                    }
                        
                    else if indexPath.row == 9 {
                        cell.eyeBtn.isHidden = true
                        cell.dropDownImg.isHidden = false
                        
                        cell.detailsTextField.text = selectedDOBStr
                    }
                        
                    else if indexPath.row == 10{
                        cell.eyeBtn.isHidden = true
                        cell.dropDownImg.isHidden = true
                        cell.detailsTextField.text = address1Str
                        
                    }
                        
                    else if indexPath.row == 11 {
                        cell.eyeBtn.isHidden = true
                        cell.dropDownImg.isHidden = true
                        cell.detailsTextField.text = address2Str
                        
                    }
                        
                    else if indexPath.row == 12 {
                        cell.eyeBtn.isHidden = true
                        cell.dropDownImg.isHidden = true
                        cell.detailsTextField.text = landMarkStr
                    }
                        
                    else if indexPath.row == 13{
                        cell.eyeBtn.isHidden = true
                        cell.dropDownImg.isHidden = false
                        
                        cell.detailsTextField.text = selectedProvinceStr
                        
                        
                    }
                    else if indexPath.row == 14{
                        cell.eyeBtn.isHidden = true
                        cell.dropDownImg.isHidden = false
                        
                        cell.detailsTextField.text = selectedDistrictStr
                        
                    }
                        
                    else if indexPath.row == 15{
                        cell.eyeBtn.isHidden = true
                        cell.dropDownImg.isHidden = false
                        
                        cell.detailsTextField.text = selectedMandalStr
                        
                    }
                    else if indexPath.row == 16{
                        cell.eyeBtn.isHidden = true
                        cell.dropDownImg.isHidden = false
                        
                        cell.detailsTextField.text = selectedVillageStr
                    }
                        
                    else if indexPath.row == 17{
                        
                        
                        cell.dropDownImg.isHidden = true
                        cell.eyeBtn.isHidden = true
                        cell.detailsTextField.text = selectedPostalCode
//                        if self.postalCodeAry.count > 0{
//                            
//                            if let pincode = String(self.postalCodeAry[0]){
//                                
//                                
//                                
//                                if selectedVillageStr.isEmpty{
//                                    
//                                    cell.detailsTextField.text = ""
//                                }
//                                else {
//                                    
//                                    cell.detailsTextField.text = String(pincode)
//                                    
//                                }
//                            }
//                        }
//                            
//                        else {
//                            
//                            cell.detailsTextField.text = pincode
//                        }
                        
                    }
                        
                        
//                    else {
//                        
//                        cell.eyeBtn.isHidden = true
//                        //cell.dropDownImg.isHidden = true
//                        cell.detailsTextField.inputView = nil
//    
//                    }
                    
                    return cell
                    
                }
                    
                    
                else {
                    
                    let mapCell = tableView.dequeueReusableCell(withIdentifier: "MapTableViewCell") as! MapTableViewCell
                    
                    mapCell.lanLatTF.delegate = self
                    
                    mapCell.lanLatTF.isUserInteractionEnabled = false
                    mapCell.nextClicked.addTarget(self, action: #selector(nextBtnClicked), for: .touchUpInside)
                    mapCell.updateBtn.addTarget(self, action: #selector(updateBtnClicked), for: .touchUpInside)
                    mapCell.cancelBtn.addTarget(self, action: #selector(cancelBtnClicked), for: .touchUpInside)
                    
                    mapCell.currentLocationBtn.addTarget(self, action: #selector(getCurrentLocation), for: .touchUpInside)
                    
                    mapCell.userMapview.delegate = self
                    
                    mapCell.userMapview.showsUserLocation = true
                    
                    mapCell.currentLocationBtn.tag = indexPath.row
                    
                    mapCell.lanLatTF.text = lanLatStr
                    mapCell.lanLatTF.tag = indexPath.row
                    
                    return mapCell
                }
                
                
            }
        
            else {
                
             if(indexPath.row != 18){
                
               
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewRegTableViewCell") as! NewRegTableViewCell
                
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone) {
                    
                    cell.detailTFHeight.constant = 55
                    
                }
                    
                else {
                    
                    cell.detailTFHeight.constant = 65
                    
                }
                

                cell.eyeIconBtn.isHidden = true
                cell.detailsTextField.delegate = self
                
                cell.detailsTextField.tag = indexPath.row
                
                cell.detailsTextField.placeholder = placeholdersAry[indexPath.row]
                
                cell.eyeBtn.addTarget(self, action: #selector(eyeBtnClicked), for: .touchUpInside)
                
                if indexPath.row == 6 {
                    
                    cell.detailsTextField.isSecureTextEntry = true
                    
                    
                    
                }
                    
                else{
                    cell.detailsTextField.isSecureTextEntry = false
                    
                    
                }
                
                
                if indexPath.row == 17 {
                    
                    cell.detailsTextField.isUserInteractionEnabled = false
                    
                    
                }
                    
                else{
                    
                    cell.detailsTextField.isUserInteractionEnabled = true
                    
                }
                
                if indexPath.row == 0 {
                    
                    cell.dropDownImg.isHidden = false
                    cell.eyeBtn.isHidden = true
                    if titleType == "" {
                        
                        cell.detailsTextField.text = selectedtitleTypeStr
                    }
                        
                    else {
                        
                        
                        cell.detailsTextField.text = titleType
                    }
                    
                }
                
                if indexPath.row == 1 {
                    cell.eyeBtn.isHidden = true
                    cell.dropDownImg.isHidden = true
                    cell.detailsTextField.text = fName
                    
                }
                
                else if indexPath.row == 2 {
                    cell.eyeBtn.isHidden = true
                    cell.dropDownImg.isHidden = true
                    cell.detailsTextField.text = mName
                    
                }
                
                else if indexPath.row == 3 {
                    cell.eyeBtn.isHidden = true
                    cell.dropDownImg.isHidden = true
                    cell.detailsTextField.text = lName
                    
                }
                    
                else if indexPath.row == 4 {
                    cell.eyeBtn.isHidden = true
                    cell.dropDownImg.isHidden = false
                    
                    cell.detailsTextField.text = selectedBusinessStr
                    
                }
                    //            else if indexPath.row == 5 {
                    //                cell.eyeBtn.isHidden = true
                    //                cell.dropDownImg.isHidden = true
                    //                cell.detailsTextField.text = userName
                    //            }
                    
                else if indexPath.row == 5 {
                    
                    cell.eyeBtn.isHidden = true
                    cell.dropDownImg.isHidden = true
                 //   if phoneNo.characters.count > 0 {
                        
                        cell.detailsTextField.text = phoneNo
                        
                  //  }
                }
                    
                else if indexPath.row == 6 {
                    
                    cell.eyeBtn.isHidden = false
                    cell.dropDownImg.isHidden = true
                    cell.detailsTextField.text = password
                    
                }
                    
                else if indexPath.row == 7 {
                    cell.eyeBtn.isHidden = true
                    cell.dropDownImg.isHidden = false
                    cell.detailsTextField.text = selectedGenderStr
                }
                    
                else if indexPath.row == 8 {
                    cell.eyeBtn.isHidden = true
                    cell.dropDownImg.isHidden = true
                    
                    cell.detailsTextField.text = eMail
                }
                    
                else if indexPath.row == 9 {
                    cell.eyeBtn.isHidden = true
                    cell.dropDownImg.isHidden = false
                    
                    cell.detailsTextField.text = selectedDOBStr
                }
                    
                else if indexPath.row == 10{
                    cell.eyeBtn.isHidden = true
                    cell.dropDownImg.isHidden = true
                    cell.detailsTextField.text = address1Str
                    
                }
                    
                else if indexPath.row == 11 {
                    cell.eyeBtn.isHidden = true
                    cell.dropDownImg.isHidden = true
                    cell.detailsTextField.text = address2Str
                    
                }
                    
                else if indexPath.row == 12 {
                    cell.eyeBtn.isHidden = true
                    cell.dropDownImg.isHidden = true
                    cell.detailsTextField.text = landMarkStr
                }
                    
                else if indexPath.row == 13{
                    cell.eyeBtn.isHidden = true
                    cell.dropDownImg.isHidden = false
                    
                    cell.detailsTextField.text = selectedProvinceStr
                    
                    
                }
                else if indexPath.row == 14{
                    cell.eyeBtn.isHidden = true
                    cell.dropDownImg.isHidden = false
                    
                    cell.detailsTextField.text = selectedDistrictStr
                    
                }
                    
                else if indexPath.row == 15{
                    cell.eyeBtn.isHidden = true
                    cell.dropDownImg.isHidden = false
                    
                    cell.detailsTextField.text = selectedMandalStr
                    
                }
                else if indexPath.row == 16{
                    cell.eyeBtn.isHidden = true
                    cell.dropDownImg.isHidden = false
                    
                    cell.detailsTextField.text = selectedVillageStr
                }
                    
                else if indexPath.row == 17{
                    
                    
                    cell.dropDownImg.isHidden = true
                    cell.eyeBtn.isHidden = true
                    cell.detailsTextField.text = selectedPostalCode
//                    if self.postalCodeAry.count > 0{
//                        
//                        if let pincode = String(self.postalCodeAry[0]){
//                            
//                            
//                            
//                            if selectedVillageStr.isEmpty{
//                                
//                                cell.detailsTextField.text = ""
//                            }
//                            else {
//                                
//                                cell.detailsTextField.text = String(pincode)
//                                
//                            }
//                        }
//                    }
//                        
//                    else {
//                        
//                        cell.detailsTextField.text = pincode
//                    }
                    
                }
                    
                    
//                else {
//                    cell.eyeBtn.isHidden = true
//                    //cell.dropDownImg.isHidden = true
//                    cell.detailsTextField.inputView = nil
//                    
//                    
//                }
                
                                return cell
                
            }
                
                
            else {
                
                let mapCell = tableView.dequeueReusableCell(withIdentifier: "MapTableViewCell") as! MapTableViewCell
                
                mapCell.lanLatTF.delegate = self
                
                mapCell.lanLatTF.isUserInteractionEnabled = false
                mapCell.nextClicked.addTarget(self, action: #selector(nextBtnClicked), for: .touchUpInside)
                mapCell.updateBtn.addTarget(self, action: #selector(updateBtnClicked), for: .touchUpInside)
                mapCell.cancelBtn.addTarget(self, action: #selector(cancelBtnClicked), for: .touchUpInside)
                
                mapCell.currentLocationBtn.addTarget(self, action: #selector(getCurrentLocation), for: .touchUpInside)
                
                mapCell.userMapview.delegate = self
                
                mapCell.userMapview.showsUserLocation = true
                
                mapCell.currentLocationBtn.tag = indexPath.row
                
                mapCell.lanLatTF.text = lanLatStr
                mapCell.lanLatTF.tag = indexPath.row
                
                return mapCell
            }
            
            
            }
            
        }

      
        
    }
    
    
    
    
//    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        
//        let userLocation:CLLocation = locations[0] as CLLocation
//        locationManager.stopUpdatingLocation()
//        
//        let location = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
//        
//        let span = MKCoordinateSpanMake(0.5, 0.5)
//        
//        let region = MKCoordinateRegion (center:  location,span: span)
//        
//       // mapView.setRegion(region, animated: true)
//    }
    
//MARK: - Mapview delegate methods
    
/*        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            
            var rowNumber : Int = 0
            
            if self.isResponseFromServer == true{
            
                rowNumber = 17
            
            }
            else {
            
            rowNumber = 18
                
            }
            
        
            
            DispatchQueue.main.async()
                {
                self.userLocationCoordinate = userLocation.coordinate
            
            let indexPath : IndexPath = IndexPath(row: rowNumber, section: 0)
            
            if let mapTableViewCell : MapTableViewCell = self.newRegTableview.cellForRow(at: indexPath) as? MapTableViewCell {

                 let userlocation = self.userLocationCoordinate
  
                 let region = MKCoordinateRegionMakeWithDistance((userlocation)!, 1000, 1000)
                 
                 mapTableViewCell.userMapview.setRegion(region, animated: true)
                
                 mapTableViewCell.userMapview.showsUserLocation = true
                 
                 let latitude   = userlocation?.latitude
                 let longitude  = userlocation?.longitude
                
                 
//                 userCurrentLatitude = "\(String(describing: latitude!))"
//                 
//                 userCurrentLongitude = "\(String(describing: longitude!))"
                
                self.userCurrentLatitude = (String(format: "%.4f", latitude!))
                self.userCurrentLongitude = (String(format: "%.4f", longitude!))
                 
                 self.lanLatStr = self.userCurrentLatitude + ", " + self.userCurrentLongitude
                
                print(self.landMarkStr)
                 
                 let location = CLLocation(latitude:latitude!, longitude: longitude!)
                 
                 CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
                 
                 if error != nil{
                 
                 print("faild")
                 return
                 
                 
                 }
                 
                 if (placemarks?.count)! > 0{
                 
                 
                 //     let  pplacemark = placemarks?[0] as? CLPlacemark!
                 
                 // Place details
                 var placeMark: CLPlacemark!
                 placeMark = placemarks?[0]
                 
                 
                 
                 // Address dictionary
                 
                 self.userCurrentaddressDict = placeMark.addressDictionary! as NSDictionary
                 //     print(placeMark.addressDictionary, terminator: "")
                 
                 if let placemark = placemarks?[0] {
                 
                 // Create an empty string for street address
                 var streetAddress = ""
                 
                 // Check that values aren't nil, then add them to empty string
                 // "subThoroughfare" is building number, "thoroughfare" is street
                 if placemark.subThoroughfare != nil && placemark.thoroughfare != nil {
                 
                 streetAddress = placemark.subThoroughfare! + " " + placemark.thoroughfare!
                 
                 } else {
                 
                 print("Unable to find street address")
                 
                 }
                 
                 // Same as above, but for city
                 var city = ""
                 
                 // locality gives you the city name
                 if placemark.locality != nil  {
                 
                 city = placemark.locality!
                 
                 } else {
                 
                 print("Unable to find city")
                 
                 }
                 
                 // Do the same for state
                 var state = ""
                 
                 // administrativeArea gives you the state
                 if placemark.administrativeArea != nil  {
                 
                 state = placemark.administrativeArea!
                 
                 } else {
                 
                 print("Unable to find state")
                 
                 }
                 
                 // And finally the postal code (zip code)
                 var zip = ""
                 
                 if placemark.postalCode != nil {
                 
                 zip = placemark.postalCode!
                 
                 } else {
                 
                 print("Unable to find zip")
                 
                 }
                 
                 print("\(streetAddress)\n\(city), \(state) \(zip)")
                 
                 
                 
                 // Location name
                 //                    if let locationName = placeMark.addressDictionary!["Name"] as? NSString {
                 //                        print(locationName, terminator: "")
                 //                    }
                 //
                 //                    // Street address
                 //                    if let street = placeMark.addressDictionary!["Thoroughfare"] as? NSString {
                 //                        print(street, terminator: "")
                 //                    }
                 //
                 //                    // City
                 //                    if let city = placeMark.addressDictionary!["City"] as? NSString {
                 //                        print(city, terminator: "")
                 //                    }
                 //
                 //                    // Zip code
                 //                    if let zip = placeMark.addressDictionary!["ZIP"] as? NSString {
                 //                        print(zip, terminator: "")
                 //                    }
                 //
                 //                    // Country
                 //                    if let country = placeMark.addressDictionary!["Country"] as? NSString {
                 //                        print(country, terminator: "")
                 //                    }
                 
                 let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                 longitude: location.coordinate.longitude)
                 
//                  Set the span (zoom) of the map view. Smaller number zooms in closer
              //   let span = MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100)
                 
//                  Set the region, using your coordinates & span objects
               //  let region = MKCoordinateRegion(center: coordinate, span: span)
                 
//                  Set your map object's region to the region you just defined
              //   mapTableViewCell.userMapview.setRegion(region, animated: true)
                 
                 self.newRegTableview.reloadData()
                 }
                 
                 else{
                 
                 print("can't find address")
                 
                 }
                 
                 }
                 
                 })
                 
 
            }
            
            }
            
//             let region = MKCoordinateRegionMakeWithDistance((userLocation.coordinate), 1000, 1000)
//                mapView.setRegion(region, animated: true)
                            
        }
 
 */
    
    func getCurrentLocation(_ sender : UIButton){
        
        let indexPath : IndexPath = IndexPath(row: sender.tag, section: 0)
        
         if let mapTableViewCell : MapTableViewCell = newRegTableview.cellForRow(at: indexPath) as? MapTableViewCell {
            
             mapTableViewCell.userMapview.showsUserLocation = true

        }


    }


    
    
//MARK: - Pickerview delegate methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return pickerData.count
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return pickerData[row]
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if self.isResponseFromServer == true{
        
        if activeTextField.tag == 0{
            
            if pickerData.count > row {
        
        selectedtitleTypeStr = pickerData[row]
        activeTextField.text = selectedtitleTypeStr
                
                if(row < titletypeIdAry.count){
                    if let value = Int(titletypeIdAry[row]){
                        titleTypeID = value
                    }
                }

                
            }
        }
        
        if activeTextField.tag == 4{
        
            if pickerData.count > row {
        selectedBusinessStr = pickerData[row]
        activeTextField.text = selectedBusinessStr
            if(row < businessIDAry.count){
                if let value = Int(businessIDAry[row].id){
                    businessID = value
                }
            }
        }
        }
            
        if activeTextField.tag == 6{
            
            if pickerData.count > row {
                
                selectedGenderStr = pickerData[row]
                activeTextField.text = selectedGenderStr
                if(row < genderTypeIDAry.count){
                    if let value = Int(genderTypeIDAry[row].id){
                        genderTypeID = value
                    }
                }
                
                
            }
        }
        
       else if activeTextField.tag == 12{
            
            if pickerData.count > row {
        selectedProvinceStr = pickerData[row]
        activeTextField.text = selectedProvinceStr
        selectedDistrictStr = ""
        selectedVillageStr = ""
        selectedMandalStr = ""
        selectedPostalCode = ""
                if (provinceIDArray.count > row){
                    if let value = Int(provinceIDArray[row].id){
                    
                    provinceID = value
                    }
                }
                
            }
            
             districtsAry.removeAll()
             getDistrictsAPICall()
        }
        
        else if activeTextField.tag == 13{
            
            if pickerData.count > row {
                
                selectedDistrictStr = pickerData[row]
                activeTextField.text = selectedDistrictStr
                selectedMandalStr = ""
                selectedVillageStr = ""
                selectedPostalCode = ""
                
                if (districtIDArray.count > 0){
                
                    if let value = Int(districtIDArray[row].id){
                    
                    districtID = value
                }
            }
             mandalsAry.removeAll()
                getMandalsAPICall()
        }
                   }
            
            
        else if activeTextField.tag == 14{
            
            if pickerData.count > row {
                
                selectedMandalStr = pickerData[row]
                activeTextField.text = selectedMandalStr
                selectedVillageStr = ""
                selectedPostalCode = ""
                
                if (self.mandalIDArray.count > 0){
                
                    if let value = Int(self.mandalIDArray[row].id){
                    mandalID = value
                    }
                }
                
                villagesAry.removeAll()
                getVillagesAPICall()

            }
            
           }
        
        else if activeTextField.tag == 15{
            
            if pickerData.count > row {
                
                selectedVillageStr = pickerData[row]
                activeTextField.text = selectedVillageStr
                
                if villageIDArray.count > 0{
                
                if let value = Int(self.villageIDArray[row].id){
                
                    villageID = value
                
                }
            }
                if villageIDArray.count > 0{
                
                    if let value = String(villageIDArray[row].postCode){
                    
                    selectedPostalCode = value
                    
                    }

                
                
                }
                
                
            }
            
        }
        
        else if activeTextField.tag == 16{
            
            if pickerData.count > row {
                
                selectedPostalCode = pickerData[row]
                activeTextField.text = selectedPostalCode
                
            }
            
            
        }
        
      //  self.newRegTableview.endEditing(true)
        
        
      //  newRegTableview.reloadData()
        
        //newRegPicker.endEditing(true)
        }
        
        
        else {
            
            if activeTextField.tag == 0{
                
                if pickerData.count > row {
                    
                    selectedtitleTypeStr = pickerData[row]
                    activeTextField.text = selectedtitleTypeStr
                    if(row < titletypeIdAry.count){
                        if let value = Int(titletypeIdAry[row]){
                            titleTypeID = value
                        }
                    }
                    
                    
                }
            }
            
            if activeTextField.tag == 4{
                
                if pickerData.count > row {
                    selectedBusinessStr = pickerData[row]
                    activeTextField.text = selectedBusinessStr
                    if(row < businessIDAry.count){
                        if let value = Int(businessIDAry[row].id){
                            businessID = value
                        }
                    }
                }
            }
            
            if activeTextField.tag == 7{
                
                if pickerData.count > row {
                    
                    selectedGenderStr = pickerData[row]
                    activeTextField.text = selectedGenderStr
                    if(row < genderTypeIDAry.count){
                        if let value = Int(genderTypeIDAry[row].id){
                            genderTypeID = value
                        }
                    }
                    
                    
                }
            }
                
            else if activeTextField.tag == 13{
                
                if pickerData.count > row {
                    selectedProvinceStr = pickerData[row]
                    activeTextField.text = selectedProvinceStr
                    selectedDistrictStr = ""
                    selectedVillageStr = ""
                    selectedMandalStr = ""
                    selectedPostalCode = ""
                    
                    if (provinceIDArray.count > row){
                        if let value = Int(provinceIDArray[row].id){
                            
                            provinceID = value
                        }
                    }
                    
                }
                
                districtsAry.removeAll()
                getDistrictsAPICall()
            }
                
            else if activeTextField.tag == 14{
                
                if pickerData.count > row {
                    
                    selectedDistrictStr = pickerData[row]
                    activeTextField.text = selectedDistrictStr
                    selectedVillageStr = ""
                    selectedMandalStr = ""
                    selectedPostalCode = ""
                    
                    if (districtIDArray.count > 0){
                        
                        if let value = Int(districtIDArray[row].id){
                            
                            districtID = value
                        }
                    }
                    mandalsAry.removeAll()
                    getMandalsAPICall()
                }
            }
                
                
            else if activeTextField.tag == 15{
                
                if pickerData.count > row {
                    
                    selectedMandalStr = pickerData[row]
                    activeTextField.text = selectedMandalStr
                    
                    selectedPostalCode = ""
                    
                    if (self.mandalIDArray.count > 0){
                        
                        if let value = Int(self.mandalIDArray[row].id){
                            mandalID = value
                        }
                    }
                    
                    villagesAry.removeAll()
                    getVillagesAPICall()
                    
                }
                
            }
                
            else if activeTextField.tag == 16{
                
                if pickerData.count > row {
                    
                    selectedVillageStr = pickerData[row]
                    activeTextField.text = selectedVillageStr
                    
                    if villageIDArray.count > 0{
                        
                        if let value = Int(self.villageIDArray[row].id){
                            
                            villageID = value
                            
                        }
                    }
                    
                    if villageIDArray.count > 0{
                        
                        if let value = String(villageIDArray[row].postCode){
                            
                            selectedPostalCode = value
                            
                        }
                        
                        
                        
                    }

                }
                
            }
                
            else if activeTextField.tag == 17{
                
                if pickerData.count > row {
                    
                    selectedPostalCode = pickerData[row]
                    activeTextField.text = selectedPostalCode
                    
                }
                
                
            }
            
            //  self.newRegTableview.endEditing(true)
            
            
            //  newRegTableview.reloadData()
            
            //newRegPicker.endEditing(true)
        }
        
        newRegTableview.reloadData()
    }

//MARK: - Textfield validations
    
    
    func validateAllFields() -> Bool {
    
        
        //Check whether textField are left empty or not
        var errorMessage:NSString?
        
        let tType : NSString = selectedtitleTypeStr as NSString
        let fName:NSString = self.fName as NSString
        let lName:NSString = self.lName as NSString
        let mName:NSString = self.mName as NSString
        let bType : NSString = selectedBusinessStr as NSString
        let uName:NSString = self.userName as NSString
        let PWD:NSString = password as NSString
        let gType : NSString = selectedGenderStr as NSString
        let email:NSString = eMail as NSString
        let pNumber:NSString = phoneNo as NSString
        let dob  : NSString = selectedDOBStr as NSString
        let province:NSString = selectedProvinceStr as NSString
        let district:NSString = selectedDistrictStr as NSString
        let mandal:NSString = selectedMandalStr as NSString
        let village:NSString = selectedVillageStr as NSString
        
        let address11:NSString = address1Str as NSString
        let address22:NSString = address2Str as NSString
        let landmarkk:NSString = landMarkStr as NSString
        let lanLat :NSString = lanLatStr as NSString
       
        
        if (tType.length <= 0){
            
            alertTag = 0
            errorMessage=GlobalSupportingClass.titleTypeErrorMessage() as String as String as NSString?
            
        }
        
        else if (fName.length <= 0){
            alertTag = 1
            errorMessage=GlobalSupportingClass.blankFnameErrorMessage() as String as String as NSString?
            
        }
        
        else if !((fName.length > 2) && (fName.length < 40)){
            
           alertTag = 1
            errorMessage=GlobalSupportingClass.firstNamebitweenMessage() as String as String as NSString?
            
        }
            
        else if (lName.length <= 0){
            
             alertTag = 3
            
            errorMessage=GlobalSupportingClass.blankLnameErrorMessage() as String as String as NSString?
            
        }
            
        else if (bType.length <= 0){
            
            alertTag = 4
            
            errorMessage=GlobalSupportingClass.businessCategoryErrorMessage() as String as String as NSString?
            
        }

//        else if !((lName.length > 3) && (lName.length < 40)){
//            
//            errorMessage=GlobalSupportingClass.lastNamebitweenMessage() as String as String as NSString?
//            
//        }
            
     
            
        else if (pNumber.length <= 0){
            
            alertTag = 5
            errorMessage=GlobalSupportingClass.blankPhoneNumberErrorMessage() as String as String as NSString?
            
        }
        else if (pNumber.length != 10) {
            
            alertTag = 5
            errorMessage=GlobalSupportingClass.invalidPhoneNumberErrorMessage() as String as String as NSString?
        }
        
        else if (pNumber == "0000000000") {
            
            alertTag = 5
            errorMessage=GlobalSupportingClass.validPhoneNumberErrorMessage() as String as String as NSString?
        }
//        else if (pNumber.length > 12) {
//            
//            
//            errorMessage=GlobalSupportingClass.invalidPhoneNumberErrorMessage() as String as String as NSString?
//        }
        

            
//       else if (uName.length <= 0){
//            
//            errorMessage=GlobalSupportingClass.userNameErrorMessage() as String as String as NSString?
//            
//        }
        
        
       else  if(self.isResponseFromServer == true){
            
        }
            
            
        else if (self.isResponseFromServer != true){
            
            
            if (PWD.length <= 0){
                alertTag = 6
                errorMessage=GlobalSupportingClass.passwordErrorMessage() as String as String as NSString?
                
            }
                
            else if (!((password.characters.count) >= 8 && (password.characters.count) < 40)){
                alertTag = 6
                errorMessage=GlobalSupportingClass.passwordbitweenMessage() as String as String as NSString?
            }
                
            else if(!GlobalSupportingClass.capitalOnly(password: password as String)) {
                alertTag = 6
                errorMessage=GlobalSupportingClass.capitalLetterMessage() as String as String as NSString?
                
            }
                
            else if(!GlobalSupportingClass.numberOnly(password: password as String)) {
                alertTag = 6
                errorMessage=GlobalSupportingClass.numberMessage() as String as String as NSString?
            }
                
            else if(!GlobalSupportingClass.specialCharOnly(password: password as String)) {
                alertTag = 6
                errorMessage=GlobalSupportingClass.specialCharacterMessage() as String as String as NSString?
            }
            
            
            else if (gType.length <= 0){
                
                if(self.isResponseFromServer == true){
                    alertTag = 6
                }
                else if (self.isResponseFromServer != true){
                    alertTag = 7
                }
                
                
                errorMessage=GlobalSupportingClass.genderCategoryErrorMessage() as String as String as NSString?
                
            }
                
            else if (email.length <= 0){
                
                if(self.isResponseFromServer == true){
                    alertTag = 7
                }
                else if (self.isResponseFromServer != true){
                    alertTag = 8
                }
                errorMessage=GlobalSupportingClass.blankEmailIDErrorMessage() as String as String as NSString?
            }
                
//            else if(!GlobalSupportingClass.isValidEmail(email as NSString)){
//                
//                if(self.isResponseFromServer == true){
//                    alertTag = 7
//                }
//                else if (self.isResponseFromServer != true){
//                    alertTag = 8
//                }
//                errorMessage=GlobalSupportingClass.invalidEmaildIDFormatErrorMessage() as String as String as NSString?
//                
//                
//            }
                
            else if(!GlobalSupportingClass.isEmailValid((email as NSString) as String)){
                
                if(self.isResponseFromServer == true){
                    alertTag = 7
                }
                else if (self.isResponseFromServer != true){
                    alertTag = 8
                }
                errorMessage=GlobalSupportingClass.invalidEmaildIDFormatErrorMessage() as String as String as NSString?
                
                
            }
            else if (email.length<=4)  {
                if(self.isResponseFromServer == true){
                    alertTag = 7
                }
                else if (self.isResponseFromServer != true){
                    alertTag = 8
                }
                errorMessage = GlobalSupportingClass.miniCharEmailIDErrorMessage() as String as String as NSString?
            }
                
            else if (dob.length<=3) {
                if(self.isResponseFromServer == true){
                    alertTag = 8
                }
                else if (self.isResponseFromServer != true){
                    alertTag = 9
                }
                errorMessage=GlobalSupportingClass.dateOfBirthErrorMessage() as String as String as NSString?
            }
                
            else if (address11.length <= 0){
                if(self.isResponseFromServer == true){
                    alertTag = 9
                }
                else if (self.isResponseFromServer != true){
                    alertTag = 10
                }
                errorMessage=GlobalSupportingClass.blankAddress1ErrorMessage() as String as String as NSString?
                
            }
            else if (address22.length <= 0){
                if(self.isResponseFromServer == true){
                    alertTag = 10
                }
                else if (self.isResponseFromServer != true){
                    alertTag = 11
                }
                errorMessage=GlobalSupportingClass.blankAddress2ErrorMessage() as String as String as NSString?
                
            }
            else if (landmarkk.length <= 0){
                if(self.isResponseFromServer == true){
                    alertTag = 11
                }
                else if (self.isResponseFromServer != true){
                    alertTag = 12
                }
                errorMessage=GlobalSupportingClass.blankLandmarkErrorMessage() as String as String as NSString?
                
            }
            else if (province.length <= 0){
                
                if(self.isResponseFromServer == true){
                    alertTag = 12
                }
                else if (self.isResponseFromServer != true){
                    alertTag = 13
                }
                errorMessage=GlobalSupportingClass.blankProvinceErrorMessage() as String as String as NSString?
                
            }
            else if (district.length <= 0){
                if(self.isResponseFromServer == true){
                    alertTag = 13
                }
                else if (self.isResponseFromServer != true){
                    alertTag = 14
                }
                errorMessage=GlobalSupportingClass.blankDistrictErrorMessage() as String as String as NSString?
                
            }
            else if (mandal.length <= 0){
                if(self.isResponseFromServer == true){
                    alertTag = 14
                }
                else if (self.isResponseFromServer != true){
                    alertTag = 15
                }
                errorMessage=GlobalSupportingClass.blankMandalErrorMessage() as String as String as NSString?
                
            }
            else if (village.length <= 0){
                if(self.isResponseFromServer == true){
                    alertTag = 15
                }
                else if (self.isResponseFromServer != true){
                    alertTag = 16
                }
                errorMessage=GlobalSupportingClass.blankVillageErrorMessage() as String as String as NSString?
                
            }
        }
        
        
        else if (gType.length <= 0){
            
            if(self.isResponseFromServer == true){
              alertTag = 6
            }
            else if (self.isResponseFromServer != true){
            alertTag = 7
            }
            
            
            errorMessage=GlobalSupportingClass.genderCategoryErrorMessage() as String as String as NSString?
            
        }
            
        else if (email.length <= 0){
            
            if(self.isResponseFromServer == true){
                alertTag = 7
            }
            else if (self.isResponseFromServer != true){
                alertTag = 8
            }
            errorMessage=GlobalSupportingClass.blankEmailIDErrorMessage() as String as String as NSString?
        }
            
        else if(!GlobalSupportingClass.isValidEmail(email as NSString)){
            
            if(self.isResponseFromServer == true){
                alertTag = 7
            }
            else if (self.isResponseFromServer != true){
                alertTag = 8
            }
            errorMessage=GlobalSupportingClass.invalidEmaildIDFormatErrorMessage() as String as String as NSString?
            
            
        }
        else if (email.length<=4)  {
            if(self.isResponseFromServer == true){
                alertTag = 7
            }
            else if (self.isResponseFromServer != true){
                alertTag = 8
            }
            errorMessage = GlobalSupportingClass.miniCharEmailIDErrorMessage() as String as String as NSString?
        }
            
        else if (dob.length<=3) {
            if(self.isResponseFromServer == true){
                alertTag = 8
            }
            else if (self.isResponseFromServer != true){
                alertTag = 9
            }
            errorMessage=GlobalSupportingClass.dateOfBirthErrorMessage() as String as String as NSString?
        }
            
        else if (address11.length <= 0){
            if(self.isResponseFromServer == true){
                alertTag = 9
            }
            else if (self.isResponseFromServer != true){
                alertTag = 10
            }
            errorMessage=GlobalSupportingClass.blankAddress1ErrorMessage() as String as String as NSString?
            
        }
        else if (address22.length <= 0){
            if(self.isResponseFromServer == true){
                alertTag = 10
            }
            else if (self.isResponseFromServer != true){
                alertTag = 11
            }
            errorMessage=GlobalSupportingClass.blankAddress2ErrorMessage() as String as String as NSString?
            
        }
        else if (landmarkk.length <= 0){
            if(self.isResponseFromServer == true){
                alertTag = 11
            }
            else if (self.isResponseFromServer != true){
                alertTag = 12
            }
            errorMessage=GlobalSupportingClass.blankLandmarkErrorMessage() as String as String as NSString?
            
        }
        else if (province.length <= 0){
            
            if(self.isResponseFromServer == true){
                alertTag = 12
            }
            else if (self.isResponseFromServer != true){
                alertTag = 13
            }
            errorMessage=GlobalSupportingClass.blankProvinceErrorMessage() as String as String as NSString?
            
        }
        else if (district.length <= 0){
            if(self.isResponseFromServer == true){
                alertTag = 13
            }
            else if (self.isResponseFromServer != true){
                alertTag = 14
            }
            errorMessage=GlobalSupportingClass.blankDistrictErrorMessage() as String as String as NSString?
            
        }
        else if (mandal.length <= 0){
            if(self.isResponseFromServer == true){
                alertTag = 14
            }
            else if (self.isResponseFromServer != true){
                alertTag = 15
            }
            errorMessage=GlobalSupportingClass.blankMandalErrorMessage() as String as String as NSString?
            
        }
        else if (village.length <= 0){
            if(self.isResponseFromServer == true){
                alertTag = 15
            }
            else if (self.isResponseFromServer != true){
                alertTag = 16
            }
            errorMessage=GlobalSupportingClass.blankVillageErrorMessage() as String as String as NSString?
            
        }
            
        
        
        
        if let errorMsg = errorMessage{
            
//             Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Alert".localize(), messege: errorMsg as String, clickAction: {
//                
//                
//                let indexPath = IndexPath.init(row: self.activeTextField.tag, section: 0)
//                
//                if let newRegTableViewCell = self.newRegTableview.cellForRow(at: indexPath) as? NewRegTableViewCell {
//                    
//                    newRegTableViewCell.detailsTextField.becomeFirstResponder()
//                }
//             })
//
            
            
            alertWithTitle(title: "app.Alert".localize(), message: errorMsg as String, ViewController: self, toFocus: activeTextField)
            
            
            
           
            
            print(alertTag)

            
            return false
 
        }
        

            
        

    return true
        
    }

//MARK: - Button Actions
    
    func nextBtnClicked(){
        
//        _ keyValue : Any, keyName : String
        
  //  paramsDict.updateValue(keyValue, forKey: keyName)
    
        newRegTableview.endEditing(true)


        if validateAllFields(){

            
            let BankDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "BankDetailsVC") as! BankDetailsViewController
            
            
            
            let indexPath : IndexPath = IndexPath(row: newRegPicker.tag, section: 0)
            if let _ : NewRegTableViewCell = self.newRegTableview.cellForRow(at: indexPath) as? NewRegTableViewCell {
                
              //  let genderTypeID = self.genderTypeIDAry[indexPath.row]
                
            }
            
            let formatter = DateFormatter()
            
            formatter.dateStyle = .long
            formatter.timeStyle = .none
            
            // formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            // convert your string to date
            let yourDate = formatter.date(from: selectedDOBStr)
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let dateOfBirth = formatter.string(from: yourDate!)
            print(dateOfBirth)
            
          
            
        // selectedDOBStr  "2017-11-21T09:18:05.315Z"
            
            if titleTypeID == 0 {
                
                if selectedtitleTypeStr == "Mr." {
                    
                    titleTypeID = Int("17")!
                }
                
                else if selectedtitleTypeStr == "Ms."{
                    
                    titleTypeID = Int("18")!
            }
                else if selectedtitleTypeStr == "Mrs."{
                    
                    titleTypeID = Int("19")!
                }
                
            }
            
            let null = NSNull()
            
            UserDefaults.standard.set(password, forKey: "password")
            UserDefaults.standard.set(userName, forKey: "userName")
            
            let agentRequestId = UserDefaults.standard.value(forKey: "AgentRequestId")

            UserDefaults.standard.synchronize()
            
            
            let PersonalInfoDict =    [
                
                "TitleTypeId": titleTypeID,
                "FirstName": fName,
                "MiddleName": mName,
                "LastName": lName,
                "Phone": phoneNo,
                "Email": eMail,
                "Password": password,
                "GenderTypeId": genderTypeID,
                "DOB": dateOfBirth,
                "Address1": address1Str,
                "Address2": address2Str,
                "Landmark": landMarkStr,
                "VillageId": villageID,
                "ParentAspNetUserId": null,
                "AgentBusinessCategoryId": businessID,
                "AgentRequestId": agentRequestId,
                "CreatedBy": self.userID,
                "ModifiedBy": self.userID
                
                ] as [String : Any]
           
            
            //        let null = NSNull()
            
            let currentDate = GlobalSupportingClass.getCurrentDate()
            
            print("currentDate\(currentDate)")
            
            
            let dictHeaders = ["":"","":""] as NSDictionary
            
            //    let dictHeaders = ["Authorization":UserDefaults.standard.value(forKey: accessToken) as! String,"Authorization":UserDefaults.standard.value(forKey: accessToken) as! String] as NSDictionary
            
            print("dictHeader:\(dictHeaders)")
            
            let strUrl = REGISTERAGENT_API
            
            serviceController.requestPOSTURL(self, strURL: strUrl as NSString, postParams: PersonalInfoDict as NSDictionary, postHeaders: dictHeaders, successHandler:{(result) in
                DispatchQueue.main.async()
                    {
                        
                        print("result:\(result)")
                        
                        let respVO:AgentPersonalnfoVo = Mapper().map(JSONObject: result)!
                        
                        
                        let statusCode = respVO.IsSuccess
                        
                        print("StatusCode:\(String(describing: statusCode))")
                        
                        
                        if statusCode == true
                        {
                            
                         UserDefaults.standard.set(self.phoneNo, forKey: "phoneNo")
                            let personalResult = respVO.Result
                            
                            print("personalResult:\(String(describing: personalResult?.AgentId))")
                            
                            UserDefaults.standard.set(personalResult?.AgentId, forKey: "AgentId")
                            UserDefaults.standard.set(personalResult?.AspNetUserId, forKey: "AspNetUserId")
                            
                            UserDefaults.standard.synchronize()
                            
                            let successMsg = respVO.EndUserMessage
                        
                            
        
                            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Success".localize(), messege: successMsg!, clickAction: {
                                
                               // BankDetailsVC.paramsDict = agentPersonalInfoDict
                                self.navigationController?.pushViewController(BankDetailsVC, animated: true)
                                
                            })
                            
                            
                            
                            
                            
                        }
                        else if statusCode == false{
                            
                            let failMsg = respVO.EndUserMessage
                            
                            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(), messege: failMsg!, clickAction: {
                                
                                
                            })
                            
                            
                            
                        }
                            
                        else
                        {
                            
                        
                            
                            
                            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(), messege: "app.ServerError".localize(), clickAction: {
                                
                                
                            })
                }
                }
            }, failureHandler: {(error) in
                
              
                
                    
                    if error == "unAuthorized" {
                        
                        self.serviceController.refreshTokenForLogin(self, successHandler: { (json) in
                            
                            self.nextBtnClicked()
                            
                            
                        }, failureHandler: { (failureMassage) in
                            
                            Utilities.sharedInstance.goToLoginScreen()
                            
                        })
                        
                    
                    
                    
                }
                
                
                
            })
            
            
            
            
            
        }
            
        
    }

//MARK: - Button Actions
    
    
    func eyeBtnClicked(sender: UIButton){
        
        
    
        let indexPath : IndexPath = IndexPath(row: 6, section: 0)
        
        if let newRegTableViewCell : NewRegTableViewCell = newRegTableview.cellForRow(at: indexPath) as? NewRegTableViewCell {
            
            if eyeiconClick == true {
                newRegTableViewCell.detailsTextField.isSecureTextEntry = false
            
                
                newRegTableViewCell.eyeBtn.setImage(UIImage(named: "Eye"), for: .normal)
                eyeiconClick = false
            }
                
            else if eyeiconClick == false
            {
                
                newRegTableViewCell.detailsTextField.isSecureTextEntry = true
                newRegTableViewCell.eyeBtn.setImage(UIImage(named: "eye2"), for: .normal)
                eyeiconClick = true
                
            }
            
        }
    
    
    }
    
    func updateBtnClicked(sender: UIButton){
        
        newRegTableview.endEditing(true)

       self.updateButtonAPICall()
            
        
    }
    
    
    func updateButtonAPICall(){
    
         if validateAllFields(){
            
            let null = NSNull()
            
            
            
            //        formatter.dateStyle = .long
            //        formatter.timeStyle = .none
            //
            //        // formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            //        // convert your string to date
            //        if !(selectedDOBStr.isEmpty){
            //            let yourDate = formatter.date(from: selectedDOBStr)
            //            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            //            dateOfBirth = formatter.string(from: yourDate!)
            //            print(dateOfBirth)
            
            let formatter = DateFormatter()
            
            formatter.dateStyle = .long
            formatter.timeStyle = .none
            
            // formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            // convert your string to date
            
            print(selectedDOBStr)
            
            formatter.dateFormat = "MMM dd, yyyy"
            
            let yourDate = formatter.date(from: selectedDOBStr)
            
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            
            let dateB = formatter.string(from: yourDate!)
            print(dateOfBirth)
            
            let dob:String = dateB
            
            
            updateDict =   [
                "AspNetUserId": aspNetUserId,
                "AgentBusinessCategoryId": businessID,
                "AgentRequestId": agentReqIdUpdate,
                "TitleTypeId": titleTypeID,
                "FirstName": fName,
                "MiddleName": mName,
                "LastName": lName,
                "Phone": phoneNo,
                "Email": eMail,
                "GenderTypeId": genderTypeID,
                "DOB": dob,
                "Address1": address1Str,
                "Address2": address2Str,
                "Landmark": landMarkStr,
                "VillageId": villageID,
                "ParentAspNetUserId": null,
                "EducationTypeId": null,
                "Id": idUpdate,
                "IsActive": isActiveUpdate
                ] as [String:Any]
            
            
            let currentDate = GlobalSupportingClass.getCurrentDate()
            
            print("currentDate\(currentDate)")
            
            
            let dictHeaders = ["":"","":""] as NSDictionary
            
            //    let dictHeaders = ["Authorization":UserDefaults.standard.value(forKey: accessToken) as! String,"Authorization":UserDefaults.standard.value(forKey: accessToken) as! String] as NSDictionary
            
            print("dictHeader:\(dictHeaders)")
            
            let strUrl = UPDATEPERSONALINFO_API
            
            serviceController.requestPOSTURL(self, strURL: strUrl as NSString, postParams: updateDict as NSDictionary, postHeaders: dictHeaders, successHandler:{(result) in
                DispatchQueue.main.async()
                    {
                        
                        print("result:\(result)")
                        
                        let respVO:UpdateAgentPersonalInfoVo = Mapper().map(JSONObject: result)!
                        
                        
                        let statusCode = respVO.IsSuccess
                        
                        print("StatusCode:\(String(describing: statusCode))")
                        
                        
                        if statusCode == true
                        {
                            
                            let successMsg = respVO.EndUserMessage
                            
                            
                            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Success".localize(), messege: successMsg!, clickAction: {
                                
                                let aspId:String = (respVO.Result?.AspNetUserId)!
                                
                                UserDefaults.standard.set(aspId, forKey: "AspNetUserId")
                                UserDefaults.standard.synchronize()
                                
                                let BankDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "BankDetailsVC") as! BankDetailsViewController
                                
                                BankDetailsVC.aspIDD = aspId
                                
                                BankDetailsVC.fromBack = true
                                
                                self.navigationController?.pushViewController(BankDetailsVC, animated: true)
                                
                            })
                            
                            
                            
                            
                            
                        }
                        else if statusCode == false{
                            
                            let failMsg = respVO.EndUserMessage
                            
                            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(), messege: failMsg!, clickAction: {
                                
                                
                            })
                            
                            
                            
                        }
                            
                        else
                        {
                            
                            let failMsg = respVO.EndUserMessage
                            
                            
                            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(), messege: failMsg!, clickAction: {
                                
                                
                            })
                        }
                }
            }, failureHandler: {(error) in
                
                if error == "unAuthorized" {
                    
                    self.serviceController.refreshTokenForLogin(self, successHandler: { (json) in
                        
                        self.self.updateButtonAPICall()
                        
                        
                    }, failureHandler: { (failureMassage) in
                        
                        Utilities.sharedInstance.goToLoginScreen()
                        
                    })
                    
                    
                    
                    
                }
                
                
            })
        
            
        }
    
    }
    
    
    func cancelBtnClicked(sender: UIButton){
    
        let homeNav : UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeNav") as! UINavigationController
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = homeNav
    
    }

    
    @IBAction func backClicked(_ sender: Any) {
        
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func logOutBtnAction(_ sender: Any) {
        
        Utilities.sharedInstance.alertWithYesNoButtonAction(vc: self, alertTitle: "app.Alert".localize(), messege: "app.AreYouSureWantToLogout".localize()) {
            
            let LoginNav : UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginNav") as! UINavigationController
            
            UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
            UserDefaults.standard.synchronize()
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = LoginNav
            
        }

        
    }
    

    @IBAction func buttonsClicked(_ sender: UIButton) {
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        let isFromBack = false
     
    
        switch sender.tag
        {
        case 1:
            
            for moveToVC in viewControllers {
                if moveToVC is NewAgentRegistrationViewController {
                    let vc = moveToVC as? NewAgentRegistrationViewController
                    vc?.fromBack = true
                    
                    _ = self.navigationController?.popToViewController(vc!, animated: true)
                }
            }
            
            if(isFromBack == false){
                
                
            }
            
       
            
            break
        case 2:
            
            for moveToVC in viewControllers {
                if moveToVC is BankDetailsViewController {
                    let vc = moveToVC as? BankDetailsViewController
                    vc?.fromBack = true
                    
                    _ = self.navigationController?.popToViewController(vc!, animated: true)
                }
            }
            
            if(isFromBack == false){
            
                let BankDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "BankDetailsVC") as! BankDetailsViewController
                
             //   BankDetailsVC.aspIDD = aspId
                
                BankDetailsVC.fromBack = true
                
                
                self.navigationController?.pushViewController(BankDetailsVC, animated: true)
                
            
            }

            
           
            
            break
        case 3:
            
            for moveToVC in viewControllers {
                if moveToVC is IdentityViewController {
                    let vc = moveToVC as? IdentityViewController
                    vc?.fromBack = true
                    
                    
                    _ = self.navigationController?.popToViewController(vc!, animated: true)
                }
            }
            
            if(isFromBack == false){
            
//            let IdentityViewController = self.storyboard?.instantiateViewController(withIdentifier: "IdentityViewController") as! IdentityViewController
//                
//                self.navigationController?.pushViewController(IdentityViewController, animated: true)
            
            }
            
            break
            
        case 4:
            
            for moveToVC in viewControllers {
                if moveToVC is AddDocumentViewController {
                    let vc = moveToVC as? AddDocumentViewController
                     vc?.fromBack = true
                    _ = self.navigationController?.popToViewController(vc!, animated: true)
                }
            }
            break
            
        default: print("Other...")
        }

    }
    
    
    @IBAction func homeClicked(_ sender: Any) {
        
        let homeNav : UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeNav") as! UINavigationController
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = homeNav
        
    
    }
    
    func alertWithTitle(title: String!, message: String, ViewController: UIViewController, toFocus:UITextField) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "app.OK".localize(), style: UIAlertActionStyle.cancel,handler: {_ in
            
            let indexPath : IndexPath = IndexPath(row: self.alertTag, section: 0)
            
             self.newRegTableview.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: false)
            if let itemNumberCell = self.newRegTableview.cellForRow(at: indexPath) as? NewRegTableViewCell {
               
                itemNumberCell.detailsTextField.becomeFirstResponder()
            }
            
          
             //self.activeTextField.becomeFirstResponder()
           // toFocus.becomeFirstResponder()
        });
        alert.addAction(action)
       // alert.view.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ViewController.present(alert, animated: true, completion:nil)
    }

    
    
}
