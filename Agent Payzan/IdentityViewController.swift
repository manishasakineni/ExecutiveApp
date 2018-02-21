//
//  IdentityViewController.swift
//  Agent Payzan
//
//  Created by CalibrageMac02 on 20/10/17.
//  Copyright © 2017 Naveen. All rights reserved.
//

import UIKit



class IdentityViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate

{
  

  //  let userId:String = UserDefaults.standard.string(forKey: AId)!

    @IBOutlet weak var personalLBL: UILabel!
    
   
    @IBOutlet weak var personalLblYAxis: NSLayoutConstraint!
    @IBOutlet weak var headerImgHeight: NSLayoutConstraint!
   
    @IBOutlet weak var headerImgVW: UIImageView!
    
    @IBOutlet weak var buttonsView: UIView!

    
    @IBOutlet weak var personalBtn: UIButton!
    
    @IBOutlet weak var bankBtn: UIButton!
    
    @IBOutlet weak var idProofsBtn: UIButton!
    
    @IBOutlet weak var documentsBtn: UIButton!
    
   
    @IBOutlet weak var idsTableView: UITableView!
    
    
    @IBOutlet weak var personalName: UITextField!
    
    @IBOutlet weak var personalNumber: UITextField!
    
    
    @IBOutlet weak var idScrollView: UIScrollView!
    
    
    @IBOutlet weak var personalAddBtn: UIButton!
    
    
    @IBOutlet weak var financialAddBtn: UIButton!
    @IBOutlet weak var idsView: UIView!
    
    @IBOutlet weak var financialName: UITextField!
    
    @IBOutlet weak var financialNumber: UITextField!
    
    @IBOutlet weak var personalNameHeight: NSLayoutConstraint!
    
    @IBOutlet weak var personalNumberHeight: NSLayoutConstraint!
    
    @IBOutlet weak var financialNameHeight: NSLayoutConstraint!
    
    @IBOutlet weak var financialNumberHeight: NSLayoutConstraint!
    
  //  @IBOutlet weak var nextBtnHeight: NSLayoutConstraint!
    
    @IBOutlet weak var updateBtn: UIButton!
    
    
    @IBOutlet weak var personalCancelBtn: UIButton!
    
    @IBOutlet weak var finCancelBtn: UIButton!
    
    var activeTextfield = UITextField()
    
    var serviceController = ServiceController()
    
    var personalIDSAry : Array<String> = Array()
    var personalIDNameArray = [ParametersAPIModel]()
    
    var financialIDSAry : Array<String> = Array()
    var financeIDNameArray = [ParametersAPIModel]()

    var IDProofNamesAry : Array<String> = Array()
    var IDProofNumberAry: Array<String> = Array()
    var IdProofTypeIDAry : Array<Int> = Array()
    var IdProofTypeIDArray : Array<Int> = Array()
    
    
   var compareIdProofTypeIDAry : Array<Int> = Array()
   var compareIdProofNumberAry: Array<String> = Array()
   var deleteidProofIDAry : Array<Int> = Array()

    var deleteidProofIDStr : Int = 0
    var pickerDataAry : Array<String> = Array()
    
    var selectedID = "app.SelectIDProof".localize()
    
    var IdProofTypeId : Int = 0
    var financeTypeId : Int = 0
    
    var clickedButtonTag : Int = 0
    
    var personalClassTypeIdAry : Array<Int> = Array()
    var financialClassTypeIdAry : Array<Int> = Array()
    
    var personalClassTypeId : Int = 0
    var financialClassTypeId : Int = 0
    
    
    var validatepersonalStr : String = ""
    var validatefinancialStr : String = ""
    
     var deleteID : Int = 0
    var createdByUpdate:String = ""
    
    let IDPickerView = UIPickerView()
    
    var userID : String = ""

    var paramsDict = [String:Any]()
    
    var idProofParmsDict = [String:Any]()
    
    var fromBack : Bool = false
    
    var agentIdd : String = ""
    var aspNetUserId : String = ""
    
    var personalIdNoStr:String = ""
    var financialIdNoStr:String = ""
    
