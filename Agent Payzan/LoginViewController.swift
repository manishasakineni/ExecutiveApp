 //
//  ViewController.swift
//  Agent Payzan
//
//  Created by N@n!'$ Mac on 26/10/17.
//  Copyright © 2017 Naveen. All rights reserved.
//

import UIKit
import Localize

@available(iOS 9.0, *)
class LoginViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var chooseLanguageBtn: UIButton!
    
    
    
    @IBOutlet weak var headerImgVW: UIImageView!
    
    var eyeIconBtn = UIButton(type: .custom)
    
    @IBOutlet weak var headerImgHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var mobileEmailTF: UITextField!
    
   
    @IBOutlet weak var mobileHeightConst: NSLayoutConstraint!
    
    @IBOutlet weak var passwardHeightConst: NSLayoutConstraint!
    
    
    @IBOutlet weak var loginHeightConst: NSLayoutConstraint!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    var userDetailsDoictionary   = LoginParamsAPIModel()
    
    var tokensDetails   = LoginParamsAPIModel()
    
    var rolesDictionary = LoginParamsAPIModel()
    
    var accesTokenStr:String = ""
    var tokenTypeStr:String = ""
    var refreshToken : String = ""
    
    var userName = ""
    var password = ""

    var eyeIcon : Bool!
    
    var backgroundTaskIdentifier: UIBackgroundTaskIdentifier?
    var timer               : Timer = Timer.init()
    
    var isManualLogin       : Bool = false
    
     var serviceController = ServiceController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        eyeIconBtn.setImage(UIImage(named: "eye2"), for: .normal)
        eyeIconBtn.contentMode = .scaleAspectFit
        eyeIconBtn.frame = CGRect(x: 5, y: 5, width: 20, height: 20)
        eyeIconBtn.tintColor = #colorLiteral(red: 0.5568627451, green: 0.1254901961, blue: 0.1647058824, alpha: 1)
        eyeIconBtn.addTarget(self, action: #selector(self.eyeIconBtnClicked), for: .touchUpInside)
        
        
        let paddingView: UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        paddingView.addSubview(eyeIconBtn)
        passwordTF.rightViewMode = .always
        passwordTF.rightView = paddingView
        
        eyeIcon = true
        
        mobileEmailTF.delegate = self
        passwordTF.delegate = self
        mobileEmailTF.keyboardType = .phonePad
        mobileEmailTF.borderStyle = UITextBorderStyle.roundedRect
        passwordTF.borderStyle = UITextBorderStyle.roundedRect

        self.forIpodAndIphone()
        
//        let PWDaddingView: UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
//        
//        eyeIconBtn.setImage(UIImage(named: "eye2"), for: .normal)
//        
//        eyeIconBtn.frame = CGRect(x: CGFloat(passwordTF.frame.size.width - 30), y: CGFloat(5), width: CGFloat(30), height: CGFloat(30))
//        eyeIconBtn.tintColor = #colorLiteral(red: 0.5568627451, green: 0.1254901961, blue: 0.1647058824, alpha: 1)
//        eyeIconBtn.contentMode = .scaleAspectFit
//      //  eyeIconBtn.addTarget(self, action: #selector(self.currentPwBtnAction), for: .touchUpInside)
//        PWDaddingView.addSubview(eyeIconBtn)
//        PWDaddingView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        passwordTF.rightView = PWDaddingView
//        passwordTF.rightViewMode = .always
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
//MARK: -  User Interface for ipad and iPhone
    
    func forIpodAndIphone(){
    
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
            
            mobileHeightConst.constant = 50
            passwardHeightConst.constant = 50
            loginHeightConst.constant = 60
            
            self.headerImgVW.image =  UIImage(named: "1536X250.jpg")
            self.headerImgHeight.constant = 130
          
            
            
        }
            
        else {
            
            mobileHeightConst.constant = 30
            passwardHeightConst.constant = 30
            loginHeightConst.constant = 40
            
            self.headerImgVW.image =  UIImage(named: "384X100.jpg")
            self.headerImgHeight.constant = 80

            
        }
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
//MARK: - UIText Field Delegate Methods
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        
//        if textField == mobileEmailTF{
//            
//            textField.text = mobileEmailTF.text
//            
//        }
//            
//        else if textField == passwordTF{
//            
//            textField.text = passwordTF.text
//            
//        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        

        if textField == mobileEmailTF{
        userName = mobileEmailTF.text!
            
            
        }
        
        else if textField == passwordTF{
        
        password = passwordTF.text!
            
            UserDefaults.standard.set(password, forKey: "password")
            UserDefaults.standard.synchronize()
            
        }
        
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        /// 1. replacementString is NOT empty means we are entering text or pasting text: perform the logic
        /// 2. replacementString is empty means we are deleting text: return true
        
        if textField == mobileEmailTF {
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
        return true
        
    }

//MARK: -  validate pgone number
    
    func validatePhoneNumber(phoneNumber: String) -> Bool {
        let PHONE_REGEX = "^((\\+)|(00))[0-9]{6,14}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: phoneNumber)
        return result
    }
    
//MARK: -  validate password
    
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    
//MARK: -  Login button
    
    @IBAction func loginClicked(_ sender: Any) {
        
        self.view.endEditing(true)
        
        mobileEmailTF.text = mobileEmailTF.text!.trimmingCharacters(in: CharacterSet.whitespaces)
        passwordTF.text = passwordTF.text!.trimmingCharacters(in: CharacterSet.whitespaces)
        
        var errorMessage:NSString?
 
        
        
        if userName.isEmpty && password.isEmpty{
            
            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Message".localize(), messege: "app.Pleaseenterrequiredfields".localize(), clickAction: {
                
                
            })
            
        }
            
            
        else if (userName.isEmpty) {
            
            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Message".localize(), messege: "app.Pleaseenteryourmobilenumberoremail".localize(), clickAction: {
                
                
            })
            
        }
        else if (userName.characters.count != 10){
            
            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(), messege: "app.Mobilenumbershouldbe10digits".localize(), clickAction: {
                
            })
        }
            
        else if (userName == "0000000000") {
            
            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Message".localize(), messege: "app.Pleaseentervalidmobilenumber".localize(), clickAction: {
                
                
            })
            
        }
            
        else if (password.isEmpty) {
            
            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Message".localize(), messege: "app.Pleaseenteryourpassword".localize(), clickAction: {
                
                
            })
            
        }

        else if(!GlobalSupportingClass.capitalOnly(password: passwordTF.text! as String)) {
            
            errorMessage=GlobalSupportingClass.validPasswordMessage() as String as String as NSString?
        }
        else if(!GlobalSupportingClass.numberOnly(password: passwordTF.text! as String)) {
            
            errorMessage=GlobalSupportingClass.validPasswordMessage() as String as String as NSString?
        }
        else if(!GlobalSupportingClass.specialCharOnly(password: passwordTF.text! as String)) {
            
            errorMessage=GlobalSupportingClass.validPasswordMessage() as String as String as NSString?
        }
        
        if let errorMsg = errorMessage{
            
            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Alert".localize(), messege: errorMsg as String, clickAction: {
            })
            
        }
        
            
        else {
            
            if(appDelegate.checkInternetConnectivity()){
                
                let params = ["clientId"     : "payzan.mobile",
                              "clientSecret" : "PayZan!@",
                              "scope"        : "offline_access",
                              "userName"     :  userName,
                              "password"     :  password] as Dictionary<String, AnyObject>
                
                print("parms:\(params)")
                
                APIModel().postLoginRequest(self, withUrl: LOGIN_API , parameters: params as Dictionary<String, AnyObject> , successBlock: { (json) in
                    
                    self.parseJson(data: json)
                    
                    print(json)
                    
                    print(self.parseJson(data: json))
                    
                    print(self.userDetailsDoictionary)
                    
                    UserDefaults.standard.set("true", forKey: KFirstTimeLogin)
                    
                    UserDefaults.standard.set(self.userDetailsDoictionary.userName, forKey: AuserName)
                    UserDefaults.standard.set(self.accesTokenStr, forKey: KAccessToken)
                    UserDefaults.standard.set(self.tokenTypeStr, forKey: KTokenType)
                    UserDefaults.standard.set(self.userDetailsDoictionary.id, forKey: AId)
                    UserDefaults.standard.set(self.userDetailsDoictionary.phoneNumber, forKey: AmobileNumber)
                    UserDefaults.standard.set(self.userDetailsDoictionary.email, forKey: Aemail)
                    UserDefaults.standard.set(self.refreshToken, forKey: ArefreshToken)
                   
                    UserDefaults.standard.set(self.userDetailsDoictionary.expiresIn, forKey: AExpiresIn)
                
                    UserDefaults.standard.synchronize()

                        self.backgroundTaskIdentifier = UIApplication.shared.beginBackgroundTask(expirationHandler: {
                            UIApplication.shared.endBackgroundTask(self.backgroundTaskIdentifier!)
                        })
                        
                        
                        if let expiresInSeconds = Int((UserDefaults.standard.value(forKey: "AExpiresIn") as?  String)!) {
                            
                            self.timer.invalidate()

//                            self.timer = Timer.scheduledTimer(timeInterval: expiresInSeconds as! TimeInterval, target: self, selector: #selector(self.refreshTokenForCall), userInfo: nil, repeats: false)
                            
                            self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(expiresInSeconds), target: self, selector: #selector(self.refreshTokenForCall), userInfo: nil, repeats: false)
                            
                            guard self.isManualLogin else { return }
                        }
                        
                        self.isManualLogin = false
                        
                  
                    
                    let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "homeVC") as! HomeViewController
                    
                    
                    
                    self.navigationController?.pushViewController(homeVC, animated: true)
                    
                    
                    
                })
                    
                {
                    
                    (failureMessage) in
                    
                    Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(), messege: failureMessage, clickAction: {
                        
                    })
                  
//                    print("fail: \(failureMessage)")
                  
                }
            }
            else {
                
                Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(), messege: "app.Pleasecheckyourinternetconnection!".localize(), clickAction: {
                    
                    
                })
                
            }
            
           
        }
    }
    
    func refreshTokenForCall(){
       
        serviceController.refreshTokenForLogin(self, successHandler: { (json) in
            
            
            
            
        }) { (failureMessage) in
            
            
            
            
            
        }
    }

    
   
