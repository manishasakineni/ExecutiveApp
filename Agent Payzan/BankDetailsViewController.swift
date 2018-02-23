//
//  BankDetailsViewController.swift
//  Agent Payzan
//
//  Created by Nani Mac on 12/10/17.
//  Copyright © 2017 Naveen. All rights reserved.
//

import UIKit
import TextFieldEffects

class BankDetailsViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UIScrollViewDelegate {
    
    
    @IBOutlet weak var banksScrollView: UIScrollView!
    @IBOutlet weak var headerImgHeight: NSLayoutConstraint!
    
    @IBOutlet weak var headerImgVW: UIImageView!
    
    var paramsDict = [String:Any]()
    
    let imagesPicker = UIImagePickerController()
    
    @IBOutlet weak var accountHolderTF: AkiraTextField!
    
    @IBOutlet weak var accountNoTF: AkiraTextField!
    let pickerView = UIPickerView()
    
    @IBOutlet weak var bankNameTF: AkiraTextField!

    @IBOutlet weak var branchNameTF: AkiraTextField!
    
    @IBOutlet weak var swiftCodeTF: AkiraTextField!
    
    var aspIDD:String = ""
    
    
    var getBankDetailsArray : Array = Array<ParametersAPIModel>()
    
    var bankID : Int = 0
    var branchID : Int = 0
    
   

    
    
    @IBOutlet weak var docImgVW: UIImageView!
    
    
    @IBOutlet weak var holderNameHeight: NSLayoutConstraint!
    
    @IBOutlet weak var acNumberHeight: NSLayoutConstraint!
    
    @IBOutlet weak var bankNameHeight: NSLayoutConstraint!
    
    @IBOutlet weak var branchNameHeight: NSLayoutConstraint!
    
    @IBOutlet weak var swiftCodeHeight: NSLayoutConstraint!
    
    @IBOutlet weak var nextBtnHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var updateBtn: UIButton!
    
//    let userId:String = UserDefaults.standard.string(forKey: AId)!

    
    var fName:String = ""
    var eMail:String = ""
    var phoneNo:String = ""
    var agentReqId:Int = 0
    var addressStr:String = ""
    var titleTypee:String = ""
    
    var businesCatgory:String = ""
    var agencyName:String = ""
    var emailId:String = ""
    var ProvineceName:String = ""
    var state:String = ""
    
    var picode:String = ""
    var latlan:String = ""
    
    var aspNetUserId : String = ""
    
    var agentIdUpdate :String = ""
    var bankNameUpdate :String = ""
    var branchNameUpdate :String = ""
    var swiftCodeUpdate :String = ""
    var holderNameUpdate :String = ""
    var accountNoUpdate :String = ""
    var createdByUpdate :String = ""
    var idUpdate :Int = 0
    
    var bankNamesAry : Array<String> = Array()
    var bankIDSAry : Array<String> = Array()
    var bankBranchesArray :  Array<String> = Array()
    var branchIDAry  : Array = Array<ParametersAPIModel>()
    var swiftCodesAry : Array<String> = Array()
    
    var pickerDataAry : Array<String> = Array()
    
   
    var serviceController = ServiceController()
    
    var activeTextfield = UITextField()
    
    var userID : String = ""
    
    var selectedbankName = ""
    var selectedbankBranch = ""
    var selectedSwiftCode = ""
    var accountHolderName = ""
    var accountNo : Int = 0
    
    var fromBack : Bool = false

    @IBOutlet weak var addDocsBtn: UIButton!
    
    @IBOutlet weak var personalBtn: UIButton!
    
    @IBOutlet weak var bankBtn: UIButton!
    
    @IBOutlet weak var idProofsBtn: UIButton!
    
    @IBOutlet weak var documentsBtn: UIButton!
    