    var refresher:UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                 
        self.idsTableView.isHidden = true
        self.idsTableView.delegate = self
        self.idsTableView.dataSource = self

        self.idScrollView.delegate = self
        
        personalAddBtn.layer.cornerRadius = 3
        financialAddBtn.layer.cornerRadius = 3
        personalCancelBtn.layer.cornerRadius = 3
        finCancelBtn.layer.cornerRadius = 3
        
        personalName.tag = 1
        financialName.tag = 2

        idsTableView.register(UINib.init(nibName: "IDProofsTableViewCell", bundle: nil),
                                 forCellReuseIdentifier: "IDProofsTableViewCell")
        
        let defaults = UserDefaults.standard
        
        if let userid = defaults.string(forKey: AId) {
            
            userID = userid
            
            print("defaults savedString: \(userID)")
        }
        
        
        if let agentId = defaults.string(forKey: "AgentId") {
            
            
            agentIdd = agentId
            
            print("defaults savedString: \(agentIdd)")
        }
        
        if let uniqueID = defaults.string(forKey: "AspNetUserId") {
            
            aspNetUserId = uniqueID
            
            print("defaults savedString: \(aspNetUserId)")
        }

        
        
        IDPickerView.delegate = self
        IDPickerView.dataSource = self
        
        personalName.delegate = self
        personalName.inputView = IDPickerView
        personalName.placeholder = selectedID
        financialName.delegate = self
        financialName.inputView = IDPickerView
        financialName.placeholder = selectedID
        personalNumber.delegate = self
        financialNumber.delegate = self
        
        self.idScrollView.delegate = self
        
        self.refresher = UIRefreshControl()
        
        self.refresher.tintColor = UIColor.white
        
        //  [self.scrollView insertSubview:refreshControl atIndex:0];
        self.refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
        self.idScrollView.insertSubview(self.refresher, at: 0)
        

