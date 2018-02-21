//
//  Utilities.swift
//  YISCustomerApp
//
//  Created by Calibrage Mac on 17/08/17.
//  Copyright © 2017 Calibrage Mac. All rights reserved.
//

import UIKit
//import Crashlytics
import TextFieldEffects


class Utilities: NSObject {
    
    
    
    
    static let sharedInstance : Utilities = Utilities()
    
   
    
    //MARK: - Nil Check
    
    func isObjectNull(_ object: AnyObject?) -> Bool {
        return !isNil(object) && !isNull(object)
    }
    
    private func isNull(_ object: AnyObject?) -> Bool {
        if !isNil(object) {
            if object!.isKind(of: NSNull.self) || object?.classForCoder == NSNull.classForCoder() {
                return true
            } else {
                return isStringNull(object)
            }
        }
        return false
    }
    
    private func isStringNull(_ object: AnyObject?) -> Bool {
        guard isNil(object) && isNull(object) else {
            let str = object as? String ?? ""
            return str == "<NULL>"
        }
        return false
    }
    
    private func isNil(_ object: AnyObject?) -> Bool {
        return object == nil
    }
    

    //MARK:- UIAlert Controller Actions
    
    func alertWithOkButtonAction(vc :UIViewController, alertTitle:String, messege: String ,clickAction:@escaping () -> Void) {
        
        let capsMsg  = messege.capitalizingFirstLetter()
        let alrtControl = UIAlertController(title: alertTitle, message: capsMsg , preferredStyle: .alert)
        
        let cancelButton = UIAlertAction(title: "app.OK".localize(), style: .default) { _ in
            clickAction()
            
        }
        alrtControl.addAction(cancelButton)
       // alrtControl.view.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        vc.present(alrtControl, animated: true, completion: nil)
        
    }
 
    
    func alertWithOkAndCancelButtonAction(vc :UIViewController, alertTitle:String, messege: String ,clickAction:@escaping () -> Void) {
        
        let capsMsg  =  messege.capitalizingFirstLetter()
        let alrtControl = UIAlertController(title: alertTitle, message: capsMsg , preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "app.OK".localize(), style: .default) { _ in
            clickAction()
            
        }
        let cancelButton = UIAlertAction(title: "app.Cancel".localize(), style: .default) { _ in
            
        }
        alrtControl.addAction(cancelButton)
        alrtControl.addAction(okButton)
       // alrtControl.view.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        vc.present(alrtControl, animated: true, completion: nil)
        
    }
    
    func alertWithYesNoButtonAction(vc :UIViewController, alertTitle:String, messege: String ,clickAction:@escaping () -> Void) {
        
        let capsMsg  = messege.capitalizingFirstLetter()
        let alrtControl = UIAlertController(title: alertTitle, message: capsMsg , preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "app.Yes".localize(), style: .default) { _ in
            clickAction()
            
        }
        let cancelButton = UIAlertAction(title: "app.No".localize(), style: .default) { _ in
            
        }
        alrtControl.addAction(cancelButton)
        alrtControl.addAction(okButton)
       // alrtControl.view.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        vc.present(alrtControl, animated: true, completion: nil)
        
    }
    

    func goToLoginScreen(){
    
    
    let LoginNav : UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginNav") as! UINavigationController
    
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = LoginNav
        
    }
    
   
}


//MARK: - DateFormatter Extensions

extension DateFormatter {
    
   // let dateFormatter = DateFormatter()
    
    static let dateee : DateFormatter = DateFormatter()
    
    func systemTimeZone() {
        
        let enUSPOSIXLocale:NSLocale=NSLocale(localeIdentifier: "en_US_POSIX")
        self.locale=enUSPOSIXLocale as Locale!
        
        self.timeZone = NSTimeZone(name: "GMT") as TimeZone!
    }
    
    class func dateFormatter_yyyy_MM_dd_hh_mm_ss_Z() -> DateFormatter {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.system
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.systemTimeZone()
        return dateFormatter
    }
    
    class func dateFormatter_yyyy_MM_dd_hh_mm_ss_SSSSSSS_Z() -> DateFormatter {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.system
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZ" //2016-01-01T11:57:55.6738531+05:30
        dateFormatter.systemTimeZone()
        return dateFormatter
    }
    
    class func dateFormatter_yyyy_dd_MM_hh_mm_ss_SSSSSSS_Z() -> DateFormatter {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.system
        dateFormatter.dateFormat = "yyyy-dd-MM'T'HH:mm:ss.SSSSSSSZ" //2016-16-12T11:57:55.6738531+05:30
        dateFormatter.systemTimeZone()
        return dateFormatter
    }
    
    class func dateFormatter_yyyy_MM_dd_hh_mm_ss_SSS() -> DateFormatter {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.system
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS" //2016-11-30T02:19:47.633
        dateFormatter.systemTimeZone()
        return dateFormatter
    }
    
    class func dateFormatter_yyyy_MM_dd() -> DateFormatter {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.system
        dateFormatter.dateFormat = "yyyy/MM/dd" //2016-11-30T02:19:47.633
        dateFormatter.systemTimeZone()
        return dateFormatter
    }
    
    class func dateFormatter_yyyy() -> DateFormatter {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.system
        dateFormatter.dateFormat = "yyyy"
        dateFormatter.systemTimeZone()
        return dateFormatter
    }
    
    class func dateFormatter_mm_dd_yyyy() -> DateFormatter {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.system
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateFormatter.systemTimeZone()
        return dateFormatter
    }
    
    class func dateFormatter_Local_mm_dd_yyyy() -> DateFormatter {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }
    
    class func dateFormatter_Local_yyyy_MM_dd_H_M_S() -> DateFormatter {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"     //2016-12-28T00:00:00
        return dateFormatter
    }
    
    
    
    class func dateFormatter_Local_yyyy_MM_dd() -> DateFormatter {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateFormat = "yyyy-MM-dd"     //2016-12-28T00:00:00
        return dateFormatter
    }
    
    class func dateFormatter_Local_mm_dd_yy() -> DateFormatter {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateFormat = "MM/dd/yy"
        return dateFormatter
    }
    
    class func dateFormatter_Local_mm_dd() -> DateFormatter {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateFormat = "MM/dd"
        return dateFormatter
    }
    
    class func dateFormatter_Local_yyyy_MM_dd_hh_mm_ss_SSS() -> DateFormatter {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.system
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS" //2016-11-30T02:19:47.633
        dateFormatter.timeZone = NSTimeZone.system
        return dateFormatter
    }
    
    class func dateFormatter_Local_yyyy_MM_dd_hh_mm_ss() -> DateFormatter {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.system
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss" //2016-10-27T00:00:00
        dateFormatter.timeZone = NSTimeZone.system
        return dateFormatter
    }
    
    class func dateFormatter_Local_yyyy() -> DateFormatter {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter
    }
    
 
    
}
    
//MARK: String Extensions

extension String {
    
    func capitalizingFirstLetter() -> String {
        
        let first = String(characters.prefix(1)).capitalized
        let other = String(characters.dropFirst())
        return first + other
    }
}


extension  UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

