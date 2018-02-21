//
//  FeatureUse.swift
//  Agent Payzan
//
//  Created by N@n!'$ Mac on 20/12/17.
//  Copyright © 2017 Naveen. All rights reserved.
//

import UIKit

class FeatureUse: NSObject {
    
    
    //                 let statusCode = (response as! HTTPURLResponse).statusCode
    //
    //                    if 200...299 ~= statusCode {
    //
    //
    //                        DispatchQueue.main.async {
    //
    //
    //                                successBlock(json as! Dictionary<String, AnyObject>)
    //
    //                            }
    //
    //                             viewController.hideHUD()
    //                        }
    
    
    //MARK: - COLORS
    
    
   
     let NAVY_BLUE_COLOR = UIColor.init(colorLiteralRed: 7.0/255.0, green: 68.0/255.0, blue: 119.0/255.0, alpha: 1.0)
     let UI_ELEMENTS_COLOR = UIColor.init(colorLiteralRed: 11.0/255.0, green: 84.0/255.0, blue: 146.0/255.0, alpha: 1.0)
     let UI_ELEMENTS_COLOR_NOALPHA = UIColor.init(colorLiteralRed: 11.0/255.0, green: 84.0/255.0, blue: 146.0/255.0, alpha: 0.2)
     let LIGHT_GRAY_COLOR = UIColor.init(colorLiteralRed: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 0.5)
     
     let WHITE_PATTEREN_COLOR = UIColor(red: 225.0/255.0, green: 230.0/255.0, blue: 231.0/255.0, alpha: 1.0)
     let ITEM_DETAILS_BACKGROUND_COLOR = UIColor(red: 237.0/255.0, green: 237.0/255.0, blue: 237.0/255.0, alpha: 1.0)
     
     let MENU_SECTION_COLOR = UIColor(red: 3.0/255.0, green: 62.0/255.0, blue: 160.0/255.0, alpha: 1.0)
     let CATALOG_BORDER_COLOR = UIColor(red: 23.0/255.0, green: 128.0/255.0, blue: 250.0/255.0, alpha: 1.0)
     
     let QUOTES_SECTION_COLOR = UIColor(red: 79.0/255.0, green: 110.0/255.0, blue: 253.0/255.0, alpha: 1.0)
     let QUOTES_UNSELECTED_COLOR = UIColor(red: 191.0/255.0, green: 218.0/255.0, blue: 233.0/255.0, alpha: 1.0)
     