        getpersonalIDNames()
        getfinancialNames()
        forIpodAndIphone()
       
    }
    
    func forIpodAndIphone(){
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
            
            
            self.headerImgVW.image =  UIImage(named: "1536X250.jpg")
            self.headerImgHeight.constant = 130
            
            personalNameHeight.constant    = 60
            personalNumberHeight.constant  = 60
            financialNameHeight.constant   = 60
            financialNumberHeight.constant = 60
            
        }
            
        else {
            
            self.headerImgVW.image =  UIImage(named: "384X100.jpg")
            self.headerImgHeight.constant = 80
            
            personalNameHeight.constant    = 50
            personalNumberHeight.constant  = 50
            financialNameHeight.constant   = 50
            financialNumberHeight.constant = 50
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if fromBack == true {
        
            self.personalBtn.isUserInteractionEnabled = true
            self.bankBtn.isUserInteractionEnabled = true
            self.idProofsBtn.isUserInteractionEnabled = false
            self.documentsBtn.isUserInteractionEnabled = true
            
            self.idsTableView.isHidden = false
            
            self.IDProofNumberAry.removeAll()
            self.IDProofNamesAry.removeAll()
            self.IdProofTypeIDAry.removeAll()
            
        getAllIDProofsApiCall()

    }
        else
        {
        getAllIDProofsApiCall()
        self.personalBtn.isUserInteractionEnabled = true
        self.bankBtn.isUserInteractionEnabled = true
        self.idProofsBtn.isUserInteractionEnabled = false
        self.documentsBtn.isUserInteractionEnabled = true
    
    }
        
        navigationItem.leftBarButtonItems = []
        navigationItem.hidesBackButton = true
        for subview in (self.navigationController?.navigationBar.subviews)! {
            
            subview.isHidden = true
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    func loadData() {
       
       // getAllIDProofsApiCall()
        
    }
    
    func stopRefresher() {
        self.refresher.endRefreshing()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        print("scrollViewDidScroll")
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView){
        
        getAllIDProofsApiCall()
        getpersonalIDNames()
        getfinancialNames()
        print("scrollViewWillBeginDragging")
        
        
    }
    
//MARK: - Button Actions
    
    @IBAction func backAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
  
    
    func getpersonalIDNames(){
        
        if(appDelegate.checkInternetConnectivity()){
        
      let classTypeID = "7"
    
    APIModel().getRequest(self, withUrl: PERSONALIDS_API + classTypeID, successBlock: { (json) in
        
        if (json.count > 0){
        
            
        let getPersonalIDNamesArray = ParsingModelClass.sharedInstance.getPersonalIDNameAPIModelParsing(object: json as AnyObject)
            
            if (getPersonalIDNamesArray.count > 0){
            
                self.personalIDNameArray = getPersonalIDNamesArray
                self.personalIDSAry.removeAll()
                for personalIDName in getPersonalIDNamesArray{
                    
                    self.personalIDSAry.append(personalIDName.descriptions)
                   // self.personalClassTypeIdAry.append(Int(personalIDName.classTypeId)!)
                    
                
                }
            
            }
        
        }
        
        

        
    }) { (failureMessage) in
//        
//        Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(), messege:failureMessage, clickAction: {
//            
//        })
        
        if failureMessage == "unAuthorized" {
            
            self.serviceController.refreshTokenForLogin(self, successHandler: { (json) in
                
                self.getpersonalIDNames()
                
                
            }, failureHandler: { (failureMassage) in
                
                Utilities.sharedInstance.goToLoginScreen()
                
            })
            
        }
        
        }
            
            self.stopRefresher()

    
    }
        
        else {
            
            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(), messege: "app.Pleasecheckyourinternetconnection!".localize(), clickAction: {
                
                self.stopRefresher()
            })
            
        }
        
        
    }
    
    func getfinancialNames(){
        
        if(appDelegate.checkInternetConnectivity()){
        
        let classTypeID = "8"
        
        APIModel().getRequest(self, withUrl: FINANCIALIDS_API + classTypeID, successBlock: { (json) in
            
            if (json.count > 0){
                
                
            
    let getFinancialIDNamesArray = ParsingModelClass.sharedInstance.getFinancialIDNameAPIModelParsing(object: json as AnyObject)
            
                if (getFinancialIDNamesArray.count > 0){
                    
                    self.financeIDNameArray = getFinancialIDNamesArray
                
                    self.financialIDSAry.removeAll()
                    for financialIDName in getFinancialIDNamesArray{
                    
                    self.financialIDSAry.append(financialIDName.descriptions)
                   
                    
                    }
                
                }
            
            }
            
            
        }) { (failureMessage) in
            
//            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(), messege:failureMessage, clickAction: {
//                
//            })
            
            if failureMessage == "unAuthorized" {
                
                self.serviceController.refreshTokenForLogin(self, successHandler: { (json) in
                    
                    self.getfinancialNames()
                    
                    
                }, failureHandler: { (failureMassage) in
                    
                    Utilities.sharedInstance.goToLoginScreen()
                    
                })
                
            }

        
        }
        
   self.stopRefresher()
    }
        
        else {
            
            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(), messege: "app.Pleasecheckyourinternetconnection!".localize(), clickAction: {
                
                self.stopRefresher()
            })
            
        }
        
        
    }
    
    func getAllIDProofsApiCall(){
    
       
        
        if(appDelegate.checkInternetConnectivity()){
            
            
            let strUrl = GETAGENTIDPROOFS_API + aspNetUserId

            
            serviceController.requestGETURL(self, strURL:strUrl, success:{(result) in
                DispatchQueue.main.async()
                    {
                        
                        let respVO : GetIdProofsVo = Mapper().map(JSONObject: result)!
                        
                        let isActive = respVO.IsSuccess
                                                
                        if(isActive == true){
                            
                            if !(respVO.ListResult?.isEmpty)! {
                                
                                let IDInfo = respVO.ListResult
                                self.documentsBtn.isUserInteractionEnabled = true
                                
                                let agentIDD = respVO.ListResult?[0].AgentId
                         
                                self.createdByUpdate = (respVO.ListResult?[0].CreatedBy)!
                                
                                
                                UserDefaults.standard.set(agentIDD, forKey: "AgentId")
                                
                                UserDefaults.standard.synchronize()
                                
                                self.deleteidProofIDAry.removeAll()
                                self.IDProofNumberAry.removeAll()
                                self.IDProofNamesAry.removeAll()
                                self.IdProofTypeIDAry.removeAll()
                                self.compareIdProofNumberAry.removeAll()
                                self.compareIdProofTypeIDAry.removeAll()
                                self.personalClassTypeIdAry.removeAll()
                                self.financialClassTypeIdAry.removeAll()
                                
                                for(_,element) in (IDInfo?.enumerated())! {
                                    
                                    self.IDProofNumberAry.append(element.IdProofNumber!)
                                    self.compareIdProofNumberAry.append(element.IdProofNumber!)
                                    self.IDProofNamesAry.append(element.IdProofType!)
                                    self.IdProofTypeIDAry.append(element.IdProofTypeId!)
                                    self.compareIdProofTypeIDAry.append(element.IdProofTypeId!)
                                    self.deleteidProofIDAry.append(element.Id!)
                                    self.personalClassTypeIdAry.append(element.IdProofTypeId!)
                                    self.financialClassTypeIdAry.append(element.IdProofTypeId!)
                                    
                                    
                                }
                                
                                self.idsTableView.reloadData()
                                
                                
                            }
                            else {
                                
                                self.documentsBtn.isUserInteractionEnabled = false
                            }
                            
                        } else if(isActive == false) {
                            
                            
                            
                        }
                }
                
            },
                                            
            failure:  {(error) in
                
                
                if error == "unAuthorized" {
                    
                    self.serviceController.refreshTokenForLogin(self, successHandler: { (json) in
                        
                        self.getAllIDProofsApiCall()
                        
                        
                    }, failureHandler: { (failureMassage) in
                        
                        Utilities.sharedInstance.goToLoginScreen()
                        
                    })
                    
                }

                                                
            })
            
            self.stopRefresher()
            
        }
        else {
            
            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(), messege: "app.Pleasecheckyourinternetconnection!".localize(), clickAction: {
                
                self.stopRefresher()
            })
            
        }
        
        
    }