    var refresher:UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
        
        
        if let uniqueID = defaults.string(forKey: "AspNetUserId") {
            
            aspNetUserId = uniqueID
            
            print("defaults savedString: \(aspNetUserId)")
        }
        
        textForIpodAndIphone()
        
//        bankNameTF.placeholder = "Select Bank"
//        branchNameTF.placeholder = "Select Branch"
//        swiftCodeTF.placeholder = "Select Swift Code"
        
        
        pickerView.delegate = self
        accountHolderTF.delegate = self
        accountNoTF.delegate = self
        bankNameTF.delegate = self
        branchNameTF.delegate = self
        swiftCodeTF.delegate = self
        swiftCodeTF.isUserInteractionEnabled = false
        
//        if branchNameTF.text != "" {
//        branchNameTF.isUserInteractionEnabled = true
//        }
//        
//        else {
//        
//        branchNameTF.isUserInteractionEnabled = false
//        }
        
        accountHolderTF.keyboardType = .default
        accountNoTF.keyboardType = .numberPad

        self.banksScrollView.delegate = self
        
        self.refresher = UIRefreshControl()
        
        self.banksScrollView.delegate = self
        
        self.refresher.tintColor = UIColor.white
        
        //  [self.scrollView insertSubview:refreshControl atIndex:0];
        self.refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
        self.banksScrollView.insertSubview(self.refresher, at: 0)
        
        getBankDetailsAPICall()


        
        forIpodAndIphone()
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
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.banksScrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height:UIScreen.main.bounds.size.height + 200)
        self.banksScrollView.showsVerticalScrollIndicator = false
    
        if fromBack == true {
            
            getAgentbankDetailssApiCall()
        
            self.personalBtn.isUserInteractionEnabled = true
            self.bankBtn.isUserInteractionEnabled = false
            self.idProofsBtn.isUserInteractionEnabled = true
            self.documentsBtn.isUserInteractionEnabled = true

        }
        
        if fromBack == false {
            
            getAgentbankDetailssApiCall()
            
            self.personalBtn.isUserInteractionEnabled = true
            self.bankBtn.isUserInteractionEnabled = false
            self.idProofsBtn.isUserInteractionEnabled = true
            self.documentsBtn.isUserInteractionEnabled = true
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func loadData() {
        //code to execute during refresher
     //   getAgentbankDetailssApiCall()
        //Call this to stop refresher
    }
    
    func stopRefresher() {
        self.refresher.endRefreshing()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        
        
        print("scrollViewDidScroll")
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView){
        
        getAgentbankDetailssApiCall()
        print("scrollViewWillBeginDragging")
        
        
    }
    
//MARK: - USER_INTERFACE for ipad and iphone
    
    func textForIpodAndIphone(){
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
            
            holderNameHeight.constant = 60
            acNumberHeight.constant   = 60
            bankNameHeight.constant   = 60
            branchNameHeight.constant = 60
            swiftCodeHeight.constant  = 60
            
//            nextBtnHeight.constant = 50
            
            
        }
            
        else {
            
            holderNameHeight.constant = 50
            acNumberHeight.constant   = 50
            bankNameHeight.constant   = 50
            branchNameHeight.constant = 50
            swiftCodeHeight.constant  = 50
        }
        
    }
    