     let ITEM_ADDED_COLOR = UIColor(red: 0.0/255.0, green: 155.0/255.0, blue: 55.0/255.0, alpha: 1.0)
     let ITEM_NOT_FOUND_COLOR = UIColor(red: 255.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
     
     let VERY_LIGHT_GRAY_COLOR : UIColor = UIColor(red: 235.0/255.0, green: 236.0/255.0, blue: 238.0/255.0, alpha: 1.0)
     let TOAST_BACKGROUND_COLOR = UIColor.init(colorLiteralRed: 85.0/255.0, green: 85.0/255.0, blue: 85.0/255.0, alpha: 0.8)
     
     // MARK: - ALL DEVICES TYPE CHECK
     
     struct ScreenSize {
     
     static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
     static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
     static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
     static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
     }
     
     struct DeviceType {
     
     static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
     static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
     static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
     static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
     static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH >= 1024.0
     }
     
     struct Version {
     
     static let SYS_VERSION_FLOAT = (UIDevice.current.systemVersion as NSString).floatValue
     static let iOS7 = (Version.SYS_VERSION_FLOAT < 8.0 && Version.SYS_VERSION_FLOAT >= 7.0)
     static let iOS8 = (Version.SYS_VERSION_FLOAT >= 8.0 && Version.SYS_VERSION_FLOAT < 9.0)
     static let iOS9 = (Version.SYS_VERSION_FLOAT >= 9.0 && Version.SYS_VERSION_FLOAT < 10.0)
     static let iOS10 = (Version.SYS_VERSION_FLOAT >= 10.0 && Version.SYS_VERSION_FLOAT < 11.0)
     }
     
     struct GoogleAPI {
     
     static let API_KEY = "AIzaSyD1rxhujKPF5WXgR16dT4msFf4FABU5wtk"
     }
     
     //Regex Constants
     let REGEX_USER_NAME_LIMIT = "^.{3,10}$"
     
     let REGEX_USER_NAME = "[A-Za-z0-9]{3,10}"
     
     let REGEX_EMAIL = "[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
     
     let REGEX_PASSWORD_LIMIT = "^.{6,20}$"
     
     let REGEX_PASSWORD = "[A-Za-z0-9]{6,20}"
     
     let REGEX_PHONE_DEFAULT = "[0-9]{3}\\-[0-9]{3}\\-[0-9]{4}"
     
     
    /*
     
     static let sharedInstance : Utilities = Utilities()
     lazy var searchBar = UISearchBar(frame: CGRect.zero)
     
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
     
     //MARK: - Toast Methods
     
     class func showToast(_ view: UIView, text: String,position : String) {
     
     var style = ToastStyle()
     style.backgroundColor = TOAST_BACKGROUND_COLOR
     style.titleFont = UIFont.fontLightWithSize(14.0)
     view.makeToast(text, duration: 2.0, position:CGPoint(x: ScreenSize.SCREEN_WIDTH/2, y: ScreenSize.SCREEN_HEIGHT - 360), style: style)
     
     UIApplication.shared.windows.last?.bringSubview(toFront: view)
     }
     class func showToast(_ view: UIView, text: String) {
     
     var style = ToastStyle()
     style.backgroundColor = TOAST_BACKGROUND_COLOR
     style.titleFont = UIFont.fontLightWithSize(14.0)
     view.makeToast(text, duration: 2.0, position:CGPoint(x: ScreenSize.SCREEN_WIDTH/2, y: ScreenSize.SCREEN_HEIGHT - 200), style: style)
     UIApplication.shared.windows.last?.bringSubview(toFront: view)
     }
     
     
     
     //MARK:- UIAlert Controller Actions
     
     func alertWithOkButtonAction(vc :UIViewController, alertTitle:String, messege: String ,clickAction:@escaping () -> Void) {
     
     let capsMsg  = messege.capitalizingFirstLetter()
     let alrtControl = UIAlertController(title: alertTitle, message: capsMsg , preferredStyle: .alert)
     
     let cancelButton = UIAlertAction(title: "OK", style: .default) { _ in
     clickAction()
     
     }
     alrtControl.addAction(cancelButton)
     vc.present(alrtControl, animated: true, completion: nil)
     
     }
     func alertWithOkAndCancelButtonAction(vc :UIViewController, alertTitle:String, messege: String ,clickAction:@escaping () -> Void) {
     
     let capsMsg  =  messege.capitalizingFirstLetter()
     let alrtControl = UIAlertController(title: alertTitle, message: capsMsg , preferredStyle: .alert)
     
     let okButton = UIAlertAction(title: "OK", style: .default) { _ in
     clickAction()
     
     }
     let cancelButton = UIAlertAction(title: "Cancel", style: .default) { _ in
     
     }
     alrtControl.addAction(cancelButton)
     alrtControl.addAction(okButton)
     vc.present(alrtControl, animated: true, completion: nil)
     
     }
     
     func alertWithYesNoButtonAction(vc :UIViewController, alertTitle:String, messege: String ,clickAction:@escaping () -> Void) {
     
     let capsMsg  = messege.capitalizingFirstLetter()
     let alrtControl = UIAlertController(title: alertTitle, message: capsMsg , preferredStyle: .alert)
     
     let okButton = UIAlertAction(title: "Yes", style: .default) { _ in
     clickAction()
     
     }
     let cancelButton = UIAlertAction(title: "No", style: .default) { _ in
     
     }
     alrtControl.addAction(cancelButton)
     alrtControl.addAction(okButton)
     vc.present(alrtControl, animated: true, completion: nil)
     
     }
     
     
     
     
     class func getDictStringVlaue(_ obj :AnyObject?) -> String {
     
     
     if let str = obj as? String {
     if(str.lowercased() == "null" || str.lowercased() == "<null>") {
     return ""
     }
     
     return str
     }
     
     else {
     return ""
     }
     }
     
     func getFirstElement(strArray :[String]?) -> String? {
     
     if  strArray == nil {
     return ""
     }
     if (strArray?.count)!  > 0 {
     return strArray?.first
     }
     else {
     return ""
     }
     }
     class func isValidItemNumberText(_ text: String) -> Bool {
     
     let trimmedText = text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
     return trimmedText.characters.count > 0
     }
     
     //MARK: - Navigation Bar Setup
     //(Title Left Bar Button Right Bar Button)
     
     class func setupNavBarWithThreemenu(backImage: String?,cntr: UIViewController,searchBar : UISearchBar, backTitle:String, rightImage: String ,hideSearchPlaceHolder : String,secondShowRightImage: String, secondRightImage: String, navTitle : String,thirdRightImage: String ) {
     
     if(hideSearchPlaceHolder == "false" && secondRightImage != "Search"){
     searchBar.isHidden = false
     searchBar.placeholder = "Search by Item#, Description"
     let searchTextField = searchBar.value(forKey: "searchField") as? UITextField
     searchTextField?.textColor = UIColor.white
     searchTextField? .setValue(UIColor.white, forKeyPath: "_placeholderLabel.textColor")
     searchTextField?.backgroundColor = NAVY_BLUE_COLOR
     searchTextField?.tintColor = NAVY_BLUE_COLOR
     searchBar.barTintColor = NAVY_BLUE_COLOR
     let glassIconView = searchTextField?.leftView as! UIImageView
     glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
     glassIconView.tintColor = UIColor.white
     searchBar.sizeToFit()
     for subView in searchBar.subviews {
     for view in subView.subviews {
     if view.isKind(of:NSClassFromString("UIButton")!) {
     let cancelButton = view as! UIButton
     cancelButton.isEnabled = true
     cancelButton.setTitleColor(UIColor.white, for: .normal)
     }
     }
     }
     
     }
     
     
     
     var titlelabel: UILabel? = cntr.navigationController?.navigationBar.viewWithTag(555) as? UILabel
     
     if (titlelabel == nil) {
     
     titlelabel = UILabel(frame: CGRect(x: 50.0, y: 0, width: ScreenSize.SCREEN_WIDTH - 140, height: 44.0))
     titlelabel?.tag = 555
     titlelabel!.backgroundColor = UIColor.clear
     titlelabel!.font =  UIFont.fontBoldWithSize(15.0)
     titlelabel?.textAlignment = .left
     titlelabel!.textColor = UIColor.white
     
     
     
     
     cntr.navigationController?.navigationBar.addSubview(titlelabel!)
     }
     
     titlelabel!.text = navTitle
     
     if(cntr.navigationController != nil) {
     
     cntr.navigationController!.navigationBar.isTranslucent = false
     cntr.navigationController!.isNavigationBarHidden = false
     cntr.navigationController!.navigationBar.barTintColor = NAVY_BLUE_COLOR
     cntr.navigationController!.navigationBar.tintColor = UIColor.white
     cntr.navigationController?.navigationBar.barStyle = .black
     }
     
     
     
     if backImage != nil && backImage != "" {
     
     let leftButtonImage: UIImage = UIImage(named: backImage!)!
     let leftButton: UIButton = UIButton(type: .custom)
     leftButton.frame = CGRect(x: 0, y: 0, width: leftButtonImage.size.width, height: leftButtonImage.size.height)
     
     if backTitle.characters.count > 0 {
     
     leftButton.setImage(leftButtonImage, for: .normal)
     }
     
     leftButton.addTarget(cntr, action: #selector(SubCategoriesViewController.backLeftButtonTapped(_:)), for: .touchUpInside)
     let barbuttonitem1: UIBarButtonItem = UIBarButtonItem(customView: leftButton)
     let leftButton1: UIButton = UIButton(type: .custom)
     
     if backTitle.characters.count > 0 {
     
     let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height:leftButtonImage.size.height)
     let boundingBox =
     (backTitle as NSString).boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.fontRegularWithSize(18.0)], context: nil)
     
     leftButton1.frame = CGRect(x: 0, y: 0, width: boundingBox.width+leftButtonImage.size.width, height: boundingBox.height)
     
     } else {
     
     leftButton1.frame = CGRect(x: 0, y: 0, width: 0, height: leftButtonImage.size.height)
     }
     
     leftButton1.titleLabel?.textAlignment = .left
     leftButton1.setTitle(backTitle, for: .normal)
     //            leftButton1.addTarget(controller, action: #selector(ItemsViewController.backLeftButtonTapped(_:)), for: .touchUpInside)
     //
     
     
     cntr.navigationItem.leftBarButtonItems = [barbuttonitem1]
     
     }
     
     
     if  rightImage != "" && !rightImage.contains("ADD CLAIM") {
     
     //let rightButtonImage: UIImage = UIImage(named: rightImage!)!
     let rightButton: UIButton = UIButton(type: .custom)
     
     if (rightImage.characters.count) > 0
     {
     let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height:20.0)
     let boundingBox =
     (rightImage as NSString).boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.fontRegularWithSize(12.0)], context: nil)
     
     rightButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
     }else
     {
     rightButton.frame = CGRect.zero
     }
     rightButton.titleLabel?.textAlignment = .left
     rightButton.setImage(UIImage.init(named: rightImage), for: .normal)
     rightButton.contentMode = .scaleAspectFit
     
     rightButton.addTarget(cntr, action: #selector(SubCategoriesViewController.rightButtonTapped(_:)), for: .touchUpInside)
     
     let rightBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage.init(named: rightImage), style: .plain, target: cntr, action: #selector(SubCategoriesViewController.rightButtonTapped(_:)))
     let font = UIFont.systemFont(ofSize: 15)
     rightBarButtonItem.setTitleTextAttributes([NSFontAttributeName:font], for: .normal)
     let item3 = UIBarButtonItem(customView: rightButton)
     
     if(secondRightImage.characters.count > 0){
     
     let rightSeaButton: UIButton = UIButton(type: .custom)
     
     if (secondRightImage.characters.count) > 0
     {
     let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height:20.0)
     let boundingBox =
     (secondRightImage as NSString).boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.fontRegularWithSize(12.0)], context: nil)
     
     rightSeaButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
     }else
     {
     rightSeaButton.frame = CGRect.zero
     }
     rightSeaButton.titleLabel?.textAlignment = .right
     //  rightSeaButton.sizeToFit()
     rightSeaButton.setImage(UIImage.init(named: secondRightImage), for: .normal)
     rightSeaButton.contentMode = .scaleAspectFit
     
     rightSeaButton.addTarget(cntr, action: #selector(RecentlyViewedViewController.searchButtonTapped(_:)), for: .touchUpInside)
     
     let rightSearchItem: UIBarButtonItem = UIBarButtonItem(image: UIImage.init(named: secondRightImage), style: .plain, target: cntr, action: #selector(RecentlyViewedViewController.searchButtonTapped(_:)))
     let font = UIFont.systemFont(ofSize: 12)
     rightSearchItem.setTitleTextAttributes([NSFontAttributeName:font], for: .normal)
     
     let item2 = UIBarButtonItem(customView: rightSeaButton)
     
     let threeMenuButton: UIButton = UIButton(type: .custom)
     
     let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height:20.0)
     let boundingBox =
     (thirdRightImage as NSString).boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.fontRegularWithSize(12.0)], context: nil)
     
     threeMenuButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
     
     threeMenuButton.titleLabel?.textAlignment = .right
     // threeMenuButton.sizeToFit()
     threeMenuButton.setImage(UIImage.init(named: thirdRightImage), for: .normal)
     threeMenuButton.contentMode = .scaleAspectFit
     
     threeMenuButton.addTarget(cntr, action: #selector(WishListViewController.threeDotsClicked(_:)), for: .touchUpInside)
     
     let threeMenuButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage.init(named: thirdRightImage), style: .plain, target: cntr, action: #selector(RecentlyViewedViewController.searchButtonTapped(_:)))
     threeMenuButtonItem.setTitleTextAttributes([NSFontAttributeName:font], for: .normal)
     searchBar.isHidden = true
     let item1 = UIBarButtonItem(customView: threeMenuButton)
     cntr.navigationItem.rightBarButtonItems = [item2,item1,item3]
     }else{
     cntr.navigationItem.rightBarButtonItem = rightBarButtonItem
     }
     
     
     
     }
     else if(rightImage.contains("ADD CLAIM")){
     let rightButton: UIButton = UIButton(type: .custom)
     
     if (rightImage.characters.count) > 0
     {
     let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height:20.0)
     let boundingBox =
     (rightImage as NSString).boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.fontRegularWithSize(12.0)], context: nil)
     
     rightButton.frame = CGRect(x: 0, y: 0, width: boundingBox.width, height: boundingBox.height)
     }else
     {
     rightButton.frame = CGRect.zero
     }
     rightButton.titleLabel?.textAlignment = .left
     // rightButton.sizeToFit()
     rightButton.setTitle(rightImage, for: .normal)
     
     rightButton.addTarget(cntr, action: #selector(SubCategoriesViewController.rightButtonTapped(_:)), for: .touchUpInside)
     
     let rightBarButtonItem: UIBarButtonItem = UIBarButtonItem(title:rightImage, style: .plain, target: cntr, action: #selector(SubCategoriesViewController.rightButtonTapped(_:)))
     let font = UIFont.systemFont(ofSize: 13)
     rightBarButtonItem.setTitleTextAttributes([NSFontAttributeName:font], for: .normal)
     
     cntr.navigationItem.rightBarButtonItem = rightBarButtonItem
     
     }
     
     if(secondRightImage == "" && rightImage == ""){
     cntr.navigationItem.rightBarButtonItems = nil
     }
     
     
     cntr.navigationController!.navigationBar.isTranslucent = false
     cntr.navigationController!.isNavigationBarHidden = false
     cntr.navigationController!.navigationBar.barTintColor = NAVY_BLUE_COLOR
     cntr.navigationController!.navigationBar.tintColor = UIColor.white
     cntr.navigationItem.titleView = searchBar
     
     }
     
     
     class func setupNavBarWithSearch(backImage: String?,cntr: UIViewController,searchBar : UISearchBar, backTitle:String, rightImage: String ,hideSearchPlaceHolder : String,secondShowRightImage: String, secondRightImage: String, navTitle : String) {
     
     if(hideSearchPlaceHolder == "false" && secondRightImage != "Search"){
     searchBar.isHidden = false
     searchBar.placeholder = "Search by Item#, Description"
     let searchTextField = searchBar.value(forKey: "searchField") as? UITextField
     searchTextField?.textColor = UIColor.white
     searchTextField? .setValue(UIColor.white, forKeyPath: "_placeholderLabel.textColor")
     searchTextField?.backgroundColor = NAVY_BLUE_COLOR
     searchTextField?.tintColor = NAVY_BLUE_COLOR
     searchBar.barTintColor = NAVY_BLUE_COLOR
     let glassIconView = searchTextField?.leftView as! UIImageView
     glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
     glassIconView.tintColor = UIColor.white
     searchBar.sizeToFit()
     for subView in searchBar.subviews {
     for view in subView.subviews {
     if view.isKind(of:NSClassFromString("UIButton")!) {
     let cancelButton = view as! UIButton
     cancelButton.isEnabled = true
     cancelButton.setTitleColor(UIColor.white, for: .normal)
     }
     }
     }
     
     }else{
     searchBar.isHidden = true
     }
     
     
     
     var titlelabel: UILabel? = cntr.navigationController?.navigationBar.viewWithTag(555) as? UILabel
     
     if (titlelabel == nil) {
     
     titlelabel = UILabel(frame: CGRect(x: 50.0, y: 0, width: ScreenSize.SCREEN_WIDTH - 140, height: 44.0))
     titlelabel?.tag = 555
     titlelabel!.backgroundColor = UIColor.clear
     titlelabel!.font =  UIFont.fontBoldWithSize(15.0)
     titlelabel?.textAlignment = .left
     titlelabel!.textColor = UIColor.white
     
     
     
     cntr.navigationController?.navigationBar.addSubview(titlelabel!)
     }
     
     titlelabel!.text = navTitle
     
     if(cntr.navigationController != nil) {
     
     cntr.navigationController!.navigationBar.isTranslucent = false
     cntr.navigationController!.isNavigationBarHidden = false
     cntr.navigationController!.navigationBar.barTintColor = NAVY_BLUE_COLOR
     cntr.navigationController!.navigationBar.tintColor = UIColor.white
     cntr.navigationController?.navigationBar.barStyle = .black
     }
     
     
     
     if backImage != nil && backImage != "" {
     
     let leftButtonImage: UIImage = UIImage(named: backImage!)!
     let leftButton: UIButton = UIButton(type: .custom)
     leftButton.frame = CGRect(x: 0, y: 0, width: leftButtonImage.size.width, height: leftButtonImage.size.height)
     
     if backTitle.characters.count > 0 {
     
     leftButton.setImage(leftButtonImage, for: .normal)
     }
     
     leftButton.addTarget(cntr, action: #selector(SubCategoriesViewController.backLeftButtonTapped(_:)), for: .touchUpInside)
     
     let barbuttonitem1: UIBarButtonItem = UIBarButtonItem(customView: leftButton)
     let leftButton1: UIButton = UIButton(type: .custom)
     
     if backTitle.characters.count > 0 {
     
     let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height:leftButtonImage.size.height)
     let boundingBox =
     (backTitle as NSString).boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.fontRegularWithSize(18.0)], context: nil)
     
     leftButton1.frame = CGRect(x: 0, y: 0, width: boundingBox.width+leftButtonImage.size.width, height: boundingBox.height)
     
     } else {
     
     leftButton1.frame = CGRect(x: 0, y: 0, width: 0, height: leftButtonImage.size.height)
     }
     
     leftButton1.titleLabel?.textAlignment = .left
     leftButton1.setTitle(backTitle, for: .normal)
     //            leftButton1.addTarget(controller, action: #selector(ItemsViewController.backLeftButtonTapped(_:)), for: .touchUpInside)
     //
     
     
     cntr.navigationItem.leftBarButtonItems = [barbuttonitem1]
     
     }
     
     
     if  rightImage != "" && !rightImage.contains("ADD CLAIM") {
     
     //let rightButtonImage: UIImage = UIImage(named: rightImage!)!
     let rightButton: UIButton = UIButton(type: .custom)
     
     if (rightImage.characters.count) > 0
     {
     let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height:20.0)
     let boundingBox =
     (rightImage as NSString).boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.fontRegularWithSize(12.0)], context: nil)
     
     rightButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
     }else
     {
     rightButton.frame = CGRect.zero
     }
     rightButton.titleLabel?.textAlignment = .left
     //rightButton.sizeToFit()
     rightButton.setImage(UIImage.init(named: rightImage), for: .normal)
     
     rightButton.addTarget(cntr, action: #selector(SubCategoriesViewController.rightButtonTapped(_:)), for: .touchUpInside)
     
     let rightBarButtonItem: UIBarButtonItem = UIBarButtonItem(customView: rightButton)
     
     
     if(secondRightImage == "Search"){
     
     let rightSeaButton: UIButton = UIButton(type: .custom)
     
     if (secondRightImage.characters.count) > 0
     {
     let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height:20.0)
     let boundingBox =
     (secondRightImage as NSString).boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.fontRegularWithSize(12.0)], context: nil)
     
     rightSeaButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
     }else
     {
     rightSeaButton.frame = CGRect.zero
     }
     rightSeaButton.titleLabel?.textAlignment = .right
     rightSeaButton.sizeToFit()
     rightSeaButton.setImage(UIImage.init(named: secondRightImage), for: .normal)
     
     rightSeaButton.addTarget(cntr, action: #selector(RecentlyViewedViewController.searchButtonTapped(_:)), for: .touchUpInside)
     
     let rightSearchItem: UIBarButtonItem = UIBarButtonItem(customView: rightSeaButton)
     
     searchBar.isHidden = true
     cntr.navigationItem.rightBarButtonItems = [rightSearchItem,rightBarButtonItem]
     
     }else{
     cntr.navigationItem.rightBarButtonItem = rightBarButtonItem
     }
     
     
     
     }
     else if(rightImage.contains("ADD CLAIM")){
     let rightButton: UIButton = UIButton(type: .custom)
     
     if (rightImage.characters.count) > 0
     {
     let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height:20.0)
     let boundingBox =
     (rightImage as NSString).boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.fontRegularWithSize(12.0)], context: nil)
     
     rightButton.frame = CGRect(x: 0, y: 0, width: boundingBox.width, height: boundingBox.height)
     }else
     {
     rightButton.frame = CGRect.zero
     }
     rightButton.titleLabel?.textAlignment = .left
     //rightButton.sizeToFit()
     rightButton.setTitle(rightImage, for: .normal)
     
     rightButton.addTarget(cntr, action: #selector(SubCategoriesViewController.rightButtonTapped(_:)), for: .touchUpInside)
     
     let rightBarButtonItem: UIBarButtonItem = UIBarButtonItem(customView: rightButton)
     
     
     cntr.navigationItem.rightBarButtonItem = rightBarButtonItem
     
     }
     
     if(secondRightImage == "" && rightImage == ""){
     
     cntr.navigationItem.rightBarButtonItems = nil
     }
     
     
     cntr.navigationController!.navigationBar.isTranslucent = false
     cntr.navigationController!.isNavigationBarHidden = false
     cntr.navigationController!.navigationBar.barTintColor = NAVY_BLUE_COLOR
     cntr.navigationController!.navigationBar.tintColor = UIColor.white
     cntr.navigationItem.titleView = searchBar
     
     }
     
     class func setupNavBarColorInCntrWithColor(cntr: UIViewController,titleView: UIView?, withText title: String, rightImage: String) {
     
     var titlelabel: UILabel? = cntr.navigationController?.navigationBar.viewWithTag(555) as? UILabel
     
     if (titlelabel == nil) {
     
     titlelabel = UILabel(frame: CGRect(x: 50.0, y: 0, width: ScreenSize.SCREEN_WIDTH - 100, height: 44.0))
     titlelabel?.tag = 555
     titlelabel!.backgroundColor = UIColor.clear
     titlelabel!.font =  UIFont.fontRegularWithSize(15.0)
     titlelabel?.textAlignment = .center
     titlelabel!.textColor = UIColor.white
     
     
     cntr.navigationController?.navigationBar.addSubview(titlelabel!)
     }
     
     titlelabel!.text = title
     
     if(cntr.navigationController != nil) {
     
     cntr.navigationController!.navigationBar.isTranslucent = false
     cntr.navigationController!.isNavigationBarHidden = false
     cntr.navigationController!.navigationBar.barTintColor = NAVY_BLUE_COLOR
     cntr.navigationController!.navigationBar.tintColor = UIColor.white
     cntr.navigationController?.navigationBar.barStyle = .black
     }
     
     if  rightImage != "" {
     
     //let rightButtonImage: UIImage = UIImage(named: rightImage!)!
     
     
     //rightButton.addTarget(controller, action: #selector(ViewClaimsViewController.rightButtonTapped(_:)), for: .touchUpInside)
     
     let rightBarButtonItem: UIBarButtonItem = UIBarButtonItem.init(title: rightImage, style: .plain, target: self, action: nil)
     let font = UIFont.systemFont(ofSize: 15)
     rightBarButtonItem.setTitleTextAttributes([NSFontAttributeName:font], for: .normal)
     
     
     cntr.navigationItem.rightBarButtonItem = rightBarButtonItem
     }
     
     
     }
     
     class func setUpNavigationBarWithImage(backImage: String?, cntr: UIViewController, backTitle:String,  barTitle: String, rightImage: String) {
     
     var titlelabel: UILabel? = cntr.navigationController?.navigationBar.viewWithTag(555) as? UILabel
     
     if (titlelabel == nil) {
     
     titlelabel = UILabel(frame: CGRect(x: 50.0, y: 0, width: ScreenSize.SCREEN_WIDTH - 100, height: 44.0))
     titlelabel?.tag = 555
     titlelabel!.backgroundColor = UIColor.clear
     titlelabel!.font =  UIFont.fontRegularWithSize(15.0)
     titlelabel?.textAlignment = .center
     titlelabel!.textColor = UIColor.white
     titlelabel?.lineBreakMode = .byWordWrapping
     titlelabel?.numberOfLines = 0
     
     cntr.navigationController?.navigationBar.addSubview(titlelabel!)
     }
     
     titlelabel!.text = barTitle
     
     if(cntr.navigationController != nil) {
     
     cntr.navigationController!.navigationBar.isTranslucent = false
     cntr.navigationController!.isNavigationBarHidden = false
     cntr.navigationController!.navigationBar.barTintColor = NAVY_BLUE_COLOR
     cntr.navigationController!.navigationBar.tintColor = UIColor.white
     cntr.navigationController?.navigationBar.barStyle = .black
     }
     
     }
     
     
     class func getLeftBarButtonWithImageNTitle(imageName: String,cntr: UIViewController, lblTitle:String)
     {
     var buttonarray = NSMutableArray(capacity: 2)  as [AnyObject]
     //first left item
     
     let leftButtonImage: UIImage? = UIImage(named: imageName)
     let leftButton: UIButton = UIButton(type: .custom)
     leftButton.frame = CGRect(x: 0, y: 0, width: leftButtonImage?.size.width ?? 0, height: leftButtonImage?.size.height ?? 0)
     
     if lblTitle.characters.count > 0 {
     
     leftButton.setImage(leftButtonImage, for: .normal)
     }
     
     //        leftButton.addTarget(cntr, action: #selector(ItemsViewController.backLeftButtonTapped(_:)), for: .touchUpInside)
     
     let barbuttonitem1: UIBarButtonItem = UIBarButtonItem(customView: leftButton)
     buttonarray.append(barbuttonitem1)
     
     //space after first item
     
     let spacer: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
     buttonarray.append(spacer)
     //second left item
     let leftButton1: UIButton = UIButton(type: .custom)
     
     if lblTitle.characters.count > 0 {
     
     let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height:leftButtonImage?.size.height ?? 0)
     let boundingBox =
     (lblTitle as NSString).boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.fontRegularWithSize(18.0)], context: nil)
     
     let height = leftButtonImage?.size.height ?? CGFloat(0)
     
     leftButton1.frame = CGRect(x: 0, y: 0, width: boundingBox.width + height, height: boundingBox.height)
     }
     else
     {
     leftButton1.frame = CGRect(x: 0, y: 0, width: 0, height: leftButtonImage?.size.height ?? 0)
     }
     
     leftButton1.titleLabel?.textAlignment = .left
     leftButton1.setTitle(lblTitle, for: .normal)
     leftButton1.isUserInteractionEnabled = false
     
     let barbuttonitem2: UIBarButtonItem = UIBarButtonItem(customView: leftButton1)
     buttonarray.append(barbuttonitem2)
     
     cntr.navigationItem.leftBarButtonItems = [barbuttonitem1,spacer,barbuttonitem2]
     }
     
     class func getLeftBarButtonWithGreyTint(imageName: String,cntr: UIViewController, lblTitle:String) {
     
     //first left item
     
     let leftButtonImage: UIImage = UIImage(named: imageName)!
     let leftButton: UIButton = UIButton(type: .custom)
     leftButton.frame = CGRect(x: 0, y: 0, width: leftButtonImage.size.width, height: leftButtonImage.size.height)
     leftButton.setImage(leftButtonImage, for: .normal)
     //        leftButton.addTarget(cntr, action: #selector(ItemsViewController.backLeftButtonTapped(_:)), for: .touchUpInside)
     
     let barbuttonitem1: UIBarButtonItem = UIBarButtonItem(customView: leftButton)
     
     //space after first item
     
     let spacer: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
     
     //second left item
     let leftButton1: UIButton = UIButton(type: .custom)
     let size = (lblTitle as NSString).size(attributes: [NSFontAttributeName: UIFont.fontRegularWithSize(14.0)])
     leftButton1.frame = CGRect(x: 0, y: 0, width: size.width, height: leftButtonImage.size.height)
     leftButton1.setTitle(lblTitle, for: .normal)
     leftButton1.titleLabel?.font =  UIFont.fontRegularWithSize(14.0)
     leftButton1.titleLabel?.textAlignment = .left
     leftButton1.isUserInteractionEnabled = false
     let barbuttonitem2: UIBarButtonItem = UIBarButtonItem(customView: leftButton1)
     
     cntr.navigationItem.leftBarButtonItems = [barbuttonitem1,spacer,barbuttonitem2]
     }
     
     class func getLeftBarMemberButtonWithGreyTint(imageName: String,cntr: UIViewController, lblTitle:String) {
     
     //first left item
     
     let leftButtonImage: UIImage = UIImage(named: imageName)!
     let leftButton: UIButton = UIButton(type: .custom)
     leftButton.frame = CGRect(x: 0, y: 0, width: leftButtonImage.size.width, height: leftButtonImage.size.height)
     leftButton.setImage(leftButtonImage, for: .normal)
     leftButton.addTarget(cntr, action: Selector(("backLeftButtonTapped")), for: .touchUpInside)
     
     let barbuttonitem1: UIBarButtonItem = UIBarButtonItem(customView: leftButton)
     
     //space after first item
     
     let spacer: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
     
     //second left item
     let leftButton1: UIButton = UIButton(type: .custom)
     leftButton1.frame = CGRect(x: 0, y: 0, width: 250, height: leftButtonImage.size.height)
     leftButton1.setTitle(lblTitle, for: .normal)
     leftButton1.titleLabel?.font =  UIFont.fontRegularWithSize(14.0)
     leftButton1.titleLabel?.textAlignment = .left
     leftButton1.isUserInteractionEnabled = false
     let barbuttonitem2: UIBarButtonItem = UIBarButtonItem(customView: leftButton1)
     
     cntr.navigationItem.leftBarButtonItems = [barbuttonitem1,spacer,barbuttonitem2]
     }
     
     class func getRightBarButton(cntr: UIViewController, rightView:UIView) {
     
     var rightView1 = UIView(frame: CGRect(x: 0, y: 0, width: rightView.frame.size.width, height: rightView.frame.size.height))
     rightView1 = rightView
     let barbuttonitem2: UIBarButtonItem = UIBarButtonItem(customView: rightView1)
     cntr.navigationItem.rightBarButtonItem = barbuttonitem2
     }
     
     //MARK: - User Defaults Methods
     
     //Save User Name and Password
     
     class func saveUserNameAndPassword(userName: String, password: String , email: String ,isFromEmail : Bool) {
     
     //        Crashlytics.sharedInstance().setUserName(userName)
     //        Crashlytics.sharedInstance().setUserEmail(email)
     //        Crashlytics.sharedInstance().setUserIdentifier(userName)
     
     UserDefaults.standard.setValue(userName, forKey: kUserName)
     UserDefaults.standard.synchronize()
     
     UserDefaults.standard.setValue(password, forKey: kPassword)
     UserDefaults.standard.synchronize()
     
     UserDefaults.standard.setValue(email, forKey: kEmail)
     UserDefaults.standard.synchronize()
     
     UserDefaults.standard.setValue(isFromEmail, forKey: kIsFromMail)
     UserDefaults.standard.synchronize()
     
     
     
     loggingIn(true)
     
     //        do {
     //
     //            let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName, account: userName, accessGroup: KeychainConfiguration.accessGroup)
     //
     //
     //
     //            try passwordItem.savePassword(password)
     //
     //
     //        } catch {
     //            fatalError("Error updating keychain - \(error)")
     //        }
     }
     
     class func getUserNameAndPasswordFromLocalStorage() -> (userName: String?, password: String?) {
     
     let hasLoggedIn = hasLoggedInAlready()
     
     if hasLoggedIn {
     
     var username = ""
     var password = ""
     if UserDefaults.standard.value(forKey: kUserName) != nil{
     username = UserDefaults.standard.value(forKey: kUserName) as! String
     }
     if UserDefaults.standard.value(forKey: kPassword) != nil{
     password = UserDefaults.standard.value(forKey: kPassword) as! String
     }
     return (username, password)
     
     //            var passwordItems = [KeychainPasswordItem]()
     //
     //            do {
     //                passwordItems = try KeychainPasswordItem.passwordItems(forService: KeychainConfiguration.serviceName, accessGroup: KeychainConfiguration.accessGroup)
     //
     //                guard passwordItems.count <= 0 else {
     //
     //                    do {
     //
     //                        let passwordItem = passwordItems[0]
     //                        let userName = passwordItem.account
     //                        let password = try passwordItem.readPassword()
     //
     //                        return (userName, password)
     //
     //                    } catch {
     //                        fatalError("Error fetching password items - \(error)")
     //                    }
     //                }
     //
     //            } catch {
     //                fatalError("Error fetching password items - \(error)")
     //            }
     }
     
     return ("", "")
     }
     class func getEmail() -> String {
     
     let hasLoggedIn = hasLoggedInAlready()
     
     if hasLoggedIn {
     
     var email = ""
     
     let isMail = UserDefaults.standard.bool(forKey: kIsFromMail)
     
     if isMail == true{
     if UserDefaults.standard.value(forKey: kEmail) != nil{
     email = UserDefaults.standard.value(forKey: kEmail) as! String
     }
     }
     
     return (email)
     
     }
     
     return ("")
     }
     
     class func removeUserNamePassword() {
     
     
     if UserDefaults.standard.object(forKey: kUserName) != nil {
     UserDefaults.standard.removeObject(forKey: kUserName)
     UserDefaults.standard.synchronize()
     }
     if UserDefaults.standard.object(forKey: kPassword) != nil {
     UserDefaults.standard.removeObject(forKey: kPassword)
     UserDefaults.standard.synchronize()
     }
     
     
     if UserDefaults.standard.object(forKey: kEmail) != nil {
     UserDefaults.standard.removeObject(forKey: kEmail)
     UserDefaults.standard.synchronize()
     }
     
     //        do {
     //            let passwordItems = try KeychainPasswordItem.passwordItems(forService: KeychainConfiguration.serviceName, accessGroup: KeychainConfiguration.accessGroup)
     //
     //            guard passwordItems.count <= 0 else {
     //                let passwordItem = passwordItems[0]
     //
     //                do {
     //                    try passwordItem.deleteItem()
     //                }
     //                catch {
     //                    fatalError("Error deleting keychain item - \(error)")
     //                }
     //
     //                return
     //            }
     //
     //        } catch {
     //            fatalError("Error fetching password items - \(error)")
     //        }
     }
     
     //Save Authorization Details
     
     class func saveAccessToken(_ accessToken: String) {
     
     if let accessTokenData = accessToken.data(using: String.Encoding.utf8) {
     
     let encryptedAccessToken = RNCryptor.encrypt(data: accessTokenData, withPassword: kAuthTokenKey)
     UserDefaults.standard.setValue(encryptedAccessToken, forKey: kAccessToken)
     UserDefaults.standard.synchronize()
     }
     }
     
     class func getAccessToken() -> String {
     
     if let accessTokenData = UserDefaults.standard.value(forKey: kAccessToken) as? Data {
     
     do {
     
     let decryptedAccessToken = try RNCryptor.decrypt(data: accessTokenData, withPassword: kAuthTokenKey)
     
     if let accessToken = String.init(data: decryptedAccessToken, encoding: String.Encoding.utf8) {
     
     return accessToken
     }
     
     } catch {
     
     fatalError("Error fetching password items - \(error)")
     }
     }
     
     return ""
     }
     
     class func saveTokenType(_ tokenType: String) {
     
     UserDefaults.standard.setValue(tokenType, forKey: kTokenType)
     UserDefaults.standard.synchronize()
     }
     
     class func getTokenType() -> String {
     
     let tokenType = UserDefaults.standard.value(forKey: kTokenType) as? String
     
     if tokenType == nil {
     
     return ""
     
     } else {
     
     return tokenType!
     }
     }
     
     class func saveCustomerName(_ customerName: String) {
     
     UserDefaults.standard.setValue(customerName, forKey: kCustName)
     UserDefaults.standard.synchronize()
     }
     
     class func saveInternalUse(_ stringName: String) {
     
     UserDefaults.standard.setValue(stringName, forKey: kInternalUse)
     UserDefaults.standard.synchronize()
     }
     
     class func getSalesRepName() -> String {
     
     let tokenType = UserDefaults.standard.value(forKey: kSalesRepName) as? String
     
     if tokenType == nil {
     
     return ""
     
     } else {
     
     let salesRepName : String = tokenType!
     return salesRepName
     }
     }
     class func getInternalUse() -> String {
     
     let tokenType = UserDefaults.standard.value(forKey: kInternalUse) as? String
     
     if tokenType == nil {
     
     return ""
     
     } else {
     
     let internalUse : String = tokenType!
     return internalUse
     }
     }
     
     //Custom Components Removed after app quit
     
     class func loggingIn(_ loginIn: Bool) {
     
     UserDefaults.standard.setValue(loginIn, forKey: kHasLoggedIn)
     UserDefaults.standard.synchronize()
     }
     
     class func hasLoggedInAlready() -> Bool {
     
     if let hasLoggedIn = UserDefaults.standard.value(forKey: kHasLoggedIn) as? Bool {
     
     if hasLoggedIn == false {
     
     removeUserNamePassword()
     }
     
     return hasLoggedIn
     }
     
     removeUserNamePassword()
     return false
     }
     
     class func resetParamsOnApplicationDidTerminate() {
     
     if UserDefaults.standard.object(forKey: kSamples) != nil {
     
     UserDefaults.standard.removeObject(forKey: kSamples)
     UserDefaults.standard.synchronize()
     }
     if UserDefaults.standard.object(forKey: kShowName) != nil {
     
     UserDefaults.standard.removeObject(forKey: kShowName)
     UserDefaults.standard.synchronize()
     }
     
     }
     //Previous Customers In Customer Lookup
     class func saveCustomers(_ text: String) {
     
     if(text.isEmpty){
     return
     }
     
     var arr :[String] = []
     guard UserDefaults.standard.array(forKey: kPreviousCustomers) != nil else {
     for arrElement in arr {
     if arrElement.lowercased() == text.lowercased() {
     return
     }
     }
     arr.append(text)
     arr.append("Clear history")
     UserDefaults.standard.setValue(arr, forKey: kPreviousCustomers)
     return
     }
     
     arr = UserDefaults.standard.array(forKey: kPreviousCustomers) as! [String]
     if let index = arr.index(of: "Clear history") {
     arr.remove(at: index)
     }
     
     for arrElement in arr {
     if arrElement.lowercased() == text.lowercased() {
     return
     }
     }
     
     if arr.count > 10 {
     arr.remove(at: 9)
     }
     arr.insert(text, at: 0)
     if(arr.count > 0){
     arr.append("Clear history")
     }
     UserDefaults.standard.setValue(arr, forKey: kPreviousCustomers)
     }
     
     class func getPreviousCustomers() -> [String] {
     
     guard let customers = UserDefaults.standard.array(forKey: kPreviousCustomers) else {
     return []
     }
     return customers as! [String]
     }
     
     //MARK: - Convert Format From PDF To Image
     
     func drawPDFfromURL(url: NSURL) -> UIImage? {
     
     guard let document = CGPDFDocument(url) else { return nil }
     guard let page = document.page(at: 1) else { return nil }
     
     let pageRect = page.getBoxRect(.mediaBox)
     
     UIGraphicsBeginImageContextWithOptions(pageRect.size, true, 0)
     let context = UIGraphicsGetCurrentContext()
     
     context!.setFillColor(UIColor.white.cgColor)
     context!.fill(pageRect)
     
     context!.translateBy(x: 0.0, y: pageRect.size.height)
     context!.scaleBy(x: 1.0, y: -1.0)
     
     context!.drawPDFPage(page)
     let img = UIGraphicsGetImageFromCurrentImageContext()
     
     UIGraphicsEndImageContext()
     
     return img
     }
     }
     
     
     //MARK: - Extensions
     
     extension UIDevice {
     
     var modelName: String {
     var systemInfo = utsname()
     uname(&systemInfo)
     let machineMirror = Mirror(reflecting: systemInfo.machine)
     let identifier = machineMirror.children.reduce("") { identifier, element in
     guard let value = element.value as? Int8, value != 0 else { return identifier }
     return identifier + String(UnicodeScalar(UInt8(value)))
     }
     
     switch identifier {
     case "iPod5,1":                                 return "iPod Touch 5"
     case "iPod7,1":                                 return "iPod Touch 6"
     case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
     case "iPhone4,1":                               return "iPhone 4s"
     case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
     case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
     case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
     case "iPhone7,2":                               return "iPhone 6"
     case "iPhone7,1":                               return "iPhone 6 Plus"
     case "iPhone8,1":                               return "iPhone 6s"
     case "iPhone8,2":                               return "iPhone 6s Plus"
     case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
     case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
     case "iPhone8,4":                               return "iPhone SE"
     case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
     case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
     case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
     case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
     case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
     case "iPad6,11", "iPad6,12":                    return "iPad 5"
     case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
     case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
     case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
     case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
     case "iPad6,3", "iPad6,4":                      return "iPad Pro 9.7 Inch"
     case "iPad6,7", "iPad6,8":                      return "iPad Pro 12.9 Inch"
     case "iPad7,1", "iPad7,2":                      return "iPad Pro 12.9 Inch 2. Generation"
     case "iPad7,3", "iPad7,4":                      return "iPad Pro 10.5 Inch"
     case "AppleTV5,3":                              return "Apple TV"
     case "i386", "x86_64":                          return "Simulator"
     default:                                        return identifier
     }
     }
     
     }
     
     extension UITabBarController {
     
     
     
     func setBadges(badgeValues: [Int]) {
     
     for view in self.tabBar.subviews {
     if view is CustomTabBadge {
     view.removeFromSuperview()
     }
     
     if view is CustomTabCartBadge {
     view.removeFromSuperview()
     }
     }
     
     for index in 0...badgeValues.count-1 {
     if badgeValues[index] != 0 {
     addBadge(index: index, value: badgeValues[index], color: UIColor.blue, font: UIFont(name: "Helvetica-Light", size: 11)!)
     }
     }
     }
     
     func addBadge(index: Int, value: Int, color: UIColor, font: UIFont) {
     
     let badgeView = CustomTabBadge()
     
     badgeView.clipsToBounds = true
     badgeView.textColor = UIColor.white
     badgeView.textAlignment = .center
     badgeView.font = font
     badgeView.text = String(value)
     badgeView.backgroundColor = color
     badgeView.tag = index
     tabBar.addSubview(badgeView)
     
     self.positionBadges()
     }
     
     func addBadgeForCart(index: Int, value: Int, color: UIColor, font: UIFont) {
     
     let badgeView = CustomTabCartBadge()
     
     badgeView.clipsToBounds = true
     badgeView.textColor = UIColor.white
     badgeView.textAlignment = .center
     badgeView.font = font
     badgeView.text = String(value)
     badgeView.backgroundColor = color
     badgeView.tag = index
     tabBar.addSubview(badgeView)
     
     self.positionBadges()
     }
     
     
     
     override open func viewDidLayoutSubviews() {
     super.viewDidLayoutSubviews()
     self.positionBadges()
     }
     
     // Positioning
     func positionBadges() {
     
     var tabbarButtons = self.tabBar.subviews.filter { (view: UIView) -> Bool in
     return view.isUserInteractionEnabled // only UITabBarButton are userInteractionEnabled
     }
     
     tabbarButtons = tabbarButtons.sorted(by: { $0.frame.origin.x < $1.frame.origin.x })
     
     for view in self.tabBar.subviews {
     if view is CustomTabBadge {
     let badgeView = view as! CustomTabBadge
     self.positionBadge(badgeView: badgeView, items:tabbarButtons, index: badgeView.tag)
     }
     if view is CustomTabCartBadge {
     let badgeView = view as! CustomTabCartBadge
     self.positionBadge(badgeView: badgeView, items:tabbarButtons, index: badgeView.tag)
     }
     }
     }
     
     func positionBadge(badgeView: UIView, items: [UIView], index: Int) {
     
     let itemView = items[index]
     let center = itemView.center
     
     let xOffset: CGFloat = 18
     let yOffset: CGFloat = -14
     badgeView.frame.size = CGSize(width: 20, height: 20)
     badgeView.center = CGPoint(x: center.x + xOffset, y: center.y + yOffset)
     badgeView.layer.cornerRadius = badgeView.bounds.width/2
     tabBar.bringSubview(toFront: badgeView)
     }
     }
     
     class CustomTabBadge: UILabel {}
     
     class CustomTabCartBadge: UILabel {}
     
     extension UIApplication {
     class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
     if let navigationController = controller as? UINavigationController {
     return topViewController(controller: navigationController.visibleViewController)
     }
     if let tabController = controller as? UITabBarController {
     if let selected = tabController.selectedViewController {
     return topViewController(controller: selected)
     }
     }
     if let presented = controller?.presentedViewController {
     return topViewController(controller: presented)
     }
     return controller
     }
     }
     
     
     extension UIColor {
     convenience init(hexString: String) {
     let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
     var int = UInt32()
     Scanner(string: hex).scanHexInt32(&int)
     let a, r, g, b: UInt32
     switch hex.characters.count {
     case 3: // RGB (12-bit)
     (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
     case 6: // RGB (24-bit)
     (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
     case 8: // ARGB (32-bit)
     (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
     default:
     (a, r, g, b) = (255, 0, 0, 0)
     }
     self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
     }
     }
     
     
     func format(phoneNumber sourcePhoneNumber: String) -> String? {
     
     // Remove any character that is not a number
     if(sourcePhoneNumber.characters.count == 10){
     let numbersOnly = sourcePhoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
     let length = numbersOnly.characters.count
     let hasLeadingOne = false
     
     // Check for supported phone number length
     guard length == 7 || length == 10 || (length == 11 && hasLeadingOne) else {
     return nil
     }
     
     let hasAreaCode = (length >= 10)
     var sourceIndex = 0
     
     // Leading 1
     var leadingOne = ""
     if hasLeadingOne {
     leadingOne = "1 "
     sourceIndex += 1
     }
     
     // Area code
     var areaCode = ""
     if hasAreaCode {
     let areaCodeLength = 3
     guard let areaCodeSubstring = numbersOnly.characters.substring(start: sourceIndex, offsetBy: areaCodeLength) else {
     return nil
     }
     areaCode = String(format: "(%@) ", areaCodeSubstring)
     sourceIndex += areaCodeLength
     }
     
     // Prefix, 3 characters
     let prefixLength = 3
     guard let prefix = numbersOnly.characters.substring(start: sourceIndex, offsetBy: prefixLength) else {
     return nil
     }
     sourceIndex += prefixLength
     
     // Suffix, 4 characters
     let suffixLength = 4
     guard let suffix = numbersOnly.characters.substring(start: sourceIndex, offsetBy: suffixLength) else {
     return nil
     }
     
     return leadingOne + areaCode + prefix + "-" + suffix
     }
     return sourcePhoneNumber
     }
     
     extension String.CharacterView {
     /// This method makes it easier extract a substring by character index where a character is viewed as a human-readable character (grapheme cluster).
     internal func substring(start: Int, offsetBy: Int) -> String? {
     guard let substringStartIndex = self.index(startIndex, offsetBy: start, limitedBy: endIndex) else {
     return nil
     }
     
     guard let substringEndIndex = self.index(startIndex, offsetBy: start + offsetBy, limitedBy: endIndex) else {
     return nil
     }
     
     return String(self[substringStartIndex ..< substringEndIndex])
     }
     }
     
     extension String {
     public var validPhoneNumber:Bool {
     let types:NSTextCheckingResult.CheckingType = [.phoneNumber]
     guard let detector = try? NSDataDetector(types: types.rawValue) else { return false }
     
     if let match = detector.matches(in: self, options: [], range: NSMakeRange(0, characters.count)).first?.phoneNumber {
     return match == self
     }else{
     return false
     }
     }
     func removingWhitespaces() -> String {
     return components(separatedBy: .whitespaces).joined()
     }
     }
     extension UIButton {
     override open func point(inside point: CGPoint, with _: UIEvent?) -> Bool {
     let margin: CGFloat = 10
     let area = self.bounds.insetBy(dx: -margin, dy: -margin)
     return area.contains(point)
     }
     }
     extension UILabel {
     override open func point(inside point: CGPoint, with _: UIEvent?) -> Bool {
     let margin: CGFloat = 5
     let area = self.bounds.insetBy(dx: -margin, dy: -margin)
     return area.contains(point)
     }
     /// Returns the String displayed in the first line of the UILabel or "" if text or font is missing
     var firstLineString: String {
     
     guard let text = self.text else { return "" }
     guard let font = self.font else { return "" }
     let rect = self.frame
     
     let attStr = NSMutableAttributedString(string: text)
     attStr.addAttribute(String(kCTFontAttributeName), value: CTFontCreateWithName(font.fontName as CFString, font.pointSize, nil), range: NSMakeRange(0, attStr.length))
     
     let frameSetter = CTFramesetterCreateWithAttributedString(attStr as CFAttributedString)
     let path = CGMutablePath()
     path.addRect(CGRect(x: 0, y: 0, width: rect.size.width + 7, height: 100))
     let frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, nil)
     
     guard let line = (CTFrameGetLines(frame) as! [CTLine]).first else { return "" }
     let lineString = text[text.startIndex...text.index(text.startIndex, offsetBy: CTLineGetStringRange(line).length-2)]
     
     return lineString
     }
     var numberOfVisibleLines: Int {
     let textSize = CGSize(width: CGFloat(self.frame.size.width), height: CGFloat(MAXFLOAT))
     let rHeight: Int = lroundf(Float(self.sizeThatFits(textSize).height))
     let charSize: Int = lroundf(Float(self.font.pointSize))
     return rHeight / charSize
     }
     }
     enum CardType: String {
     case Unknown, Amex, Visa, MasterCard, Diners, Discover, JCB, Elo, Hipercard, UnionPay
     
     static let allCards = [Amex, Visa, MasterCard, Diners, Discover, JCB, Elo, Hipercard, UnionPay]
     
     var regex : String {
     switch self {
     case .Amex:
     return "^3[47][0-9]{5,}$"
     case .Visa:
     return "^4[0-9]{6,}([0-9]{3})?$"
     case .MasterCard:
     return "^(5[1-5][0-9]{4}|677189)[0-9]{5,}$"
     case .Diners:
     return "^3(?:0[0-5]|[68][0-9])[0-9]{4,}$"
     case .Discover:
     return "^6(?:011|5[0-9]{2})[0-9]{3,}$"
     case .JCB:
     return "^(?:2131|1800|35[0-9]{3})[0-9]{3,}$"
     case .UnionPay:
     return "^(62|88)[0-9]{5,}$"
     case .Hipercard:
     return "^(606282|3841)[0-9]{5,}$"
     case .Elo:
     return "^((((636368)|(438935)|(504175)|(451416)|(636297))[0-9]{0,10})|((5067)|(4576)|(4011))[0-9]{0,12})$"
     default:
     return ""
     }
     }
     }
     
     
     extension Date {
     func toString(format: String) -> String {
     let dateFormatter = DateFormatter()
     dateFormatter.dateFormat = format
     return dateFormatter.string(from: self)
     }
     }
     func checkCardNumber(input: String) -> String {
     // Get only numbers from the input string
     let numberOnly = input.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
     
     var type: CardType = .Unknown
     var formatted = ""
     
     // detect card type
     for card in CardType.allCards {
     if (matchesRegex(regex: card.regex, text: numberOnly)) {
     type = card
     break
     }
     }
     
     
     
     // format
     var formatted4 = ""
     for character in numberOnly.characters {
     if formatted4.characters.count == 4 {
     formatted += formatted4 + " "
     formatted4 = ""
     }
     formatted4.append(character)
     }
     
     formatted += formatted4 // the rest
     
     // return the tuple
     return formatted
     }
     
     func matchesRegex(regex: String!, text: String!) -> Bool {
     do {
     let regex = try NSRegularExpression(pattern: regex, options: [.caseInsensitive])
     let nsString = text as NSString
     let match = regex.firstMatch(in: text, options: [], range: NSMakeRange(0, nsString.length))
     return (match != nil)
     } catch {
     return false
     }
     }
     
     
     func compareString(string1:String , string2:String) -> String{
     
     var  imageString = ""
     
     let firstString = string1.trimmingCharacters(in: CharacterSet(charactersIn: "$"))
     
     let secondString = string2.trimmingCharacters(in: CharacterSet(charactersIn: "$"))
     
     if (Int(firstString)! == 0 && Int(secondString)! == 0){
     
     imageString = ""
     }
     else if(Int(firstString)! > Int(secondString)!){
     
     imageString = "Down_Arrow"
     
     }else if (Int(firstString)! < Int(secondString)!){
     
     imageString = "Up_Arrow"
     
     }else if (Int(firstString)! == Int(secondString)!){
     
     imageString = "Equal_Arrow"
     
     }
     return imageString
     }
     
     //MARK: String Extensions
     
     extension String {
     
     func isValidEmailAddress() -> Bool {
     
     do {
     
     let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
     return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil
     
     } catch {
     
     return false
     }
     }
     
     func capitalizingFirstLetter() -> String {
     
     let first = String(characters.prefix(1)).capitalized
     let other = String(characters.dropFirst())
     return first + other
     }
     
     func allowCharactersAndSpacesOnly() -> String {
     
     let characterSet = CharacterSet.init(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ").inverted
     let trimmedString = self.components(separatedBy: characterSet).joined(separator: "")
     
     return trimmedString
     }
     
     func disableSpecialCharacters() -> Bool? {
     
     let ACCEPTABLE_CHARACTERS  = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
     let characterSet = NSCharacterSet.init(charactersIn: ACCEPTABLE_CHARACTERS).inverted
     let filteredString = self.components(separatedBy: characterSet).joined(separator: "")
     return filteredString == self
     }
     
     mutating func capitalizeFirstLetter() {
     
     self = self.capitalizingFirstLetter()
     }
     
     func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
     let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
     let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
     
     return boundingBox.height
     }
     
     /// Encode a String to Base64
     func toBase64() -> String {
     return Data(self.utf8).base64EncodedString()
     }
     
     /// Decode a String from Base64. Returns nil if unsuccessful.
     func fromBase64() -> String? {
     guard let data = Data(base64Encoded: self) else { return nil }
     return String(data: data, encoding: .utf8)
     }
     func htmlAttributedString() -> NSAttributedString? {
     guard let data = self.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
     guard let html = try? NSMutableAttributedString(
     data: data,
     options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
     documentAttributes: nil) else { return nil }
     return html
     }
     public func getAcronyms(separator: String = "") -> String
     {
     let acronyms = self.components(separatedBy: " ").map({ String($0.characters.first!) }).joined(separator: separator);
     return acronyms;
     }
     }
     
     
     //MARK: NSError Extensions
     
     extension NSError {
     
     static func createError(_ code: Int, description: String) -> NSError {
     return NSError(domain: "com.YoungsInc.Youngs-Inc",
     code: 400,
     userInfo: [
     "NSLocalizedDescription" : description
     ])
     }
     }
     
     extension NSMutableAttributedString{
     func setColorForText(_ textToFind: String, with color: UIColor) {
     let range = self.mutableString.range(of: textToFind, options: .caseInsensitive)
     if range.location != NSNotFound {
     addAttribute(NSForegroundColorAttributeName, value: color, range: range)
     }
     }
     }
     //MARK: UIFont Extensions
     
     extension UIFont {
     
     static func fontBoldWithSize(_ sizes : CGFloat) -> UIFont {
     
     return UIFont(name: "HelveticaNeue-Bold", size: sizes)!
     }
     static func fontRegularWithSize(_ sizes : CGFloat) -> UIFont {
     
     return UIFont(name: "HelveticaNeue", size: sizes)!
     }
     
     static func fontItalicWithSize(_ sizes : CGFloat) -> UIFont {
     
     return UIFont(name: "HelveticaNeue-Italic", size: sizes)!
     }
     
     static func fontSemiBoldWithSize(_ sizes : CGFloat) -> UIFont {
     
     return UIFont(name: "HelveticaNeue-Medium", size: sizes)!
     }
     static func fontLightWithSize(_ sizes : CGFloat) -> UIFont {
     
     return UIFont(name: "HelveticaNeue-Light", size: sizes)!
     }
     static func fontCondensedBlackWithSize(_ sizes : CGFloat) -> UIFont {
     
     return UIFont(name: "HelveticaNeue-CondensedBlack", size: sizes)!
     }
     }
     
     //MARK: - NSData Extensions
     
     extension NSMutableData {
     
     func appendInt32(value : Int32) {
     var val = value.bigEndian
     self.append(&val, length: MemoryLayout.size(ofValue: val))
     }
     
     func appendInt16(value : Int16) {
     var val = value.bigEndian
     self.append(&val, length: MemoryLayout.size(ofValue: val))
     }
     
     func appendInt8(value : Int8) {
     var val = value
     self.append(&val, length: MemoryLayout.size(ofValue: val))
     }
     
     func appendString(value : String) {
     value.withCString {
     self.append($0, length: Int(strlen($0)) + 1)
     }
     }
     }
     
     //MARK: - UISearchBar Extensions
     
     extension UISearchBar {
     
     func disableEmojis() -> Bool? {
     
     if self.isFirstResponder {
     
     if self.textInputMode?.primaryLanguage == "emoji" || self.textInputMode?.primaryLanguage == nil {
     
     return false
     }
     }
     
     return nil
     }
     }
     
     //MARK: - UITextField Extensions
     
     extension UITextField {
     
     func disableEmojis() -> Bool? {
     
     if self.isFirstResponder {
     
     if self.textInputMode?.primaryLanguage == "emoji" || self.textInputMode?.primaryLanguage == nil {
     
     return false
     }
     }
     
     return nil
     }
     
     func validateMaxValue(textField: UITextField, maxValue: Int, range: NSRange, replacementString string: String) -> Bool {
     
     let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
     
     //if delete all characteres from textfield
     if(newString.isEmpty) {
     return true
     }
     
     //check if the string is a valid number
     let numberValue = Int(newString)
     
     if(numberValue == nil) {
     return false
     }
     
     return numberValue! <= maxValue
     }
     }
     
     extension UITextView
     {
     func disableEmojis() -> Bool? {
     
     if self.isFirstResponder {
     
     if self.textInputMode?.primaryLanguage == "emoji" || self.textInputMode?.primaryLanguage == nil {
     
     return false
     }
     }
     
     return nil
     }
     
     }
     
     //MARK: - UIViewController Extesions
     
     extension UIViewController {
     func showHud(_ message: String) {
     SVProgressHUD.show(withStatus: message)
     SVProgressHUD.setDefaultStyle(.custom)
     SVProgressHUD.setForegroundColor(UIColor.white)
     SVProgressHUD.setBackgroundColor(UIColor.lightGray)
     UIApplication.shared.beginIgnoringInteractionEvents()
     }
     
     func hideHUD() {
     SVProgressHUD.dismiss()
     UIApplication.shared.endIgnoringInteractionEvents()
     
     }
     }
     
     //MARK: - UIView Extensions
     
     extension UIView {
     
     func makeRoundedCornerWithRadius(_ radius :CGFloat) {
     
     self.layer.cornerRadius = radius
     self.layer.masksToBounds = true
     }
     
     func makeViewCornerRound(radius : CGFloat) {
     
     self.layer.borderWidth = 1
     self.layer.cornerRadius = radius
     self.layer.masksToBounds = true
     self.layer.borderColor = UIColor.white.cgColor
     
     }
     
     func makeViewCornerRoundWithLightGray(radius : CGFloat) {
     
     self.layer.borderWidth = 0.5
     self.layer.cornerRadius = radius
     self.layer.masksToBounds = true
     self.layer.borderColor = UIColor.lightGray.cgColor
     
     }
     
     func addDashedBorder() {
     
     self.layoutIfNeeded()
     let color = UIColor.lightGray.cgColor
     
     let shapeLayer:CAShapeLayer = CAShapeLayer()
     let frameSize = self.frame.size
     let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: 0)
     
     shapeLayer.bounds = shapeRect
     shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height)
     shapeLayer.fillColor = UIColor.clear.cgColor
     shapeLayer.strokeColor = color
     shapeLayer.lineWidth = 0.50
     shapeLayer.lineJoin = kCALineJoinRound
     
     shapeLayer.lineDashPattern = [3,2]
     shapeLayer.path = UIBezierPath(roundedRect:  CGRect(x: 0, y: shapeRect.height, width: shapeRect.width, height: 0), cornerRadius: 0).cgPath
     
     
     self.layer.addSublayer(shapeLayer)
     
     }
     
     func addTopBorderWithColor(color: UIColor, width: CGFloat) {
     let border = CALayer()
     border.backgroundColor = color.cgColor
     border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: width)
     self.layer.addSublayer(border)
     }
     
     
     func makeRoundCornersWithBorderColor(_ color: UIColor, borderWidth: CGFloat, radius: CGFloat) {
     
     self.layer.borderWidth = borderWidth
     self.layer.cornerRadius = radius
     self.layer.masksToBounds = true
     self.layer.borderColor = color.cgColor
     }
     
     func slideAnimateViewToShow(transParentView : UIView? , superView superview: UIView)
     {
     if transParentView != nil
     {
     transParentView!.isHidden = false
     }
     self.frame = CGRect(x: 0.0,
     y: superview.bounds.size.height+1,
     width: self.frame.size.width,
     height: self.frame.size.height)
     
     let y = (superview.frame.size.height) - self.frame.size.height
     
     UIView.animate(withDuration: 0.3,
     delay: 0.0,
     options: UIViewAnimationOptions.curveLinear,
     animations: { () -> Void in
     
     self.frame = CGRect(x: 0,
     y: y,
     width: UIScreen.main.bounds.size.width,
     height: self.frame.size.height)
     
     }) { (finished) -> Void in
     if transParentView != nil
     {
     UIView.animate(withDuration: 0.2, animations: { () -> Void in
     transParentView!.backgroundColor = UIColor(white: 0, alpha: 0.5)
     })
     }
     
     }
     self.isHidden = false
     
     }
     
     
     func slideAnimateViewToHide(transParentView : UIView? , superView superview: UIView) {
     
     UIView.animate(withDuration: 0.3,
     delay: 0.0,
     options: UIViewAnimationOptions.curveLinear,
     animations: { () -> Void in
     
     self.frame = CGRect(x: 0.0,
     y: UIScreen.main.bounds.size.height+1,
     width: UIScreen.main.bounds.size.width,
     height: self.frame.size.height)
     
     }) { (finished) -> Void in
     if transParentView != nil
     {
     transParentView!.isHidden = true
     }
     }
     }
     
     func applyAllSideShadow(radius : CGFloat , opacity: Float, shadowRadius: CGFloat) {
     
     let radius: CGFloat = self.frame.width / 2.0 //change it to .height if you need spread for height
     let shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 2.1 * radius, height: self.frame.height))
     //Change 2.1 to amount of spread you need and for height replace the code for height
     
     self.layer.cornerRadius = 5
     self.layer.shadowColor = UIColor.black.cgColor
     self.layer.shadowOffset = CGSize(width: -0.2, height: -0.2)  //Here you control x and y
     self.layer.shadowOpacity = 0.3
     self.layer.shadowRadius = 0.3 //Here your control your blur
     self.layer.masksToBounds =  false
     self.layer.shadowPath = shadowPath.cgPath
     }
     
     func dropShadow() {
     
     self.layer.masksToBounds = false
     self.layer.shadowColor = UIColor.black.cgColor
     self.layer.shadowOpacity = 0.3
     self.layer.shadowOffset = CGSize(width: 0, height: 0)
     
     
     self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
     self.layer.shouldRasterize = true
     
     self.layer.rasterizationScale = UIScreen.main.scale
     
     }
     
     func removeAllSideShadow() {
     
     let rect = self.bounds.insetBy(dx: 1, dy: 1)
     let shadowPath = UIBezierPath(rect: rect)
     
     self.layer.cornerRadius = 0
     self.layer.shadowColor = UIColor.clear.cgColor
     self.layer.shadowOpacity = 0
     self.layer.shadowRadius = 0.0
     self.layer.shadowPath = shadowPath.cgPath
     
     self.layer.shadowOffset = CGSize(width: 0 , height: 0)
     }
     
     }
     
     //MARK: - Date Extensions
     
     extension Date {
     
     func getDateStringInYYYY_MM_dd(_ date : Date) -> String {
     
     let formatter  = DateFormatter()
     let enUSPOSIXLocale:NSLocale=NSLocale(localeIdentifier: "en_US_POSIX")
     formatter.locale=enUSPOSIXLocale as Locale!
     formatter.timeZone = NSTimeZone(name: "GMT") as TimeZone!
     formatter.dateFormat = "YYYY/MM/dd"
     return formatter.string(from: date)
     }
     
     func lastDayOfYear(_ date: Date) -> Date {
     
     let calendar = Calendar.current
     let dayRange = calendar.range(of: .day, in: .year, for: date)
     let dayCount = dayRange?.count
     var comp = calendar.dateComponents([.year, .month, .day], from: date)
     
     comp.day = dayCount
     
     return calendar.date(from: comp)!
     }
     
     func startOfMonth() -> Date? {
     
     let comp: DateComponents = Calendar.current.dateComponents([.year, .month, .hour], from: Calendar.current.startOfDay(for: self))
     return Calendar.current.date(from: comp)!
     }
     
     func endOfMonth() -> Date? {
     
     var comp: DateComponents = Calendar.current.dateComponents([.month, .day, .hour], from: Calendar.current.startOfDay(for: self))
     comp.month = 1
     comp.day = -1
     return Calendar.current.date(byAdding: comp, to: self.startOfMonth()!)
     }
     }
     
 */

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