//MARK: - UITextfield delegate methods
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == personalName {
          
            pickerDataAry = self.personalIDSAry
            activeTextfield = personalName
            self.pickUp(activeTextfield)
            IDPickerView.reloadAllComponents()
            IDPickerView.selectRow(0, inComponent: 0, animated: false)
        
        
        }
        
        else if textField == financialName {
        
            pickerDataAry = self.financialIDSAry
            activeTextfield = financialName
            self.pickUp(activeTextfield)
            IDPickerView.reloadAllComponents()
            IDPickerView.selectRow(0, inComponent: 0, animated: false)
        
        
        
        }
        
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        /// 1. replacementString is NOT empty means we are entering text or pasting text: perform the logic
        /// 2. replacementString is empty means we are deleting text: return true
        
        if textField == personalNumber{
            if string.characters.count > 0 {
                let allowedCharacters = CharacterSet.alphanumerics
                
                let unwantedStr = string.trimmingCharacters(in: allowedCharacters)
                return unwantedStr.characters.count == 0
            }
            
            return true
        }
        
        if textField == financialNumber {
            if string.characters.count > 0 {
                let allowedCharacters = CharacterSet.alphanumerics
                
                let unwantedStr = string.trimmingCharacters(in: allowedCharacters)
                return unwantedStr.characters.count == 0
            }
            
            return true
        }
        return true
    }
    
    func pickUp(_ textField : UITextField){
        
        textField.inputView = self.IDPickerView
        
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
        if textField.inputView == IDPickerView{
            textField.inputAccessoryView = toolBar
        }
    }
    
    func doneClick() {
    
        if activeTextfield.tag == 1 {
            
        if personalName.text == "" || personalName.text != "" {
            
            personalName.text = personalIDSAry[0]
            
            self.IDPickerView.endEditing(true)
            
            let personalStr : String = personalName.text!
            
            let alertMsg : String = "Already " + personalStr + " Added"
            
            if personalIDNameArray.count > 0{
                if let value = Int(personalIDNameArray[0].id){
                    
                    IdProofTypeId = value
                    
                    if(IDProofNamesAry.contains(personalStr)){
                        
                        self.personalName.text = ""
                        self.personalName.resignFirstResponder()
                       // self.IDPickerView.endEditing(true)
                        
                        Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Alert".localize(), messege: alertMsg.localize() , clickAction: {
                        })
                        
                    }else{
                        
                        IdProofTypeIDAry.append(IdProofTypeId)
                        
                        personalClassTypeIdAry.append(IdProofTypeId)
                        
                        self.personalNumber.text = ""
                        
                    }
                    
                }
            }
            
            self.view.endEditing(true)
            
        }
        }
        
        if activeTextfield.tag == 2 {
            
        if financialName.text == "" || financialName.text != ""{
            
                
                financialName.text = financialIDSAry[0]
            
            self.IDPickerView.endEditing(true)
            
            let financialStr : String = financialName.text!
            
            let alertMsg : String = "Already " + financialStr + " Added"
            
            if financeIDNameArray.count > 0{
                if let value = Int(financeIDNameArray[0].id){
                    
                    financeTypeId = value
                    
                    
                    if IDProofNamesAry.contains(financialStr){
                        
                        self.financialName.text = ""
                        self.financialName.resignFirstResponder()
                        
                        Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Alert".localize(), messege: alertMsg.localize() , clickAction: {
                         })
                    }
                        
                    else{
                        
                        IdProofTypeIDAry.append(financeTypeId)
                        
                        financialClassTypeIdAry.append(financeTypeId)
                        
                        self.financialNumber.text = ""
                        
                    }
                    
                }
            }
            
            
            self.view.endEditing(true)


            
            
        }
        }
        
        activeTextfield.resignFirstResponder()
    
    }
    
    
    func cancelClick() {
    
     activeTextfield.resignFirstResponder()
    }
    