//MARK: -  Parsing Login Json data
    
    
    func parseJson(data : Dictionary<String,Any>){
        
            if Utilities.sharedInstance.isObjectNull(data as AnyObject) {
                
                if let response = data as? NSDictionary {
                    
                    let data = response["Result"]
                    
                    if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
                        
                        
                        if let response = data as? NSDictionary {
                            if Utilities.sharedInstance.isObjectNull(response) {
                                
                              
                                
                                if let user = response ["User"]{
                                    
                                    if Utilities.sharedInstance.isObjectNull(user as AnyObject?) {
                                        
                                        
                                        if let response = user as? NSDictionary {
                                            if Utilities.sharedInstance.isObjectNull(response) {

                                                userDetailsDoictionary = LoginParamsAPIModel(dict:response)
                                            }
                                        }
                                    }
                                }
                                if let token = response ["AccessToken"]{
                                    
                                    if Utilities.sharedInstance.isObjectNull(token as AnyObject?) {
                                        
                                        
                                        if let response = token as? String {
                                            if Utilities.sharedInstance.isObjectNull(response as AnyObject) {
                                                
                                                accesTokenStr = response
                                            }
                                        }
                                    }
                                }
                                
                                if let token = response ["RefreshToken"]{
                                    
                                    if Utilities.sharedInstance.isObjectNull(token as AnyObject?) {
                                        
                                        
                                        if let response = token as? String {
                                            if Utilities.sharedInstance.isObjectNull(response as AnyObject) {
                                                
                                                refreshToken = response
                                            }
                                        }
                                    }
                                }
                                if let tokenType = response ["TokenType"]{
                                    
                                    if Utilities.sharedInstance.isObjectNull(tokenType as AnyObject?) {
                                        
                                        
                                        if let response = tokenType as? String {
                                            if Utilities.sharedInstance.isObjectNull(response as AnyObject) {
                                                
                                                tokenTypeStr = response
                                            }
                                        }
                                    }
                                }
                                
                                if let roles = response ["Roles"]{
                                    
                                    if Utilities.sharedInstance.isObjectNull(roles as AnyObject?) {
                                        
                                        
                                        if let response = roles as? NSArray {
                                            if Utilities.sharedInstance.isObjectNull(response) {
                                                
                                        for userRoles in response {
                                                        
                                            if Utilities.sharedInstance.isObjectNull(userRoles as AnyObject?) {
                                                            
                                                rolesDictionary = LoginParamsAPIModel(dict: userRoles as? NSDictionary)
                                                
                                                        
                                                    }
                                                }

                                            }
                                        }
                                    }
                                }
                                
                                
                                
                                
                            }
                        }
                    }
                }
            }
        
    }
    
    
