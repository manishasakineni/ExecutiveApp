//
//  AddNewAddressViewController.swift
//  YISCustomerApp
//
//  Created by Calibrage Mac on 18/09/17.
//  Copyright © 2017 Calibrage Mac. All rights reserved.
//

import UIKit



class AddNewAddressViewController: UIViewController  {
    
    /*
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var viewHeightConst: NSLayoutConstraint!
    @IBOutlet weak var tableViewTop: NSLayoutConstraint!
    @IBOutlet weak var tableview: TPKeyboardAvoidingTableView!
    var customerAddressDetails     : Array<CustomerLookUpAddressModel> = Array()
    var stateModelArray     : Array<StatesModel> = Array()
    var countryModelArray     : Array<CountryModel> = Array()
    var shipViaModel     : Array<ShipViaTypeModel> = Array()
    var addressTypeModelArray     : Array<AddressTypeModel> = Array()
    var statesArray = Array<String>()
    var countryArray = Array<String>()
    var shipViaArray = Array<String>()
    var addressTypeArray = Array<String>()
    var myPickerView: UIPickerView!
    var pickerData = Array<String>()
    var addressDescription = ""
    var addressType = ""
    var shipperType = ""
    var params = Dictionary<String, Any>()
    var customerId : String?
    var customerName : String?
    var phoneNumber = ""
    var activeTextField : UITextField!
    var selectedData = ""
    var titleText: String?
    var isResidentialAdd = ""
    var isFromCustomerAddress = false
    var isEditingShipperType = false
    var isLoadFirstTime = false
    var isFromNewCustomer = false
    var newOrderNumber : Int = 0
    var newOrderSequenceNumber : Int = 0
    var isServerSuccess = false
    var isFromBillingAddress = false
    var customerViewOrderItemsDetails     : Array<CustomerViewOrderDetailInfoModel> = Array()
    lazy var searchBar = UISearchBar(frame: CGRect.zero)
    var isResidentialAddress = false
    
    @IBOutlet weak var bottomViewConstriant: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewCells()
        readDataSources()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
          Utilities.setupNavBarWithSearch(backImage: "Back", cntr: self, searchBar: searchBar, backTitle: " ", rightImage: "",hideSearchPlaceHolder :"true",secondShowRightImage: "true", secondRightImage: "", navTitle : titleText!)

        registerForKeyboardNotifications()
        
    }
    
    private func focusDropDownTextField() {
        
        let indexPath = IndexPath.init(row: 0, section: 0)
        
        if let dropDownTableViewCell = tableview.cellForRow(at: indexPath) as? DropDownTableViewCell {
            
            dropDownTableViewCell.typeTextField.becomeFirstResponder()
            
        }
    }
    private func focusContactNameTextField() {
        
        let indexPath = IndexPath.init(row: 1, section: 0)
        
        if let addressTableViewCell = tableview.cellForRow(at: indexPath) as? AddressTableViewCell {
            
            addressTableViewCell.descriptionTF.becomeFirstResponder()
            
        }
    }
    
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        
        let poppedVC = navigationController?.popViewController(animated: true)
        print(poppedVC as Any)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        deregisterFromKeyboardNotifications()
    }
    
    private func registerTableViewCells() {
        
        tableview.register(UINib.init(nibName: kAddressTableViewCell, bundle: nil),
                           forCellReuseIdentifier: kAddressTableViewCell)
        tableview.register(UINib.init(nibName: kStateCountryTableViewCell, bundle: nil),
                           forCellReuseIdentifier: kStateCountryTableViewCell)
        tableview.register(UINib.init(nibName: kDropDownTableViewCell, bundle: nil),
                           forCellReuseIdentifier: kDropDownTableViewCell)
        tableview.register(UINib.init(nibName: kChekmarkTableViewCell, bundle: nil),
                           forCellReuseIdentifier: kChekmarkTableViewCell)
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if(isFromBillingAddress == true){
            return 9
        }else{
            return 12
        }
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(isFromBillingAddress == false){
            if(indexPath.row == 11){
                let chekmarkTableViewCell = tableView.dequeueReusableCell(withIdentifier: kChekmarkTableViewCell,
                                                                          for: indexPath) as! ChekmarkTableViewCell
                chekmarkTableViewCell.checkButton.setImage( isResidentialAddress == true ? UIImage(named:"CheckBox_Selected") : UIImage(named:"CheckBox_Unselected"), for: UIControlState())
                chekmarkTableViewCell.checkButton.addTarget(self, action: #selector(BillingAddressViewController.checkMarkClicked), for: .touchUpInside)
                return chekmarkTableViewCell
            }
        }
        
        
        if(indexPath.row == 0 || indexPath.row == 10){
            
            let dropDownTableViewCell = tableView.dequeueReusableCell(withIdentifier: kDropDownTableViewCell,
                                                                      for: indexPath) as! DropDownTableViewCell
            dropDownTableViewCell.typeTextField.rightViewMode = UITextFieldViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            let image = UIImage(named: "Drop_Down")
            imageView.image = image
            
            if(indexPath.row == 0){
                dropDownTableViewCell.typeTextField.text = params["addressType"] as! String?
                dropDownTableViewCell.typeTextField.tag = indexPath.row
                if(isFromCustomerAddress == true){
                    dropDownTableViewCell.typeTextField.isEnabled = true
                }else{
                    dropDownTableViewCell.typeTextField.isEnabled = false
                }
                dropDownTableViewCell.titleLabel.text = "Address Type"
                dropDownTableViewCell.typeTextField.delegate = self
                dropDownTableViewCell.typeTextField.rightView = imageView
            }
            else{
                dropDownTableViewCell.typeTextField.text = params["shipperType"] as! String?
                dropDownTableViewCell.typeTextField.delegate = self
                dropDownTableViewCell.typeTextField.isEnabled = true
                dropDownTableViewCell.typeTextField.tag = indexPath.row
                dropDownTableViewCell.titleLabel.text = "Shipper Type"
                dropDownTableViewCell.typeTextField.rightView = imageView
            }
            
            return dropDownTableViewCell
            
        }else if(indexPath.row == 6) {
            let stateCountryTableViewCell = tableView.dequeueReusableCell(withIdentifier: kStateCountryTableViewCell,
                                                                          for: indexPath) as! StateCountryTableViewCell
            stateCountryTableViewCell.StateLabel.numberOfLines = 2
            stateCountryTableViewCell.countryLabel.numberOfLines = 2
            stateCountryTableViewCell.StateLabel.text = params["state"] as! String?
            stateCountryTableViewCell.countryLabel.text = params["country"] as! String?
            stateCountryTableViewCell.stateTF.tag = 2324
            stateCountryTableViewCell.countryTF.tag = 2325
            //stateCountryTableViewCell.zipTF.text = params["zipCode"] as! String?
            stateCountryTableViewCell.stateTF.delegate = self
            stateCountryTableViewCell.countryTF.delegate = self
            stateCountryTableViewCell.zipTF.delegate = self
            
            stateCountryTableViewCell.stateTF.rightViewMode = UITextFieldViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            let image = UIImage(named: "Drop_Down")
            imageView.image = image
            stateCountryTableViewCell.stateTF.rightView = imageView
            
            stateCountryTableViewCell.countryTF.rightViewMode = UITextFieldViewMode.always
            let imageView1 = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            let image1 = UIImage(named: "Drop_Down")
            imageView1.image = image1
            stateCountryTableViewCell.countryTF.rightView = imageView1
            
            stateCountryTableViewCell.zipTF.presentInView = self.view
            stateCountryTableViewCell.zipTF.tag = 2328
            
            stateCountryTableViewCell.configureCell((params["zipCode"] as! String?)!)
            
            return stateCountryTableViewCell
            
        }
        else{
            let addressTableViewCell = tableView.dequeueReusableCell(withIdentifier: kAddressTableViewCell,
                                                                     for: indexPath) as! AddressTableViewCell
            addressTableViewCell.configureAddressCell(indexPath, addressDetails: params ,phone : phoneNumber)
            addressTableViewCell.descriptionTF.tag = indexPath.row
            addressTableViewCell.descriptionTF.delegate = self
            
            if(indexPath.row == 9 || indexPath.row == 4){
                addressTableViewCell.descriptionTF.presentInView = nil
                addressTableViewCell.descriptionTF.isMandatory = false
            }else{
                addressTableViewCell.descriptionTF.presentInView = self.view
                addressTableViewCell.descriptionTF.isMandatory = true
            }
            
            
            return addressTableViewCell
        }
        
     
        
    }
    
    func checkMarkClicked(_ sender: UIButton){
        
        isResidentialAddress = !isResidentialAddress
        
        params.updateValue(isResidentialAddress == true ? 1 : 0, forKey: "residentialAdd")
        
        let indexPath : IndexPath = IndexPath(row: 11, section: 0)
        tableview.reloadRows(at: [indexPath], with: .none)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(indexPath.row == 6){
            return 70
        }
        return 60
        
    }
    
    
    
    func pickUp(_ textField : UITextField){
        
        // UIPickerView
        if(self.myPickerView == nil){
            self.myPickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        }
        self.myPickerView.delegate = self
        self.myPickerView.dataSource = self
        self.myPickerView.backgroundColor = UIColor.white
        self.myPickerView.tag = textField.tag
        textField.inputView = self.myPickerView
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(AddNewAddressViewController.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(AddNewAddressViewController.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    
    //MARK:- Button
    func doneClick() {
        let tag = activeTextField.tag
        
        
        switch tag {
        case 0:
            if(selectedData == ""){
                selectedData = "Billing Address"
            }
            params["addressType"] = selectedData
            let selectedAddressType = selectedData
            for addressTyp in addressTypeModelArray{
                if(addressTyp.Description == selectedAddressType){
                    addressType = addressTyp.addressType
                    break
                }
            }
            
            
            break
        case 10:
            if(selectedData == ""){
                selectedData = "Select"
            }
            params["shipperType"] = selectedData
            
            let selectedshipType = selectedData
            for shipTyp in shipViaModel{
                if(shipTyp.Description == selectedshipType){
                    shipperType = shipTyp.shipVia
                    break
                }
            }
            break
        case 2324:
            if(selectedData == ""){
                selectedData = "Select"
            }
            params["state"] = selectedData
            break
        case 2325:
            if(selectedData == ""){
                selectedData = "USA"
            }
            params["country"] = selectedData
            break
        default:
            break
        }
        tableview.reloadData()
        self.tableview.endEditing(true)
    }
    func cancelClick() {
        tableview.reloadData()
        self.tableview.endEditing(true)
    }
    
    //MARK: - UIPickerView Delegate Methods
    
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
        selectedData = pickerData[row]
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UIText Field Delegate Methods
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        
        
        if let addressTableviewCell : AddressTableViewCell = textField.superview?.superview as? AddressTableViewCell {
            addressTableviewCell.titleLabel.textColor = UI_ELEMENTS_COLOR
            
            if(textField.tag == 7){
                addressTableviewCell.descriptionTF.keyboardType = .phonePad
            }
            else if(textField.tag == 8){
                addressTableviewCell.descriptionTF.keyboardType = .emailAddress
            }else
            {
                addressTableviewCell.descriptionTF.keyboardType = .default
            }
            
            
        }
        else if let stateCountryTableViewCell : StateCountryTableViewCell = textField.superview?.superview as? StateCountryTableViewCell {
            stateCountryTableViewCell.zipTitle.textColor = UI_ELEMENTS_COLOR
            stateCountryTableViewCell.zipTF.keyboardType = .default
         
            
        }
        else if let dropDownTableViewCell : DropDownTableViewCell = textField.superview?.superview as? DropDownTableViewCell {
            dropDownTableViewCell.titleLabel.textColor = UI_ELEMENTS_COLOR
            
            
        }
        //
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let addressTableviewCell : AddressTableViewCell = textField.superview?.superview as? AddressTableViewCell {
            
            addressTableviewCell.titleLabel.textColor = UIColor.darkGray
            
            if textField.tag == 1 {
                
                if textField.text != "" {
                    
                    addressTableviewCell.titleLabel.isHidden = false
                    params["contactName"] = textField.text
                    
                } else {
                    params["contactName"] = ""
                    addressTableviewCell.titleLabel.isHidden = true
                }
            }
            else if textField.tag == 2 {
                
                if textField.text != "" {
                    
                    addressTableviewCell.titleLabel.isHidden = false
                    params["customerName"] = textField.text
                    
                } else {
                    params["customerName"] = ""
                    addressTableviewCell.titleLabel.isHidden = true
                }
            }
            else if textField.tag == 3 {
                
                if textField.text != "" {
                    
                    addressTableviewCell.titleLabel.isHidden = false
                    params["address1"] = textField.text
                    
                } else {
                    params["address1"] = ""
                    addressTableviewCell.titleLabel.isHidden = true
                }
            }
            else if textField.tag == 4 {
                
                if textField.text != "" {
                    
                    addressTableviewCell.titleLabel.isHidden = false
                    params["address2"] = textField.text
                    
                } else {
                    params["address2"] = ""
                    addressTableviewCell.titleLabel.isHidden = true
                }
            }
            else if textField.tag == 5 {
                
                if textField.text != "" {
                    
                    addressTableviewCell.titleLabel.isHidden = false
                    params["city"] = textField.text
                    
                } else {
                    params["city"] = ""
                    addressTableviewCell.titleLabel.isHidden = true
                }
            }
            else if textField.tag == 7 {
                
                if textField.text != "" {
                    
                    addressTableviewCell.titleLabel.isHidden = false
                    phoneNumber = (textField.text?.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())!
                    params["phoneNumber"] = phoneNumber
                    
                } else {
                    params["phoneNumber"] = ""
                    addressTableviewCell.titleLabel.isHidden = true
                }
            }
            else if textField.tag == 8 {
                
                if textField.text != "" {
                    
                    addressTableviewCell.titleLabel.isHidden = false
                    params["eMail"] = textField.text
                    
                } else {
                    params["eMail"] = ""
                    addressTableviewCell.titleLabel.isHidden = true
                }
            }
            else if textField.tag == 9 {
                
                if textField.text != "" {
                    
                    addressTableviewCell.titleLabel.isHidden = false
                    params["shipperNumber"] = textField.text
                    
                } else {
                    params["shipperNumber"] = ""
                    addressTableviewCell.titleLabel.isHidden = true
                }
            }
            
            
        }
        else if let stateCountryTableViewCell : StateCountryTableViewCell = textField.superview?.superview as? StateCountryTableViewCell {
            
            stateCountryTableViewCell.zipTitle.textColor = UIColor.darkGray
            stateCountryTableViewCell.StateLabel.isHidden = false
            stateCountryTableViewCell.countryLabel.isHidden = false
            
            
            if textField.tag == 2328 {
                
                
                if textField.text != "" {
                    
                    stateCountryTableViewCell.zipTitle.isHidden = false
                    params["zipCode"] = textField.text
                    
                } else {
                    params["zipCode"] = ""
                    stateCountryTableViewCell.zipTitle.isHidden = true
                }
                
            }
            
        }
        else if let dropDownTableViewCell : DropDownTableViewCell = textField.superview?.superview as? DropDownTableViewCell {
            dropDownTableViewCell.titleLabel.textColor = UIColor.darkGray
            if textField.text != "" {
                
                dropDownTableViewCell.titleLabel.isHidden = false
                
                
            } else {
                
                dropDownTableViewCell.titleLabel.isHidden = true
            }
        }
        
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        activeTextField = textField
        if let  _ : DropDownTableViewCell = textField.superview?.superview as? DropDownTableViewCell {
            selectedData = ""
            if(textField.tag == 0){
                self.pickUp(textField)
                pickerData = addressTypeArray
                selectedData = ""
                myPickerView.reloadAllComponents()
                myPickerView.selectRow(0, inComponent: 0, animated: false)
                
            }
            else if(textField.tag == 10){
                self.pickUp(textField)
                pickerData = shipViaArray
                selectedData = ""
                myPickerView.reloadAllComponents()
                myPickerView.selectRow(0, inComponent: 0, animated: false)
                
            }
            
        }
        else if let stateCountryTableViewCell : StateCountryTableViewCell = textField.superview?.superview as? StateCountryTableViewCell {
            
     
            if(textField.tag == 2324){
                stateCountryTableViewCell.StateLabel.isHidden = true
                self.pickUp(textField)
                pickerData = statesArray
                selectedData = ""
                myPickerView.reloadAllComponents()
                myPickerView.selectRow(0, inComponent: 0, animated: false)
                
                
            }else if(textField.tag == 2325){
                stateCountryTableViewCell.countryLabel.isHidden = true
                self.pickUp(textField)
                pickerData = countryArray
                selectedData = ""
                myPickerView.reloadAllComponents()
                myPickerView.selectRow(0, inComponent: 0, animated: false)
                
                
            }
            
        }
        
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        if let disableEmojis = textField.disableEmojis() {
            
            return disableEmojis
        }
        
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if let addressTableviewCell : AddressTableViewCell = textField.superview?.superview as? AddressTableViewCell {
            
            if(textField.tag == 1){
                
                addressTableviewCell.titleLabel.text = "Contact Name"
                
                if newString.isEmpty {
                    
                    addressTableviewCell.titleLabel.isHidden = true
                    return true
                    
                } else {
                    
                    addressTableviewCell.titleLabel.isHidden = false
                    addressTableviewCell.titleLabel.textColor = UI_ELEMENTS_COLOR
                }
            }
                
            else if(textField.tag == 2){
                
                addressTableviewCell.titleLabel.text = "Company"
                
                if newString.isEmpty {
                    
                    addressTableviewCell.titleLabel.isHidden = true
                    return true
                    
                } else {
                    
                    addressTableviewCell.titleLabel.isHidden = false
                    addressTableviewCell.titleLabel.textColor = UI_ELEMENTS_COLOR
                }
            }
                
            else if(textField.tag == 3){
                
                addressTableviewCell.titleLabel.text = "Address1"
                
                if newString.isEmpty {
                    
                    addressTableviewCell.titleLabel.isHidden = true
                    return true
                    
                } else {
                    
                    addressTableviewCell.titleLabel.isHidden = false
                    addressTableviewCell.titleLabel.textColor = UI_ELEMENTS_COLOR
                }
            }
            else if(textField.tag == 4){
                
                addressTableviewCell.titleLabel.text = "Address2"
                
                if newString.isEmpty {
                    
                    addressTableviewCell.titleLabel.isHidden = true
                    return true
                    
                } else {
                    
                    addressTableviewCell.titleLabel.isHidden = false
                    addressTableviewCell.titleLabel.textColor = UI_ELEMENTS_COLOR
                }
            }
                
            else if(textField.tag == 5){
                
                addressTableviewCell.titleLabel.text = "City"
                
                if newString.isEmpty {
                    
                    addressTableviewCell.titleLabel.isHidden = true
                    return true
                    
                } else {
                    
                    addressTableviewCell.titleLabel.isHidden = false
                    addressTableviewCell.titleLabel.textColor = UI_ELEMENTS_COLOR
                }
            }
            else if(textField.tag == 7){
                
                addressTableviewCell.titleLabel.text = "Phone"
                
                if newString.isEmpty {
                    
                    addressTableviewCell.titleLabel.isHidden = true
                    return true
                    
                } else {
                    
                    addressTableviewCell.titleLabel.isHidden = false
                    addressTableviewCell.titleLabel.textColor = UI_ELEMENTS_COLOR
                    
                    let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
                    let components = (newString as NSString).components(separatedBy: NSCharacterSet.decimalDigits.inverted)
                    
                    let decimalString = components.joined(separator: "") as NSString
                    let length = decimalString.length
                    let hasLeadingOne = length > 0 && decimalString.character(at: 0) == (1 as unichar)
                    
                    if length == 0 || (length > 10 && !hasLeadingOne) || length > 11 {
                        let newLength = (textField.text! as NSString).length + (string as NSString).length - range.length as Int
                        
                        return (newLength > 10) ? false : true
                    }
                    var index = 0 as Int
                    let formattedString = NSMutableString()
                    
                    if hasLeadingOne {
                        formattedString.append("1 ")
                        index += 1
                    }
                    if (length - index) > 3 {
                        let areaCode = decimalString.substring(with: NSMakeRange(index, 3))
                        formattedString.appendFormat("(%@) ", areaCode)
                        index += 3
                    }
                    if length - index > 3 {
                        let prefix = decimalString.substring(with: NSMakeRange(index, 3))
                        formattedString.appendFormat("%@-", prefix)
                        index += 3
                    }
                    
                    let remainder = decimalString.substring(from: index)
                    formattedString.append(remainder)
                    textField.text = formattedString as String
                    phoneNumber = (formattedString.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
                    params["phoneNumber"] = phoneNumber
                    return false
                    
                    //textField.text = format(phoneNumber: newString)
                }
            }
            else if(textField.tag == 8){
                
                addressTableviewCell.titleLabel.text = "Email"
                
                if newString.isEmpty {
                    
                    addressTableviewCell.titleLabel.isHidden = true
                    return true
                    
                } else {
                    
                    addressTableviewCell.titleLabel.isHidden = false
                    addressTableviewCell.titleLabel.textColor = UI_ELEMENTS_COLOR
                    
                }
            }
            else if(textField.tag == 9){
                
                addressTableviewCell.titleLabel.text = "Shipper#"
                
                if newString.isEmpty {
                    
                    addressTableviewCell.titleLabel.isHidden = true
                    return true
                    
                } else {
                    
                    addressTableviewCell.titleLabel.isHidden = false
                    addressTableviewCell.titleLabel.textColor = UI_ELEMENTS_COLOR
                }
            }
            
            
            
            
            
        }
        else if let stateCountryTableViewCell : StateCountryTableViewCell = textField.superview?.superview as? StateCountryTableViewCell {
            stateCountryTableViewCell.zipTitle.text = "Zip"
            
            if newString.isEmpty {
                
                stateCountryTableViewCell.zipTitle.isHidden = true
                return true
                
            } else {
                
                stateCountryTableViewCell.zipTitle.isHidden = false
                stateCountryTableViewCell.zipTitle.textColor = UI_ELEMENTS_COLOR
            }
            
            
        }
        else if let  dropDownTableViewCell : DropDownTableViewCell = textField.superview?.superview as? DropDownTableViewCell {
            
            
            
        }
        
        if textField.tag == 4320 {
            //            do {
            //                let expression = "^([0-9]+)?(\\.([0-9]{1,2})?)?$"
            //                let regex = try NSRegularExpression(pattern: expression, options: .caseInsensitive)
            //                let numberOfMatches = regex.numberOfMatches(in: newString, options: [], range: NSRange(location: 0, length: newString.characters.count))
            //                if numberOfMatches == 0 {
            //                    return false
            //                }
            //                itemNumber = newString as String
            //
            //            } catch let error {
            //
            //                print(error.localizedDescription)
            //            }
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    func getCurrentAddressModel() -> CustomerLookUpAddressModel  {
        
        let viewModel : CustomerLookUpAddressModel?
        
        if(customerAddressDetails.count > 0){
            viewModel = customerAddressDetails[0]
        }
        else{
            viewModel = CustomerLookUpAddressModel()
            viewModel?.addressType = addressDescription
            viewModel?.state = "Alsaka"
            viewModel?.country = "USA"
            viewModel?.shipperType = "ABF"
        }
        return viewModel!
        
    }
    
    //MARK: - Keyboard Notifications
    
    func registerForKeyboardNotifications() {
        //Adding notifies on keyboard appearing
        
        NotificationCenter.default.addObserver(self, selector: #selector(AddNewAddressViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AddNewAddressViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func deregisterFromKeyboardNotifications() {
        //Removing notifies on keyboard appearing
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let height = min(keyboardSize.height, keyboardSize.width)
            
            if(self.isLoadFirstTime == true && isFromCustomerAddress == true){
                bottomViewConstriant.constant = height - 50
                self.isLoadFirstTime = false
            }else{
                bottomViewConstriant.constant = height - 50
            }
            
            if(activeTextField.tag > 5){
                tableViewTop.constant = -50
            }else{
                tableViewTop.constant = 0
            }
            
            //let heightOfKeyBoard  : CGFloat = keyBoardHeight == 0.0 ? height : keyBoardHeight
            
            
            
        }
    }
    func keyboardWillHide(notification: NSNotification) {
        // if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
        bottomViewConstriant.constant = 0
        tableViewTop.constant = 0
        viewHeightConst.constant = 40
        
        // }
    }
    @IBAction func saveClicked(_ sender: UIButton) {
        
        
        self.tableview.endEditing(true)
        var callApi = false
        for row in 0 ..< tableview.numberOfRows(inSection: 0)
        {
            
            let indexPath : IndexPath = IndexPath(row: row, section: 0)
            
            tableview.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: false)
            
            if(row == 8){
                let cell = tableview.cellForRow(at: indexPath) as! AddressTableViewCell
                let emailReg = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
                let emailTest = NSPredicate(format: "SELF MATCHES %@", emailReg)
                if(cell.descriptionTF.text != ""){
                    if emailTest.evaluate(with:cell.descriptionTF.text) == false {
                        callApi =  cell.descriptionTF.showError()
                        if(callApi == false){
                            return
                        }
                    }
                }else{
                    callApi =  cell.descriptionTF.validate()
                    if(callApi == false){
                        return
                    }
                }
            }
            
            if((row == 1) || (row == 2) || (row == 3) || (row == 4) || (row == 5)){
                let cell = tableview.cellForRow(at: indexPath) as! AddressTableViewCell
                callApi =  cell.descriptionTF.validate()
                if(callApi == false){
                    return
                }
                
                if(row == 7){
                    if((cell.descriptionTF.text?.characters.count)! > 0){
                        if (cell.descriptionTF.text?.validPhoneNumber)! {
                            print("valid phone number")
                        }else{
                            callApi =  cell.descriptionTF.showError()
                            if(callApi == false){
                                return
                            }
                        }
                    }
                 
                }
                
            }
            if(indexPath.row == 6){
                let cell = tableview.cellForRow(at: indexPath) as! StateCountryTableViewCell
                if(params["state"] as? String == "Select"){
                    Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: kAppTitle, messege: "Please Select State", clickAction:{
                    })
                    return
                }
                callApi =  cell.zipTF.validate()
                if(callApi == false){
                    return
                }
            }
            //            if(indexPath.row == 10){
            //                if(params["shipperType"] as? String == "Select"){
            //                    Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: kAppTitle, messege: "Please Select Shipper Type", clickAction:{
            //                    })
            //                    return
            //                }
            //
            //            }
            if(indexPath.row == 0){
                if(params["addressType"] as? String == "Select"){
                    Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: kAppTitle, messege: "Please Select addressType ", clickAction:{
                    })
                    return
                }
                
            }
        }
        var stateCode = ""
        for stateNames in stateModelArray{
            if(stateNames.Description.uppercased() == (params["state"] as? String)?.uppercased()){
                stateCode = stateNames.state
            }
        }
        
        
        
        let state = params["state"] as? String
        
        let city = params["city"] as? String
        
        let zipCode = params["zipCode"] as? String
        let address1 = params["address1"] as? String
        
        if((city?.characters.count)! < 3){
            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: kAppTitle, messege: "Please Enter Valid City", clickAction: {
            })
            return
            
        }
        if((state?.characters.count)! < 2){
            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: kAppTitle, messege: "Please Enter Valid State", clickAction: {
            })
            return
        }
        if((zipCode?.characters.count)! < 5){
            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: kAppTitle, messege: "Please Enter Valid ZipCode", clickAction: {
            })
            return
        }
        if((address1?.characters.count)! < 3){
            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: kAppTitle, messege: "Please Enter valid address", clickAction: {
            })
            return
        }
        
        params.updateValue(stateCode, forKey: "state")
        params.updateValue(addressType, forKey: "addressType")
        params.updateValue(shipperType, forKey: "shipperType")
        params.updateValue(phoneNumber, forKey: "phoneNumber")
        
        
        if((city?.characters.count)! >= 3 && (state?.characters.count)! >= 2 && (zipCode?.characters.count)! >= 5 && ((address1?.characters.count)! >= 3)){
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.insertOrUpdateAddress()
            }
            
        }
        
        
    }
    //    func checkSuccess(_ success : Bool) -> Bool{
    //        if(success == false){
    //            return false
    //        }
    //        else{
    //        return true
    //        }
    //    }
    
    func insertOrUpdateAddress(){
        
     
        
        NetworkServiceHandler.sharedInstance.postRequest(self, url: API_INSERTORUPDATEADDRESS, parameters: params, successBlock: {(message,count) in
     
      
            Utilities.showToast(self.view, text: message)
            let poppedVC = self.navigationController?.popViewController(animated: true)
            print(poppedVC as Any)
            
    
            
        }) { (fail) in
            
        }
    }
    
    func readDataSources(){
        
        statesArray.append("Select")
        
        for state in stateModelArray{
            statesArray.append(state.Description)
        }
        
        
        for countryNames in countryModelArray{
            countryArray.append(countryNames.country)
        }
        
        // shipViaArray.append("Select")
        
        for shipTypes in shipViaModel{
            shipViaArray.append(shipTypes.Description)
        }
        
        addressTypeArray.append("Select")
        for addressTypes in addressTypeModelArray{
            addressTypeArray.append(addressTypes.Description)
        }
        
        let viewModel : CustomerLookUpAddressModel?
        var state : String?
        var shipperType : String?
        
        
        
        
        if(customerAddressDetails.count > 0){
            
            viewModel = customerAddressDetails[0]
            
            for stateNames in stateModelArray{
                if(stateNames.state == viewModel?.state.uppercased()){
                    state = stateNames.Description
                }
            }
            
            for shipTypes in shipViaModel{
                if(shipTypes.shipVia == viewModel?.shipperType.uppercased()){
                    shipperType = shipTypes.Description
                }
            }
            let address1 = (viewModel?.address1 == "Enter Address - 1") ? "" :  viewModel?.address1
            let address2 = (viewModel?.address2 == "Enter Address - 2") ? "" :  viewModel?.address2
            let contactName = (viewModel?.contactName == "Input Input Input") ? "" :  viewModel?.contactName
            let city = (viewModel?.city == "Input") ? "" :  viewModel?.city
            let country = (viewModel?.country == "") ? "USA" : viewModel?.country
            let zipCode = (viewModel?.zipCode == "11111") ? "" : viewModel?.zipCode
            
            isResidentialAddress = Int((viewModel?.residentialAddress)!) == 0 ? false : true
            
            phoneNumber = (viewModel?.phoneNumber)!
            
            params.updateValue(Int((viewModel?.addressNumber)!) ?? 0, forKey: "addressNumber")
            params.updateValue(addressDescription, forKey: "addressType")
            params.updateValue((viewModel?.customerName) ?? "", forKey: "customerName")
            params.updateValue(contactName ?? "", forKey: "contactName")
            params.updateValue(Int((viewModel?.mainAddress)!) ?? 0, forKey: "mainAddress")
            params.updateValue(address1 ?? "", forKey: "address1")
            params.updateValue(address2 ?? "", forKey: "address2")
            params.updateValue(city ?? "", forKey: "city")
            params.updateValue(state ?? "", forKey: "state")
            params.updateValue(zipCode ?? "", forKey: "zipCode")
            params.updateValue(country ?? "USA", forKey: "country")
            params.updateValue(phoneNumber, forKey: "phoneNumber")
            params.updateValue((viewModel?.eMailAddress) ?? "", forKey: "eMail")
            params.updateValue(Int((viewModel?.residentialAddress)!)  ?? 0, forKey: "residentialAdd")
            params.updateValue(shipperType ?? shipViaArray[1], forKey: "shipperType")
            params.updateValue((viewModel?.shipperNumber) ?? "", forKey: "shipperNumber")
            let credentials = Utilities.getUserNameAndPasswordFromLocalStorage()
            if let userName = credentials.userName {
                params.updateValue(userName, forKey: "userID")
                params.updateValue(userName, forKey: "customerNumber")
            }
            params.updateValue(0, forKey: "longitude")
            params.updateValue(0, forKey: "latitude")
            params.updateValue(newOrderNumber, forKey: "orderNumber")
            params.updateValue(newOrderSequenceNumber, forKey: "orderSeqNumber")
            self.isServerSuccess = true
        }else{
            if(isFromNewCustomer == false){
                params.updateValue(0, forKey: "addressNumber")
                params.updateValue(addressDescription, forKey: "addressType")
                params.updateValue("", forKey: "customerName")
                params.updateValue("", forKey: "contactName")
                params.updateValue(0, forKey: "mainAddress")
                params.updateValue("", forKey: "address1")
                params.updateValue("", forKey: "address2")
                params.updateValue("", forKey: "city")
                params.updateValue("Select", forKey: "state")
                params.updateValue("", forKey: "zipCode")
                params.updateValue("USA", forKey: "country")
                params.updateValue("", forKey: "phoneNumber")
                params.updateValue("", forKey: "eMail")
                isResidentialAddress = Int(isResidentialAdd)! == 0 ? false : true
                params.updateValue(Int(isResidentialAdd) ?? 0, forKey: "residentialAdd")
                params.updateValue(shipViaArray[1], forKey:"shipperType")
                params.updateValue("", forKey:"shipperNumber")
                let credentials = Utilities.getUserNameAndPasswordFromLocalStorage()
                if let userName = credentials.userName {
                    params.updateValue(userName, forKey: "userID")
                     params.updateValue(userName, forKey: "customerNumber")
                }
                params.updateValue(0, forKey: "longitude")
                params.updateValue(0, forKey: "latitude")
                params.updateValue(newOrderNumber, forKey: "orderNumber")
                params.updateValue(newOrderSequenceNumber, forKey: "orderSeqNumber")
            }
            
        }
        if(isFromCustomerAddress == true){
            self.isLoadFirstTime = true
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                if(self.titleText == "Edit Address"){
                    self.focusContactNameTextField()
                }else{
                    self.focusDropDownTextField()
                }
                
                
            })
            
        }else
        {
            self.isLoadFirstTime = true
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                
                self.focusContactNameTextField()
                
            })
        }
        
        
        
    }
    
    
    
 */
    
}