//MARK: - Pickerview Delegate methods 
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return pickerDataAry.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return pickerDataAry[row]
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if activeTextfield == personalName {
            
        personalName.text = pickerDataAry[row]
            self.IDPickerView.endEditing(true)
            
            let personalStr : String = personalName.text!

            let alertMsg : String = "Already " + personalStr + " Added"
            
            if personalIDNameArray.count > row{
                if let value = Int(personalIDNameArray[row].id){
                    
                    IdProofTypeId = value
                    
                    if(IDProofNamesAry.contains(personalStr)){
                        
                        self.personalName.text = ""
                        self.personalName.resignFirstResponder()
                        
                        Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Alert".localize(), messege: alertMsg.localize() , clickAction: {
                         })
                        
                    }else{
                        
                        IdProofTypeIDAry.append(IdProofTypeId)
                        
                        personalClassTypeIdAry.append(IdProofTypeId)
                        
                        self.personalNumber.text = ""
                        
                    }

                }
            }

            self.view.endEditing(true)
        
        }
        
        else if activeTextfield == financialName {
        financialName.text = pickerDataAry[row]
            
        self.IDPickerView.endEditing(true)
            
            let financialStr : String = financialName.text!
            
            let alertMsg : String = "Already " + financialStr + " Added"
            
            if financeIDNameArray.count > row{
                if let value = Int(financeIDNameArray[row].id){
                    
                    financeTypeId = value

                    
                    if IDProofNamesAry.contains(financialStr){
                        
                        self.financialName.text = ""
                        self.financialName.resignFirstResponder()
                        
                        Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Alert".localize(), messege: alertMsg.localize() , clickAction: {
                         })
                    }
                    
                    else{
                    
                    IdProofTypeIDAry.append(financeTypeId)
                        
                    financialClassTypeIdAry.append(financeTypeId)
                        
                        self.financialNumber.text = ""
                        
                    }
                    
                }
            }
            

        self.view.endEditing(true)
        
        }
        
    }
    