//MARK: -  Refreshtoken Api Call for Session expire
    
    
        
//MARK: - Buttun Actions
    
    
     func eyeIconBtnClicked(_ sender: UIButton) {
        
        if eyeIcon == true {
            passwordTF.isSecureTextEntry = false
            eyeIconBtn.setImage(UIImage(named: "Eye"), for: .normal)
            eyeIconBtn.contentMode = .scaleAspectFit
            eyeIcon = false
            
            
        }
            
        else if eyeIcon == false
        {
            
            passwordTF.isSecureTextEntry = true
            eyeIconBtn.setImage(UIImage(named: "eye2"), for: .normal)
            eyeIconBtn.contentMode = .scaleAspectFit
            eyeIcon = true
            
        }
        
        
    }
    

//MARK: - Buttun Actions
    
    @IBAction func languageClicked(_ sender: Any) {
        
        let actionSheet = UIAlertController(title: nil, message: "app.ChooseLanguage".localize(), preferredStyle: UIAlertControllerStyle.actionSheet)
        for language in Localize.availableLanguages() {
            let displayName = Localize.displayNameForLanguage(language)
            
          //  let ary : Array<String> = ["English","Sinhala","Tamil"]
            let languageAction = UIAlertAction(title: displayName, style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                Localize.update(language: language)
                
                
            })
            actionSheet.addAction(languageAction)
        }
        let cancelAction = UIAlertAction(title: "app.Cancel".localize(), style: UIAlertActionStyle.cancel, handler: {
            (alert: UIAlertAction) -> Void in
        })
        actionSheet.addAction(cancelAction)
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone) {
            
            
            self.present(actionSheet, animated: true, completion: nil)
        }
            
        else{
            
            let popup = UIPopoverController.init(contentViewController: actionSheet)
            
            popup.present(from: CGRect(x:self.chooseLanguageBtn.frame.minX+self.chooseLanguageBtn.frame.size.width/2, y:self.chooseLanguageBtn.frame.maxY, width:0, height:0), in: self.view, permittedArrowDirections: UIPopoverArrowDirection.up, animated: true)
            
            //newRegTableViewCell
        }
        
        
    }
    

}