//MARK: - Api call for get bank Details 
    
    func getAgentbankDetailssApiCall(){
        
        //   UserDefaults.standard.set(self.userDetailsDoictionary.id, forKey: AId)
        
        if(appDelegate.checkInternetConnectivity()){
            
            let strUrl = GETAGENTBANKINFO_API + aspNetUserId

            
            serviceController.requestGETURL(self, strURL:strUrl, success:{(result) in
                DispatchQueue.main.async()
                    {
                        
                        let respVO : GetBankInfoVo = Mapper().map(JSONObject: result)!
                        
                        
                        
                        let isActive = respVO.IsSuccess
                        
                        self.stopRefresher()
                        
                        if(isActive == true){
                            
                            
                            if !(respVO.ListResult?.isEmpty)!{
                                
                                
                                self.updateBtn.isHidden = false
                                self.idProofsBtn.isUserInteractionEnabled = true
                                
                                let IDInfo = respVO.ListResult?[0]
                                
                                self.agentIdUpdate    = (IDInfo?.AgentId)!
                                self.createdByUpdate = (IDInfo?.CreatedBy)!
                                self.idUpdate = (IDInfo?.Id)!
                                
                                self.bankNameUpdate   = (IDInfo?.BankName)!
                                self.branchNameUpdate = (IDInfo?.BranchName)!
                                self.swiftCodeUpdate  = (IDInfo?.SwiftCode)!
                                self.holderNameUpdate = (IDInfo?.AccountHolderName)!
                                self.accountNoUpdate  = (IDInfo?.AccountNumber)!
                                self.branchID         = (IDInfo?.BankId)!
                                self.bankID           = (IDInfo?.BankTypeId)!
                                
                                
                                self.bankNameTF.text      = (IDInfo?.BankName)!
                                self.branchNameTF.text    = (IDInfo?.BranchName)!
                                self.accountHolderTF.text = (IDInfo?.AccountHolderName)!
                                self.accountNoTF.text     = (IDInfo?.AccountNumber)!
                                self.swiftCodeTF.text     = (IDInfo?.SwiftCode)!
                                
                                
                                self.getBankBranchesAndSwiftCode()
                                
                            }
                                
                            else {
                                
                                self.idProofsBtn.isUserInteractionEnabled = false
                                
                            }
                            
                        } else if(isActive == false) {
                            
                            
                            
                        }
                }
                
            },
            failure:  {(error) in
                
                
                 self.idProofsBtn.isUserInteractionEnabled = false
                
                if error == "unAuthorized" {
                    
                    self.serviceController.refreshTokenForLogin(self, successHandler: { (json) in
                        
                        self.self.getAgentbankDetailssApiCall()
                        
                        
                    }, failureHandler: { (failureMassage) in
                        
                        Utilities.sharedInstance.goToLoginScreen()
                        
                    })
                    
                    
                    
                    
                }
                
            })
        }
        else {
            
            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(), messege: "app.Pleasecheckyourinternetconnection!".localize(), clickAction: {
                
                self.stopRefresher()
            })
            
        }
        
       
        
        
    }
    
    
    func getBankDetailsAPICall(){
    
        let classTypeID = "1"
        
        let strUrl = BANKNAMES_API + "" + classTypeID
        
        print("strUrl:\(strUrl)")
        
        APIModel.sharedInstance.getRequest(self, withUrl:strUrl , successBlock: { (json) in
            
            if(json.count > 0){
                
                self.stopRefresher()
                
                self.getBankDetailsArray = ParsingModelClass.sharedInstance.getBankNamesAPIModelParsing(object: json as AnyObject?)
                
                print(self.getBankDetailsArray.count)
                
                if(self.getBankDetailsArray.count > 0){
                    
                    for bankDetails in self.getBankDetailsArray{
                        
                    self.bankNamesAry.append(bankDetails.descriptions)
                    self.bankIDSAry.append(bankDetails.id)
                        
                    self.bankNameTF.inputView = self.pickerView
                    
                    }
                    
                     print(self.bankIDSAry.count)
                    
                }
                
                else{
                
                print("Nooo items")
                
                }
                
                
            }
            
        })  { (failureMessage) in
            
//            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Worning".localize(), messege: failureMessage, clickAction: {
//                
//                
//            })
            
            if failureMessage == "unAuthorized" {
                
                self.serviceController.refreshTokenForLogin(self, successHandler: { (json) in
                    
                    self.self.getBankDetailsAPICall()
                    
                    
                }, failureHandler: { (failureMassage) in
                    
                    Utilities.sharedInstance.goToLoginScreen()
                    
                })
                
                
                
                
            }

            
            print("json Failed")
            
            
        }
    
    }
    
    
    func getBankBranchesAndSwiftCode(){
    
        let classTypeID = ("\(bankID)")
        
        let strUrl = BANKBRANCHES_API + "" + classTypeID
        
        print("strUrl:-->>  \(strUrl)")
        
        APIModel().getRequest(self, withUrl: strUrl, successBlock: { (json) in
            
            
            if(json.count > 0){
                
                self.stopRefresher()
                
                let bankBranchesAndSwiftCodeAry = ParsingModelClass.sharedInstance.getBankBranchesAPIModelParsing(object: json as AnyObject?)
                
                print(bankBranchesAndSwiftCodeAry.count)
                
                if(bankBranchesAndSwiftCodeAry.count > 0){
                    
                    self.branchIDAry = bankBranchesAndSwiftCodeAry
                    
                    self.bankBranchesArray.removeAll()
                    self.swiftCodesAry.removeAll()
                    
                    for branchDetails in bankBranchesAndSwiftCodeAry{
                        
                       
                        
                        self.bankBranchesArray.append(branchDetails.branchName)
                        self.swiftCodesAry.append(branchDetails.swiftCode)
    
                    }
                
//                    self.branchNameTF.text = self.bankBranchesArray[0]
//                    self.swiftCodeTF.text = self.swiftCodesAry[0]
                    
                    if self.bankBranchesArray.count  == self.swiftCodesAry.count {
                        
                        if let value = Int(self.branchIDAry[0].id){
                            
                            self.branchID = value
                        }
                        
                        
                    }
                    
                    print("--->>%@",self.bankBranchesArray.count)
                }
                
                else{
                    
                    print("No items")
                    self.bankBranchesArray.removeAll()
                    if self.bankBranchesArray.count > 0{
                    
                        self.branchNameTF.isUserInteractionEnabled = false
                    }
                    
                    self.swiftCodesAry.removeAll()
                    
                    if self.swiftCodesAry.count > 0{
                        
                        self.swiftCodeTF.isUserInteractionEnabled = false
                    }
                    
                }
            
            }
            
        }) { (failureMessage) in
            
//            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Worning".localize(), messege: failureMessage, clickAction: {
//                
//                
//            })
            
            if failureMessage == "unAuthorized" {
                
                self.serviceController.refreshTokenForLogin(self, successHandler: { (json) in
                    
                    self.self.getBankBranchesAndSwiftCode()
                    
                    
                }, failureHandler: { (failureMassage) in
                    
                    Utilities.sharedInstance.goToLoginScreen()
                    
                })
                
                
                
                
            }
            
            print("json Failed")
            
            
        }
 
    }
    