//MARK: - UItable view delegate methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if IDProofNumberAry.count > 0{
        
        return IDProofNumberAry.count
        }
        
        else{
        return 0
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "IDProofsTableViewCell") as! IDProofsTableViewCell
        
        if IDProofNumberAry.count > indexPath.row{
        
           cell.idNameLbl.text = IDProofNamesAry[indexPath.row]
           cell.idNumberLbl.text = IDProofNumberAry[indexPath.row]

            
           cell.deleteBtn?.layer.setValue(indexPath.row, forKey: "index")
           cell.deleteBtn.tag = indexPath.row
            
            cell.deleteBtn.addTarget(self, action: #selector(deleteBtnClicked), for: .touchUpInside)
        }

        
        return cell
        
    }
    
    func deleteBtnClicked(sender:UIButton){
        
        let indexPath : IndexPath = IndexPath(row: sender.tag, section: 0)
        
        
        if let _ : IDProofsTableViewCell = idsTableView.cellForRow(at: indexPath) as? IDProofsTableViewCell {
            
            
             deleteidProofIDStr = deleteidProofIDAry[indexPath.row]
            
            let i : Int = (sender.layer.value(forKey: "index")) as! Int
            
            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "app.Alert".localize(), messege: "app.AreyousurewanttodeletethisIdentityproof?".localize()) {
                
                self.deleteIdProofApiCall(deleteidProofID: self.deleteidProofIDStr)
                
                self.IDProofNamesAry.remove(at: i)
                self.IDProofNumberAry.remove(at: i)
                self.IdProofTypeIDAry.remove(at: i)
                self.deleteidProofIDAry.remove(at: i)

                
                self.idsTableView.reloadData()
                
            }

            
        }

    }
    
    func deleteIdProofApiCall(deleteidProofID : Int) {
        
        
        let strUrl = DELETEIDPROOF_API + String(deleteidProofID)
        
        serviceController.requestDELETEURL(self, strURL:strUrl, success:{(result) in
            DispatchQueue.main.async()
                {
                    
                    let respVO : DeleteIdProofVo = Mapper().map(JSONObject: result)!
                    
                    
                    
                    let isActive = respVO.IsSuccess
                    
                    if(isActive == true){

                        let successMsg = respVO.EndUserMessage
                        
                        
                        Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Success".localize(), messege: successMsg!, clickAction: {
                            
                            
                        })
                        
                        
                        
                    }
                        
                     else if(isActive == false) {
                        
                        let failureMsg = respVO.EndUserMessage
                        
                        
                        Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Success".localize(), messege: failureMsg!, clickAction: {
                            
                            
                        })
                    }
            }
            
        },
            failure:  {(error) in
                                            
        })

        
    }
    