//MARK: - UITextfield delegate methods
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == accountHolderTF {
        
        textField.keyboardType = .default
        
        }
        
        else if  textField == accountNoTF {
            
            textField.keyboardType = .numberPad
            
        }
        
        else if textField == bankNameTF{
            
            
        pickerDataAry = bankNamesAry
        activeTextfield = bankNameTF
            activeTextfield.tag = 1
        activeTextfield.text = ""
         branchNameTF.text = ""
         swiftCodeTF.text = ""
        self.pickUp(activeTextfield)
        pickerView.reloadAllComponents()
        pickerView.selectRow(0, inComponent: 0, animated: false)
            
        }
        

        
        else if textField == branchNameTF{
        
        pickerDataAry = bankBranchesArray
      
        activeTextfield = branchNameTF
            activeTextfield.tag = 2
        activeTextfield.text = ""
         swiftCodeTF.text = ""
            self.pickUp(activeTextfield)
        pickerView.reloadAllComponents()
        pickerView.selectRow(0, inComponent: 0, animated: false)

        }
        
        else if textField == swiftCodeTF{
            
            pickerDataAry = swiftCodesAry
            activeTextfield = swiftCodeTF
            activeTextfield.text = ""
            
            
            pickerView.reloadAllComponents()
            pickerView.selectRow(0, inComponent: 0, animated: false)
        }
    }
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        self.pickerView.endEditing(true)
        
        
        activeTextfield.tag = 0
        
        if textField == bankNameTF{
            
          
            bankNameTF.text = selectedbankName
            if (bankNameTF.text?.isEmpty)! {
            
                branchNameTF.isUserInteractionEnabled = false
            }
            else {
            branchNameTF.isUserInteractionEnabled = true
            }
          //  activeTextfield.text = ""
            
            pickerView.reloadAllComponents()
            pickerView.selectRow(0, inComponent: 0, animated: false)
            
        }
            
        else if textField == swiftCodeTF{
            
          
            
            swiftCodeTF.text = selectedSwiftCode
                
            
           // activeTextfield.text = ""
            
            pickerView.reloadAllComponents()
            pickerView.selectRow(0, inComponent: 0, animated: false)
        }
            
        else if textField == branchNameTF{
            
           
           branchNameTF.text = selectedbankBranch
          
           // activeTextfield.text = ""
            
            pickerView.reloadAllComponents()
            pickerView.selectRow(0, inComponent: 0, animated: false)
            
        }
        
        else if textField == accountHolderTF{
            
            
            accountHolderName = textField.text!
            
        }
        else if textField == accountHolderTF{
            
            if let value = Int(textField.text!){
                accountNo =  value
            }
        }
        
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        /// 1. replacementString is NOT empty means we are entering text or pasting text: perform the logic
        /// 2. replacementString is empty means we are deleting text: return true
        
        if textField == accountHolderTF{
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
                
                
//!(range.location > 0 && (string.characters.count ?? 0) > 0 && CharacterSet.whitespaces.characterIsMember(string[string.index(string.startIndex, offsetBy: 0)]) && CharacterSet.whitespaces.characterIsMember((textField.text?[textField.text?.index(textField.text?.startIndex, offsetBy: range.location - 1)])!))
      
//                !(range.location > 0 &&  (string.characters.count) > 0 && CharacterSet.whitespaces.contains(string.index(string.startIndex, offsetBy: 0)) && CharacterSet.whitespaces.contains(textField.text?.index(textField.text.startIndex, offsetBy: range.location - 1)!))

  
               
                return (unwantedStr.characters.count == 0 || spaceStr.characters.count == 0) && newLength <= 100
                
                
            }
            
          
            
            return true
        }
        
        if textField == accountNoTF {
            if string.characters.count > 0 {
                
                let currentCharacterCount = textField.text?.characters.count ?? 0
                if (range.length + range.location > currentCharacterCount){
                    return false
                }
                let newLength = currentCharacterCount + string.characters.count - range.length
                let allowedCharacters = CharacterSet.decimalDigits
                
                let unwantedStr = string.trimmingCharacters(in: allowedCharacters)
                return unwantedStr.characters.count == 0 && newLength <= 40
            }
            
            return true
        }
    return true
    }
    
    func pickUp(_ textField : UITextField){
        
        textField.inputView = self.pickerView
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = #colorLiteral(red: 0.5021751523, green: 0.01639934443, blue: 0, alpha: 1)
        // UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "app.Done".localize(), style: .plain, target: self, action: #selector(doneClick))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "app.Cancel".localize(), style: .plain, target: self, action: #selector(cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        if textField.inputView == pickerView{
            textField.inputAccessoryView = toolBar
        }
    }
    
    func doneClick() {
        
        switch activeTextfield.tag {
        case 1:
            if selectedbankName == ""{
                
                selectedbankName = bankNamesAry[0]
                
                if( getBankDetailsArray.count > 0){
                    if let value = Int(getBankDetailsArray[0].id){
                        bankID = value
                    }
                }
                
                getBankBranchesAndSwiftCode()
            }
            
            case 2:
                if selectedbankBranch == ""{
                    if bankBranchesArray.count > 0 {
                        
                        selectedbankBranch = bankBranchesArray[0]
                        if bankBranchesArray.count > 0{
                            
                            if let value = branchIDAry[0].swiftCode  as? String{
                                
                                self.swiftCodeTF.text = value
                            }
                            
                        }
                        
                        
                        
                    }
                    
                    
            }
            
                else {
                    
                    if bankBranchesArray.count > 0{
                        
                        if let value = branchIDAry[0].swiftCode  as? String{
                            
                            self.swiftCodeTF.text = value
                        }
                        
                    }
                    
            }
            
        default:
            break
        }
        
        
        
        
        
        
       
    activeTextfield.resignFirstResponder()
    
    }
    
    func cancelClick() {
        
        activeTextfield.resignFirstResponder()
        
        
        
    }
    
//MARK: - Pickerview delegate methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
       
        
        return self.pickerDataAry.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
    
        return self.pickerDataAry[row]
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        if(activeTextfield == bankNameTF){
            
            if pickerDataAry.count > 0{
            selectedbankName = pickerDataAry[row]
            self.branchNameTF.inputView = self.pickerView
          //  self.swiftCodeTF.inputView = self.pickerView
            
            if(getBankDetailsArray.count > 0){
                if let value = Int(getBankDetailsArray[row].id){
                    bankID = value
                }
            }
            
            self.getBankBranchesAndSwiftCode()
            
        }
    }
        else if(activeTextfield == branchNameTF){
            if pickerDataAry.count > 0{
        selectedbankBranch = pickerDataAry[row]
                
                if bankBranchesArray.count > 0{
                
                    if let value = branchIDAry[row].swiftCode  as? String{
                    
                    self.swiftCodeTF.text = value
                    }
                
                }
      //  self.swiftCodeTF.text = self.swiftCodesAry[0]
        
                if branchIDAry.count > row{
                
                    if let value = Int(branchIDAry[row].id){
                        
                        self.branchID = value
                    }
                    
                    
                }
        }
        }
        else if(activeTextfield == swiftCodeTF){
            if pickerDataAry.count > 0{
            selectedSwiftCode = pickerDataAry[row]
        }
        }
        self.pickerView.endEditing(true)
        self.view.endEditing(true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            
            self.docImgVW.image = image
            
        }
        else {
            
            
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
//MARK: - Button Actions
    
    @IBAction func submitClicked(_ sender: Any) {
        
      submitAPICall()
    
    }
    
    func submitAPICall(){
    
        
        var validateSuccess = true
        
        if ((bankNameTF.text?.isEmpty)! || (branchNameTF.text?.isEmpty)! || (swiftCodeTF.text?.isEmpty)! || (accountHolderTF.text?.isEmpty)! || (accountNoTF.text?.isEmpty)!) {
            
            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(), messege: "app.Pleaseenterallfields".localize(), clickAction: {
                
            })
            
            validateSuccess = false
            return
            
        }
            
        else {
            
            if (accountHolderTF.text?.characters.count)! > 40 {
                
                Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(), messege: "app.AccountHolderNamecannotexceed40characters".localize(), clickAction: {
                    
                })
                validateSuccess = false
                return
            }
                
            else  if (accountNoTF.text?.characters.count)! > 40 {
                
                Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(), messege: "app.AccountNumbercannotexceed40characters".localize(), clickAction: {
                    
                })
                validateSuccess = false
                return
            }
            
        }
        
        
        if validateSuccess == true {
            
            
            if(appDelegate.checkInternetConnectivity()){
                
                //    userRegistrationData.updateValue("", forKey: "AgentBusinessCategoryId")
                
                let null = NSNull()
                
                
                
                let agentBankInformationDict = [
                    
                    "AgentId": null,
                    "BankId": self.branchID,
                    "AccountHolderName": accountHolderName,
                    "AccountNumber": accountNo,
                    "Id": 0,
                    "IsActive": true
                    ] as [String : Any]
                
                paramsDict.updateValue(agentBankInformationDict, forKey: "AgentBankInfo")
                
                print(paramsDict)
                
                
                let accNo:String = accountNoTF.text!
                
                
                let agentBankDict =  [
                    "AgentId": aspNetUserId,
                    "BankId": self.branchID,
                    "AccountHolderName": accountHolderName,
                    "AccountNumber": accNo,
                    "Id": 0,
                    "IsActive": true
                    ] as [String : Any]
                
                
                
                let currentDate = GlobalSupportingClass.getCurrentDate()
                
                print("currentDate\(currentDate)")
                
                
                let dictHeaders = ["":"","":""] as NSDictionary
                
                //    let dictHeaders = ["Authorization":UserDefaults.standard.value(forKey: accessToken) as! String,"Authorization":UserDefaults.standard.value(forKey: accessToken) as! String] as NSDictionary
                
                print("dictHeader:\(dictHeaders)")
                
                let strUrl = REGISTERBANK_API
                
                serviceController.requestPOSTURL(self, strURL: strUrl as NSString, postParams: agentBankDict as NSDictionary, postHeaders: dictHeaders, successHandler:{(result) in
                    DispatchQueue.main.async()
                        {
                            
                            print("result:\(result)")
                            
                            let respVO:AgentBankVo = Mapper().map(JSONObject: result)!
                            
                            
                            let statusCode = respVO.IsSuccess
                            
                            print("StatusCode:\(String(describing: statusCode))")
                            
                            
                            if statusCode == true
                            {
                                
                                let successMsg = respVO.EndUserMessage
                                
                                
                                
                                Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Success".localize(), messege: successMsg!, clickAction: {
                                    
                                    let identityViewController = self.storyboard?.instantiateViewController(withIdentifier: "IdentityViewController") as! IdentityViewController
                                    
                                    identityViewController.fromBack = true
                                    
                                    self.navigationController?.pushViewController(identityViewController, animated: true)
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
                            
                            self.self.submitAPICall()
                            
                            
                        }, failureHandler: { (failureMassage) in
                            
                            Utilities.sharedInstance.goToLoginScreen()
                            
                        })
                        
                        
                        
                        
                    }
                    
                    
                })
                
            }
            else {
                
                Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(), messege: "app.Pleasecheckyourinternetconnection!".localize(), clickAction: {
                    
                    self.stopRefresher()
                })
                
            }
            
        }
        
    }