//MARK: - textfield validations 
    
    func financialValidateAllFields() -> Bool
    {
        
        
        var errorMessage:NSString?
        
        let fName:NSString = financialName.text! as NSString
        let fNumber:NSString = financialNumber.text! as NSString
        
        
       
            
       if (fName.length <= 0){
            
            errorMessage=GlobalSupportingClass.financialTypeErrorMessage() as String as String as NSString?
            
        }
        else if (fNumber.length <= 0) {
            
            
            errorMessage=GlobalSupportingClass.financialnumberErrorMessage() as String as String as NSString?
        }
        
        if let errorMsg = errorMessage{
            
            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Alert".localize(), messege: errorMsg as String, clickAction: {})
            
            return false;
        }
        return true
    }
    
    func personalValidateAllFields() -> Bool
    {
        
        
        var errorMessage:NSString?
        
        let pName : NSString = personalName.text! as NSString
        let pNumber:NSString = personalNumber.text! as NSString
        
        if (pName.length <= 0){
            
            errorMessage=GlobalSupportingClass.personalTypeErrorMessage() as String as String as NSString?
            
        }
            
        else if (pNumber.length <= 0){
            
            errorMessage=GlobalSupportingClass.personalnumberErrorMessage() as String as String as NSString?
            
        }
        
        
        if let errorMsg = errorMessage{
            
            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Alert".localize(), messege: errorMsg as String, clickAction: {})
            
            return false;
        }
        return true
    }
    
    @IBAction func nextAction(_ sender: UIButton) {
        
        idsTableView.reloadData()
        
        
        var bb : [String] = []
        
        var cc : [String] = []
        
        
        for pp in personalIDSAry{
        
           
            bb.append(pp)

            
        }
        
        
        for ff in financialIDSAry{
            
            cc.append(ff)

            
        }
        
        
        if !bb.contains(array: IDProofNamesAry) && !cc.contains(array: IDProofNamesAry) {

        
            let documentViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddDocumentViewController") as! AddDocumentViewController
                documentViewController.fromBack = true
            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Success".localize(), messege: "app.idproofsaddedsuccesfully".localize(), clickAction: {
            
            self.navigationController?.pushViewController(documentViewController, animated: true)

            })
            
            }
    
        
            if  bb.contains(array: IDProofNamesAry) && cc.contains(array: IDProofNamesAry) {
                
                Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(), messege: "app.Pleaseaddidentityproofs".localize(), clickAction: {
                    
                    
                })
                
            }
                
                
                else {
                    
                    if !bb.contains(array: IDProofNamesAry) {
                        
                        Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(), messege: GlobalSupportingClass.personalTypeErrorMessage(), clickAction: {
                            
                            
                        })
                        
                    }
                    
                    if !cc.contains(array: IDProofNamesAry) {
                        
                        Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(), messege: GlobalSupportingClass.financialTypeErrorMessage(), clickAction: {
                            
                            
                        })
                        
                    }
                    
                }
                
        
        
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
        
        let isFromBack = false
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        
        switch sender.tag
        {
        case 1:
            
            for moveToVC in viewControllers {
                if moveToVC is NewAgentRegistrationViewController {
                    
                    let vc = moveToVC as? NewAgentRegistrationViewController
                    vc?.fromBack = true
                    vc?.newVC1 = 1
                    _ = self.navigationController?.popToViewController(vc!, animated: true)
                }
            }
            
            break
        case 2:
            
            for moveToVC in viewControllers {
                if moveToVC is BankDetailsViewController {
                    let vc = moveToVC as? BankDetailsViewController
                    vc?.fromBack = true
                  //  _ = self.navigationController?.popToViewController(vc!, animated: true)
                }
            }
            
            if(isFromBack == false){
                
                let BankDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "BankDetailsVC") as! BankDetailsViewController
                
              //  self.navigationController?.pushViewController(BankDetailsVC, animated: true)
                
                self.navigationController?.popViewController(animated: true)
                
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
         
            break
            
        case 4:
            
            for moveToVC in viewControllers {
                if moveToVC is AddDocumentViewController {
                    let vc = moveToVC as? AddDocumentViewController
                    vc?.fromBack = true
                    _ = self.navigationController?.popToViewController(vc!, animated: true)
                }
            }
            
            if(isFromBack == false){
                
                var bb : [String] = []
                
                var cc : [String] = []
                
                for pp in personalIDSAry{
                    
                    bb.append(pp)
                    
                }
                
                for ff in financialIDSAry{
                    
                    cc.append(ff)
                    
                }
                
                
                if !bb.contains(array: IDProofNamesAry) && !cc.contains(array: IDProofNamesAry) {
                
                let addDocumentViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddDocumentViewController") as! AddDocumentViewController
                
                addDocumentViewController.fromBack = true
                
                self.navigationController?.pushViewController(addDocumentViewController, animated: true)
                    
                }
            }
            
            break
            
        default: print("Other...")
        }
        
 
        
        
        
    }
    
   
    @IBAction func personalAddClicked(_ sender: UIButton) {
        
        clickedButtonTag = sender.tag
        
       if personalValidateAllFields(){
        
        
        personalNumber.resignFirstResponder()
        validatepersonalStr = ""
        validatepersonalStr = personalName.text!
        
   //     self.personalBtn.tag = 1
        
        
     //   print(self.IDProofNumberAry)
        
        personalIdNoStr = personalNumber.text!
        
        
        
        personalIdentityProofService(typeId: IdProofTypeId, typeNumber: personalIdNoStr)
        
       
        
        
        }

    }
    
  
    @IBAction func personalCancelClicked(_ sender: Any) {
        
        personalName.text = ""
        personalNumber.text = ""
        
    }

    @IBAction func financialCancelClicked(_ sender: Any) {
        
        financialName.text = ""
        financialNumber.text = ""
    }
    
    @IBAction func financialAddClicked(_ sender: UIButton) {
        
       clickedButtonTag = sender.tag
        
        if financialValidateAllFields(){
            
        financialNumber.resignFirstResponder()
        validatefinancialStr = ""
        validatefinancialStr  = financialName.text!
       
      
            
        financialIdNoStr = financialNumber.text!
            
        personalIdentityProofService(typeId: financeTypeId, typeNumber: financialIdNoStr)

        
        print(self.IDProofNumberAry)
            
       //  idsTableView.reloadData()
        
       
        
        }
    }
    
    func personalIdentityProofService(typeId:Int!, typeNumber:String!) {
        
        if(appDelegate.checkInternetConnectivity()){
            
         
            
            let idProofDict1 = [
                
                "IdProofTypeId": typeId,
                "IdProofNumber": typeNumber
                
                ] as [String:Any]

            
            
            var idProofIdArray  = Array<[String:Any]>()
            idProofIdArray.append(idProofDict1)
            
            
            idProofParmsDict.updateValue(idProofIdArray, forKey: "IdProofs")
            idProofParmsDict.updateValue(aspNetUserId, forKey: "AgentId")

            
            
            let dictHeaders = ["":"","":""] as NSDictionary
            
            
            print(idProofParmsDict)
            
            let strUrl = ADDIDPROOFS_API
            
            serviceController.requestPOSTURL(self, strURL: strUrl as NSString, postParams: idProofParmsDict as NSDictionary, postHeaders: dictHeaders, successHandler:{(result) in
                DispatchQueue.main.async()
                    {
                        
                        print("result:\(result)")
                        
                        let respVO:AgentIdProofVo = Mapper().map(JSONObject: result)!
                        
                        
                        let statusCode = respVO.IsSuccess
                        
                        print("StatusCode:\(String(describing: statusCode))")
                        
                        
                        if statusCode == true
                        {
                            
                            let successMsg = respVO.EndUserMessage
                            
                            if self.clickedButtonTag == 1 {
                            
                            self.IDProofNamesAry.append(self.personalName.text!)
                            self.IDProofNumberAry.append(self.personalNumber.text!)
                            self.compareIdProofNumberAry.append(self.personalNumber.text!)
                                
                                self.idsTableView.reloadData()
                                
                                self.personalName.text = ""
                                self.personalNumber.text = ""
                            }
                            
                            if self.clickedButtonTag == 2 {
                                
                            self.IDProofNamesAry.append(self.financialName.text!)
                            self.IDProofNumberAry.append(self.financialNumber.text!)
                            self.compareIdProofNumberAry.append(self.financialNumber.text!)
                                
                                self.idsTableView.reloadData()
                                
                                self.financialName.text = ""
                                self.financialNumber.text = ""
                            }
                            
                           
                            
                            let fff = respVO.ListResult
                            
                            //    self.deleteID = (respVO.ListResult?[0].Id)!
                            
                            self.deleteidProofIDAry.removeAll()
                            
                            for(_,element) in (fff?.enumerated())! {
                                
                               // self.IDProofNamesAry.append(element)
                                self.deleteidProofIDAry.append(element.Id!)
                                
                            
                            }
                            
                            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Success".localize(), messege: successMsg!, clickAction: {
                                
                                
                            })
                         
                        }
                        else if statusCode == false{
                            
                            let failMsg = respVO.EndUserMessage
                            
                            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(), messege: failMsg!, clickAction: {
                                
                                
                            })
                         
                        }
                            
                        else
                        {
                            
                            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(), messege: "app.Server Error".localize(), clickAction: {
                                
                                
                            })
                        }
                }
            }, failureHandler: {(error) in
            })
            
        }
        else {
            
            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(), messege: "app.Pleasecheckyourinternetconnection!".localize(), clickAction: {
                
                
            })
            
        }

    }
 
    
    @IBAction func updateBtnClicked(_ sender: Any) {
        
   
        
    }
    
    @IBAction func homeClicked(_ sender: Any) {
        
        let homeNav : UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeNav") as! UINavigationController
      
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = homeNav
        
        
    }
    
}
extension Array where Element: Comparable {
    
    func containsSameElements(as other: [Element]) -> Bool {
        
        return self.count == other.count && self.sorted() == other.sorted()
    }
    
    func contains(array: [Element]) -> Bool {
        for item in array {
            
            if !self.contains(item) { return false }
        }
        return true
    }
}