//MARK: - Button Actions
    
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
            
            break
        case 2:
            
            for moveToVC in viewControllers {
                if moveToVC is BankDetailsViewController {
                    _ = self.navigationController?.popToViewController(moveToVC, animated: true)
                }
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
                
                
                let IdentityViewController = self.storyboard?.instantiateViewController(withIdentifier: "IdentityViewController") as! IdentityViewController
                
                
                IdentityViewController.fromBack = true
                
                self.navigationController?.pushViewController(IdentityViewController, animated: true)
                
                
                
            }
            
            break
            
        case 4:
            
            for moveToVC in viewControllers {
                if moveToVC is AddDocumentViewController {
                    let vc = moveToVC as? AddDocumentViewController
                   // vc?.fromBack = true
                    _ = self.navigationController?.popToViewController(vc!, animated: true)
                }
            }
            break
            
        default: print("Other...")
        }
    }
    
    
    @IBAction func updateBtnClicked(_ sender: Any) {
        
        var validateSuccess = true
        
        if ((bankNameTF.text?.isEmpty)! || (branchNameTF.text?.isEmpty)! || (swiftCodeTF.text?.isEmpty)! || (accountHolderTF.text?.isEmpty)! || (accountNoTF.text?.isEmpty)!) {
            
            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(), messege: "app.Pleaseenterallfields".localize(), clickAction: {
                
            })
            
            validateSuccess = false
            return
            
        }
            
        else {
            
            if (accountHolderTF.text?.characters.count)! > 40 {
                
                Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(), messege: "app.AccountHolderNamecannotexceed40characters".localize(), clickAction: {
                    
                })
                validateSuccess = false
                return
            }
                
            else  if (accountNoTF.text?.characters.count)! > 40 {
                
                Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(), messege: "app.AccountNumbercannotexceed40characters".localize(), clickAction: {
                    
                })
                validateSuccess = false
                return
            }
            
            
            
        }
        
        
        if validateSuccess == true {
        
        updateBtnService()
            
        }
        
    }
    
//MARK: - Api call for update Bank details Service
    
    func updateBtnService(){
        
        if branchID != 0 {
            
        let accounthName:String = accountHolderTF.text!
        let accountNum:String = accountNoTF.text!
        
        let updateBankDict = [
            "AgentId": agentIdUpdate,
            "BankId": self.branchID,
            "AccountHolderName": accounthName,
            "AccountNumber": accountNum,
            "Id": idUpdate,
            "IsActive": true
            ] as [String:Any]
        
        
        let currentDate = GlobalSupportingClass.getCurrentDate()
        
        print("currentDate\(currentDate)")
        
        
        let dictHeaders = ["":"","":""] as NSDictionary
        
//        let dictHeaders = ["Authorization":UserDefaults.standard.value(forKey: KAccessToken) as! String,"TokenType":UserDefaults.standard.value(forKey: KTokenType) as! String] as NSDictionary
        
        print("dictHeader:\(dictHeaders)")
        
        let strUrl = UPDATEBANKINFO_API
            
        
        serviceController.requestPOSTURL(self, strURL: strUrl as NSString, postParams: updateBankDict as NSDictionary, postHeaders: dictHeaders, successHandler:{(result) in
            DispatchQueue.main.async()
                {
                    
                    print("result:\(result)")
                    
                    let respVO:UpdateAgentBankInfoVo = Mapper().map(JSONObject: result)!
                    
                    
                    let statusCode = respVO.IsSuccess
                    
                    print("StatusCode:\(String(describing: statusCode))")
                    
                    
                    if statusCode == true
                    {
                        
                        
                        let successMsg = respVO.EndUserMessage
                        
                        
                        Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Success".localize(), messege: successMsg!, clickAction: {
                            
                            
                            let IdentityViewController = self.storyboard?.instantiateViewController(withIdentifier: "IdentityViewController") as! IdentityViewController
                            
                            
                            IdentityViewController.fromBack = true
                            
                            self.navigationController?.pushViewController(IdentityViewController, animated: true)
                        })
                        
                        
                        
                        
                        
                    }
                    else if statusCode == false{
                        
                        let failMsg = respVO.EndUserMessage
                        
                        Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(), messege: failMsg!, clickAction: {
                            
                            
                        })
                        
                        
                        
                    }
                        
                    else
                    {
                        
                    Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(), messege: "app.ServiceError".localize(), clickAction: {
                            
                            
                        })
                    }
            }
        }, failureHandler: {(error) in
            
            if error == "unAuthorized" {
                
                self.serviceController.refreshTokenForLogin(self, successHandler: { (json) in
                    
                    self.self.updateBtnService()
                    
                    
                }, failureHandler: { (failureMassage) in
                    
                    Utilities.sharedInstance.goToLoginScreen()
                    
                })
                
                
                
                
            }
            
        })
        
        }
        
        else {
            
            
            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Alert".localize(), messege: "app.Pleaseselectbank".localize(), clickAction: {
                
                
            })
            
        }
    }
    
   
    @IBAction func homeClicked(_ sender: Any) {
        
        let homeNav : UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeNav") as! UINavigationController
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = homeNav
    }
    
    
    
}
