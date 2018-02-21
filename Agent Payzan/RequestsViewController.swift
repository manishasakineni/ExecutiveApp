//
//  RequestsViewController.swift
//  Agent Payzan
//
//  Created by Nani Mac on 18/10/17.
//  Copyright © 2017 Naveen. All rights reserved.
//

import UIKit

class RequestsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UISearchResultsUpdating,UISearchBarDelegate{
    
    
    @IBOutlet weak var headerImgHeight: NSLayoutConstraint!
    
    @IBOutlet weak var headerImgVW: UIImageView!
    
    @IBOutlet weak var requesttableView: UITableView!
    
    var agentReqMobileNo = String()
    
    var marginX:CGFloat!
    var marginY:CGFloat!
    var rect = CGRect()
    var customView = UITextView()
    
      let textView = UITextView()
    
    var PageIndex = 0
    
    var updateAgentArr :  Array<Int> = Array()
    
    var totalPages : Int? = 0
    
    var  totalRecords : Int? = 0
    
    var agentDetailsArray = [AgentReqInfoParamsAPIModel]()
    
    var filteredAgentArr = [AgentReqInfoParamsAPIModel]()

    let searchController = UISearchController(searchResultsController: nil)
    
    var statusTypeIdd:String!
    
    var userID : String = ""
    
    var errorLabel = UILabel()
    
    var serviceController = ServiceController()
    
     var refresher:UIRefreshControl!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.errorLabel = UILabel(frame: CGRect(x: 40, y: 0, width: 200, height: 22))
        
        customView.backgroundColor = UIColor.clear
        
       
        
      //  textView.delegate = self
        
        customView.autocorrectionType = .no
        
        let defaults = UserDefaults.standard
        
        if let userid = defaults.string(forKey: AId) {
            
            userID = userid
            
            print("defaults savedString: \(userID)")
        }
        
        
        
        self.searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
       // definesPresentationContext = true
        requesttableView.tableHeaderView = searchController.searchBar
        
        self.requesttableView.separatorStyle = UITableViewCellSeparatorStyle.none

        requesttableView.register(UINib.init(nibName: "RequestsTableViewCell", bundle: nil),
                                 forCellReuseIdentifier: "RequestsTableViewCell")
        
        self.requesttableView.delegate = self
        self.requesttableView.dataSource = self
        
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RequestsViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        forIpodAndIphone()
        
        self.refresher = UIRefreshControl()
        
        self.refresher.tintColor = #colorLiteral(red: 0.5019607843, green: 0, blue: 0, alpha: 0.9251123716)
        self.refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
        self.requesttableView.addSubview(self.refresher)
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.requesttableView.frame = CGRect(x: self.view.frame.origin.x, y: 130, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        self.view.addSubview(self.requesttableView)
        
        self.navigationController?.isNavigationBarHidden = true
        super.viewWillAppear(animated)
        self.getAgentRequestInfoAPICall()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        searchController.searchBar.resignFirstResponder()
        
        self.searchController.isActive = false
        
        
    }
    
    func loadData() {
        //code to execute during refresher
        //Call this to stop refresher
        
        getAgentRequestInfoAPICall()
        
    }
    
    func stopRefresher() {
        self.refresher.endRefreshing()
    }

//MARK: - API Call for get Agent Request Information
    
    
    func getAgentRequestInfoAPICall(){
        
        if(appDelegate.checkInternetConnectivity()){
//            
//            let agentRequestInfoURL : String  = AGENTREQUESTINFO_API + "" + self.userID + "/" + statusTypeIdd!
//            
//            
//            let strUrl = agentRequestInfoURL + "/" + "null"
//
//            
//            print(agentRequestInfoURL)
            
            let null = NSNull()
            
            let paramsDict = ["UserId": self.userID,
                              "StatusTypeIds": statusTypeIdd!,
                              "SearchItem": null,
                              "Index": PageIndex,
                              "PageSize": 15] as [String:Any]
            
            APIModel().postRequest(self, withUrl: AGENTREQUESTINFO_API, parameters: paramsDict , successBlock: { (json) in
                
                if (json.count > 0){
                    
                    if Utilities.sharedInstance.isObjectNull(json as AnyObject?) {
                        
                        if let response = json as? NSDictionary {
                            
                            let data = response["Result"]
                            
                            if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
                                
                                
                                if let response = data as? NSDictionary {
                                    if Utilities.sharedInstance.isObjectNull(response) {
                                        
                                        if let TotalPages = response["TotalPages"] as? Int{
                                            
                                            self.totalPages = TotalPages
                                            
                                            
                                            
                                        }
                                        if let PageIndex = response["PageIndex"] as? Int{
                                            
                                            self.totalRecords = PageIndex
                                            
                                            
                                            
                                        }
                                    }
                                }
                            }
                        } 
                    }
                    
                    
                    let getAgentRequestArray = ParsingModelClass.sharedInstance.agentRequesgtInfoAPIModelParsing(object: json as AnyObject?)
                    
                    print(getAgentRequestArray)
                    
                    if(getAgentRequestArray.count > 0){

                        self.stopRefresher()
                        
                        for agentRequest in getAgentRequestArray{
                            
                         self.agentDetailsArray.append(agentRequest)
                            self.filteredAgentArr.append(agentRequest)
                        }
//                        self.agentDetailsArray = getAgentRequestArray
//                        
//                        self.filteredAgentArr = self.agentDetailsArray
                        
                        self.requesttableView.reloadData()
                    }
                        
                    else{
                        
                        Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Alert".localize(), messege: "app.NoRecordsFound".localize(), clickAction: {
                            
                            self.navigationController?.popViewController(animated: true)
                        })
                        
                    }
                    
                }
                
                
            }, failureBlock: { (failureMessage) in
                
                if failureMessage == "unAuthorized" {
                    
                    self.serviceController.refreshTokenForLogin(self, successHandler: { (json) in
                        
                        self.getAgentRequestInfoAPICall()
                        
                        
                    }, failureHandler: { (failureMassage) in
                        
                        Utilities.sharedInstance.goToLoginScreen()
                        
                    })
                    
                }
                
//                Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Alert".localize(), messege: failureMessage, clickAction: {
//                    
//                    print(failureMessage)
//                    
//                    self.navigationController?.popViewController(animated: true)
//                    
//                })
                
                
            })
            
            
//            APIModel().getRequest(self, withUrl:strUrl , successBlock: { (json) in
//                
//                
//                if (json.count > 0){
//                    
//                    
//                    let getAgentRequestArray = ParsingModelClass.sharedInstance.agentRequesgtInfoAPIModelParsing(object: json as AnyObject?)
//                    
//                    print(getAgentRequestArray)
//                    
//                    if(getAgentRequestArray.count > 0){
//                        
//                        self.agentDetailsArray = getAgentRequestArray
//                        
//                        self.filteredAgentArr = self.agentDetailsArray
//                        
//                        self.requesttableView.reloadData()
//                    }
//                        
//                    else{
//                        
//                        Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Alert".localize(), messege: "app.NoRecordsFound".localize(), clickAction: {
//                            
//                            self.navigationController?.popViewController(animated: true)
//                        })
//                        
//                    }
//                    
//                }
//                
//                
//                
//            }) { (failureMessage) in
//                
//                
//                Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "Alert", messege: failureMessage, clickAction: {
//                    
//                    print(failureMessage)
//                    
//                    self.navigationController?.popViewController(animated: true)
//                    
//                })
//                
//            }
            
        }
        else {
            
            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(), messege: "app.Pleasecheckyourinternetconnection!".localize(), clickAction: {
    
                self.stopRefresher()
            })
            
            
            
        }

    }
    
//MARK: - UITableView Delegate methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredAgentArr.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 165
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == filteredAgentArr.count - 1 {
            
            if(self.totalPages! > PageIndex + 1){
                PageIndex = PageIndex + 1
                
                self.getAgentRequestInfoAPICall()
                
            }
        }
        
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RequestsTableViewCell", for: indexPath) as! RequestsTableViewCell
        
        
        
        if filteredAgentArr.count > indexPath.row{
        
        let agentDict = filteredAgentArr[indexPath.row]
        
        cell.selectionStyle = .none
        
        let agentName = agentDict.titleType + " " + agentDict.firstName + " " + agentDict.lastName
        
        cell.agentName.text = agentName

        
        let addrs = agentDict.districtName + " " + agentDict.mandalName + " " + agentDict.villageName + " " + agentDict.addressLine1 + " " + agentDict.addressLine2
        
        cell.addressLabel.text = addrs
        cell.mobileLabel.text = agentDict.mobileNumber
        cell.emailLabel.text = agentDict.email
            
       // self.agentReqMobileNo = agentDict.mobileNumber
            
        cell.holdBtn.tag = indexPath.row
        cell.pickUpBtn.tag = indexPath.row
        cell.commentsBtn.tag = indexPath.row
        cell.pickUpBtn.setTitle("app.pickUp".localize(), for: .selected)
        cell.commentsBtn.tag = indexPath.row
        cell.commentsBtn.layer.borderColor = UIColor.lightGray.cgColor
        cell.commentsBtn.layer.borderWidth = 1
        cell.commentsBtn.layer.cornerRadius = 3
        
        cell.pickUpBtn.addTarget(self, action: #selector(pickUpClicked), for: .touchUpInside)
        cell.holdBtn.addTarget(self, action: #selector(holdClicked), for: .touchUpInside)
        cell.commentsBtn.addTarget(self, action: #selector(commentsBtnClicked), for: .touchUpInside)

        cell.pickUpBtn.layer.cornerRadius = 5
        cell.holdBtn.layer.cornerRadius = 5
       
        
        if (agentDict.statusTypeId == 47 || agentDict.statusTypeId == 48) {
            
            cell.holdBtn.isHidden = true
            
        }else{
           cell.holdBtn.isHidden = false
        }
        
        }

        return cell
  
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
    }
    
//MARK: - Search bar for searching results
    
    func updateSearchResults(for searchController: UISearchController) {
        
        self.requesttableView.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.size.width, height: self.view.frame.size.height)
        // If we haven't typed anything into the search bar then do not filter the results
        if searchController.searchBar.text! == "" {
            filteredAgentArr = agentDetailsArray
        } else {
            // Filter the results
//            filteredAgentArr = agentDetailsArray.filter { $0.firstName.lowercased().contains(searchController.searchBar.text!.lowercased()) || $0.mobileNumber.contains(searchController.searchBar.text!)}
            
            let serchStr : String = searchController.searchBar.text!
            
            if(appDelegate.checkInternetConnectivity()){
                
                let null = NSNull()
                
                let paramsDict = ["UserId": self.userID,
                                  "StatusTypeIds": statusTypeIdd!,
                                  "SearchItem": serchStr,
                                  "Index": null,
                                  "PageSize": null] as [String:Any]
                
                APIModel().postRequest(self, withUrl: AGENTREQUESTINFO_API, parameters: paramsDict , successBlock: { (json) in
                    
                    if (json.count > 0){
                        
                        if Utilities.sharedInstance.isObjectNull(json as AnyObject?) {
                            
                            if let response = json as? NSDictionary {
                                
                                let data = response["Result"]
                                
                                if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
                                    
                                    
                                    if let response = data as? NSDictionary {
                                        if Utilities.sharedInstance.isObjectNull(response) {
                                            
                                            if let TotalPages = response["TotalPages"] as? Int{
                                                
                                                self.totalPages = TotalPages
                                                
                                                
                                                
                                            }
                                            if let PageIndex = response["PageIndex"] as? Int{
                                                
                                                self.totalRecords = PageIndex
                                                
                                                
                                                
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        
                        
                        let getAgentRequestArray = ParsingModelClass.sharedInstance.agentRequesgtInfoAPIModelParsing(object: json as AnyObject?)
                        
                        print(getAgentRequestArray)
                        
                        if(getAgentRequestArray.count > 0){
                            
                            self.agentDetailsArray.removeAll()
                            self.filteredAgentArr.removeAll()
                            
                            self.agentDetailsArray = getAgentRequestArray
       
                            self.filteredAgentArr = self.agentDetailsArray
                            
                            self.requesttableView.reloadData()
                        }
                            
                        else {
                            
                            self.searchController.isActive = false
                            
                            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Alert".localize(), messege: "app.NoRecordsFound".localize(), clickAction: {
                                
                                self.requesttableView.frame = CGRect(x: self.view.frame.origin.x, y: 130, width: self.view.frame.size.width, height: self.view.frame.size.height)
                                
                                self.view.addSubview(self.requesttableView)
                                
                                //  self.navigationController?.popViewController(animated: true)
                                DispatchQueue.main.async {
                                    self.getAgentRequestInfoAPICall()
                                }
                            })
                            
                        }
                        
                    }
                    
                    
                }, failureBlock: { (failureMessage) in
                    
                    if failureMessage == "unAuthorized" {
                        
                        self.serviceController.refreshTokenForLogin(self, successHandler: { (json) in
                            
                            self.getAgentRequestInfoAPICall()
                            
                            
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
            
//            filteredAgentArr = agentDetailsArray.filter { $0.mobileNumber.contains(searchController.searchBar.text!) }
        }
        
        self.requesttableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
        
        self.requesttableView.frame = CGRect(x: self.view.frame.origin.x, y: 130, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        self.view.addSubview(self.requesttableView)
        
        self.navigationController?.isNavigationBarHidden = true
        
        
        self.agentDetailsArray.removeAll()
        self.filteredAgentArr.removeAll()
        
        self.getAgentRequestInfoAPICall()
        
        
    }
    
//MARK: - UIButton Action
    
    func commentsBtnClicked(_ sender: UIButton){
        
        let indexPath : IndexPath = IndexPath(row: sender.tag, section: 0)
        
        if let _ : RequestsTableViewCell = self.requesttableView.cellForRow(at: indexPath) as? RequestsTableViewCell {
            
        }
//        let agentDetail:AgentReqInfoParamsAPIModel = agentDetailsArray[indexPath.row]
        
        let agentDict = self.filteredAgentArr[indexPath.row]
        
        let agentRequestId:Int = agentDict.id!
        
        let fName = agentDict.firstName + " " + agentDict.lastName
        
        
        let historyVC = self.storyboard?.instantiateViewController(withIdentifier: "AgentHistoryViewController") as! AgentHistoryViewController
        
        historyVC.agentId = String(describing: agentRequestId)
        historyVC.agentName = fName
        
        
        self.navigationController?.pushViewController(historyVC, animated: true)
        
      
    }
   
//MARK: - UIButton Action
    
    func pickUpClicked(_ sender: UIButton){
    
        searchController.searchBar.endEditing(true)
        searchController.isActive = false
         searchController.searchBar.resignFirstResponder()
        pickeupAPICall(sender.tag)
    }
    
    func pickeupAPICall(_ tag : Int){
        
       
    
        let alertController = UIAlertController(title: "\n\n\n\n\n\n", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
       
        //        customView.backgroundColor = UIColor.clear
        customView.font = UIFont(name: "Helvetica", size: 15)
        
     //   customView.placeholderText = "app.Pleaseenteryourcomments".localize()
        
       let agentDict = filteredAgentArr[tag]
        
       
        
        self.errorLabel.textAlignment = .center
        self.errorLabel.textColor = UIColor.black
       // self.errorLabel.text = "app.Comments".localize()
        
        self.errorLabel.text = agentDict.mobileNumber
        
        self.errorLabel.numberOfLines = 1
        alertController.view.addSubview(errorLabel)
        
        //        alertController.view.superview?.isUserInteractionEnabled = false
        
        //          customView.backgroundColor = UIColor.greenColor()
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone) {
            
            self.errorLabel.font = UIFont.systemFont(ofSize: 12)
            customView.font = UIFont(name: "Helvetica", size: 15)
            marginX = 8.0
            marginY = 20.0
            rect = CGRect(x:self.marginX,y:self.marginY, width:255, height:60)
            customView = UITextView(frame: rect)
            customView.autocorrectionType = .no
            let height:NSLayoutConstraint = NSLayoutConstraint(item: alertController.view, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: self.view.frame.height * 0.20)
            
            customView.text = "app.Comments".localize()
            customView.textColor = UIColor.lightGray
            customView.layer.cornerRadius = 4
            alertController.view.addConstraint(height)
            alertController.view.addSubview(customView)
            customView.delegate = self
        }
            
        else {
            
            self.errorLabel.font = UIFont.systemFont(ofSize: 15)
            customView.font = UIFont(name: "Helvetica", size: 18)
            marginX = 8.0
            marginY = 20.0
            rect = CGRect(x:self.marginX,y:self.marginY, width:255, height:155)
            customView = UITextView(frame: rect)
            customView.autocorrectionType = .no
            customView.text = "app.Comments".localize()
            customView.textColor = UIColor.lightGray
            customView.layer.cornerRadius = 4
            alertController.view.addSubview(customView)
            
            customView.delegate = self
            
        }
        
        
        
        //  alertController.view.addSubview(customView)
        
        let somethingAction = UIAlertAction(title: "app.Submit".localize(), style: UIAlertActionStyle.default, handler: {(alert: UIAlertAction!) in print("Submit")
            
            print(self.customView.text)
            
            if self.customView.text.isEmpty || self.customView.text == "app.Pleaseenteryourcomments".localize() || self.customView.text == "app.Comments".localize() {
                
                
                //                errorLabel.center = CGPoint(x: 160, y: 285)
                
             //   self.errorLabel.textAlignment = .center
                self.customView.textColor = UIColor.red
              //  self.errorLabel.text = "app.Pleaseenteryourcomments".localize()
             //   self.errorLabel.numberOfLines=1
             //   self.errorLabel.font=UIFont.systemFont(ofSize: 13)
             //   alertController.view.addSubview(self.errorLabel)
                self.customView.text = "app.Pleaseenteryourcomments".localize()
                
                
                self.present(alertController, animated: true, completion: nil)
                
            }
                
            else {
                
                self.errorLabel.textAlignment = .center
                self.errorLabel.textColor = UIColor.black
                self.errorLabel.text = "app.Comments".localize()
                self.errorLabel.numberOfLines=1
                self.errorLabel.font=UIFont.systemFont(ofSize: 13)
                alertController.view.addSubview(self.errorLabel)
                alertController.view.tintColor = UIColor.black
                alertController.view.backgroundColor = UIColor.black
                
                //            self.view.endEditing(true)
                
                let indexPath : IndexPath = IndexPath(row: tag, section: 0)
                
                if let _ : RequestsTableViewCell = self.requesttableView.cellForRow(at: indexPath) as? RequestsTableViewCell {
                    
                    if(appDelegate.checkInternetConnectivity()){
                        
                        print("index:\(indexPath.row)")
                        
                        let agentDict = self.filteredAgentArr[indexPath.row]
                        
                        let statusTypeId = "44"
                        
                        let assignToUserId = self.userID
                        
                        let agentRequestId:Int = agentDict.id!
                        
                        let comentsFiled:String = self.customView.text
                        
                        let paramsDict = [ "AgentRequestId": agentRequestId,
                                           "StatusTypeId": statusTypeId,
                                           "AssignToUserId": assignToUserId,
                                           "Comments": comentsFiled,
                                           "Id": 0,
                                           "IsActive": true
                            ] as [String:Any]
                        
                        print("paramsDict:\(paramsDict)")
                        
                        APIModel().postRequest(self, withUrl: UPDATEAGENTREQUESTINFO_API, parameters: paramsDict, successBlock: { (json) in
                            
                            print("json:\(json)")
                            
                            
                            if (json.count > 0){
                                
                                Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Success".localize(), messege: "app.RecordUpdatedSuccessfully".localize(), clickAction: {
                                    
                                    let updateAgetAgentRequestArray = ParsingModelClass.sharedInstance.updateAgentRequesgtInfoAPIModelParsing(object: json as AnyObject?)
                                    
                                    print(updateAgetAgentRequestArray)
                                    
                                    
                                    if(updateAgetAgentRequestArray.count > 0){
                                        
                                        for updateAgentRequestInfo in updateAgetAgentRequestArray{
                                            
                                            print("firstName:\(String(describing: updateAgentRequestInfo.statusTypeId))")
                                            
                                            self.updateAgentArr.append(updateAgentRequestInfo.statusTypeId!)
                                            
                                            let commetns = updateAgentRequestInfo.comments
                                            
                                            print("commetns:\(commetns)")
                                            
                                        }
                                    }
                                    
                                    self.filteredAgentArr.removeAll()
                                    self.getAgentRequestInfoAPICall()
                                    self.requesttableView.reloadData()
                                    
                                })
                            }
                            
                            
                        }) { (failureMessage) in
                            
//                            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Success".localize(), messege: failureMessage.localize(), clickAction: {
//                                
//                                
//                            })
                            
                            if failureMessage == "unAuthorized" {
                                
                                self.serviceController.refreshTokenForLogin(self, successHandler: { (json) in
                                    
                                    self.pickeupAPICall(tag)
                                    
                                    
                                }, failureHandler: { (failureMassage) in
                                    
                                    Utilities.sharedInstance.goToLoginScreen()
                                    
                                })
                                
                            }
                            
                        }
                        
                    }
                    else {
                        
                        Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(), messege: "app.Pleasecheckyourinternetconnection!".localize(), clickAction: {
                            
                            self.stopRefresher()
                            
                        })
                       
                    }
                    
                    
                }
            }
        })
        
        let cancelAction = UIAlertAction(title: "app.Cancel".localize(), style: UIAlertActionStyle.cancel, handler: {(alert: UIAlertAction!) in print("cancel")
        
            self.presentingViewController?.dismiss(animated: true, completion: nil)
            self.dismiss(animated: true, completion: nil)
            
            self.requesttableView.frame = CGRect(x: self.view.frame.origin.x, y: 130, width: self.view.frame.size.width, height: self.view.frame.size.height)
            
            self.view.addSubview(self.requesttableView)
            
            self.navigationController?.isNavigationBarHidden = true
            
            
            self.agentDetailsArray.removeAll()
            self.filteredAgentArr.removeAll()
            
            self.getAgentRequestInfoAPICall()
        
        })
        
        alertController.addAction(somethingAction)
        alertController.addAction(cancelAction)
       // alertController.view.tintColor = UIColor.black
        
        self.present(alertController, animated: true, completion: nil)

    
    }
    
//MARK: - UIButton Action
    
    func holdClicked(_ sender: UIButton){
        
        searchController.searchBar.endEditing(true)
        searchController.isActive = false
        searchController.searchBar.resignFirstResponder()
       
        self.holdAPICall(sender.tag)
        
    
    
    }
    
    func holdAPICall(_ tag : Int){
    
        let alertController = UIAlertController(title: "\n\n\n\n\n\n", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        let agentDict = filteredAgentArr[tag]
        //        customView.backgroundColor = UIColor.clear
        
        
      //  customView.placeholderText = "app.Pleaseenteryourcomments".localize()
        
        self.errorLabel.textAlignment = .center
        self.errorLabel.textColor = UIColor.black
       // self.errorLabel.text = "app.Comments".localize()
        
        self.errorLabel.text = agentDict.mobileNumber
        self.errorLabel.numberOfLines=1
        
        alertController.view.addSubview(self.errorLabel)
        
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone) {
            
            self.errorLabel.font=UIFont.systemFont(ofSize: 12)
            customView.font = UIFont(name: "Helvetica", size: 15)
            marginX = 8.0
            marginY = 20.0
            rect = CGRect(x:self.marginX,y:self.marginY, width:255, height:60)
            customView = UITextView(frame: rect)
            customView.autocorrectionType = .no
            let height:NSLayoutConstraint = NSLayoutConstraint(item: alertController.view, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: self.view.frame.height * 0.20)
            
            customView.text = "app.Comments".localize()
            customView.textColor = UIColor.lightGray
            customView.layer.cornerRadius = 4
            alertController.view.addConstraint(height)
            alertController.view.addSubview(customView)
            customView.delegate = self
        }
            
        else {
            
            customView.font = UIFont(name: "Helvetica", size: 20)
            self.errorLabel.font=UIFont.systemFont(ofSize: 15)
            marginX = 8.0
            marginY = 20.0
            rect = CGRect(x:self.marginX,y:self.marginY, width:255, height:155)
            customView = UITextView(frame: rect)
            customView.autocorrectionType = .no
            customView.text = "app.Comments".localize()
            customView.textColor = UIColor.lightGray
            customView.layer.cornerRadius = 4
            alertController.view.addSubview(customView)
            customView.delegate = self
            
            
            
        }
        
        let somethingAction = UIAlertAction(title: "app.Submit".localize(), style: UIAlertActionStyle.default, handler: {(alert: UIAlertAction!) in print("Submit")
            
            print(self.customView.text)
            if self.customView.text.isEmpty || self.customView.text == "app.Pleaseenteryourcomments".localize() || self.customView.text == "app.Comments".localize(){
                
//                self.errorLabel.textAlignment = .center
//                self.errorLabel.textColor = UIColor.red
//                self.errorLabel.text = "app.Pleaseenteryourcomments".localize()
//                self.errorLabel.font=UIFont.systemFont(ofSize: 13)
//                alertController.view.addSubview(self.errorLabel)
                
                self.customView.textColor = UIColor.red
                self.customView.text = "app.Pleaseenteryourcomments".localize()
                
                self.present(alertController, animated: true, completion: nil)
                
            }
            else{
                
                self.errorLabel.textAlignment = .center
                self.errorLabel.textColor = UIColor.black
                self.errorLabel.text = "app.Comments".localize()
                self.errorLabel.numberOfLines=1
                self.errorLabel.font=UIFont.systemFont(ofSize: 13)
                alertController.view.addSubview(self.errorLabel)
                
                let indexPath : IndexPath = IndexPath(row: tag , section: 0)
                
                if let _ : RequestsTableViewCell = self.requesttableView.cellForRow(at: indexPath) as? RequestsTableViewCell {
                    
                    if(appDelegate.checkInternetConnectivity()){
                        
                        
                        print("index:\(indexPath.row)")
                        
                        let agentDict = self.filteredAgentArr[indexPath.row]
                        
                        let statusTypeId = "48"
                        
                        let assignToUserId = self.userID
                        
                        let agentRequestId:Int = agentDict.id!
                        
                        let comentsFiled:String = self.customView.text
                        
                        
                        let paramsDict = [ "AgentRequestId": agentRequestId,
                                           "StatusTypeId": statusTypeId,
                                           "AssignToUserId": assignToUserId,
                                           "Comments": comentsFiled,
                                           "Id": 0,
                                           "IsActive": true
                            ] as [String:Any]
                        
                        //                print("paramsDict:\(paramsDict)")
                        
                        APIModel().postRequest(self, withUrl: UPDATEAGENTREQUESTINFO_API, parameters: paramsDict, successBlock: { (json) in
                            
                            print("json:\(json)")
                            
                            
                            if (json.count > 0){
                                
                                Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Success".localize(), messege: "app.RecordUpdatedSuccessfully".localize(), clickAction: {
                                    
                                    
                                })
                                
                                let updateAgetAgentRequestArray = ParsingModelClass.sharedInstance.updateAgentRequesgtInfoAPIModelParsing(object: json as AnyObject?)
                                
                                print(updateAgetAgentRequestArray)
                                
                                
                                if(updateAgetAgentRequestArray.count > 0){
                                    
                                    for updateAgentRequestInfo in updateAgetAgentRequestArray{
                                        
                                        print("firstName:\(String(describing: updateAgentRequestInfo.statusTypeId))")
                                        
                                        self.updateAgentArr.append(updateAgentRequestInfo.statusTypeId!)
                                        
                                        let commetns = updateAgentRequestInfo.comments
                                        
                                        print("commetns:\(commetns)")
                                        
                                    }
                                }
                                
                                self.getAgentRequestInfoAPICall()
                                self.requesttableView.reloadData()
                            }
                            
                            
                        }) { (failureMessage) in
                            
                            if failureMessage == "unAuthorized" {
                                
                                self.serviceController.refreshTokenForLogin(self, successHandler: { (json) in
                                    
                                    self.holdAPICall(tag)
                                    
                                    
                                }, failureHandler: { (failureMassage) in
                                    
                                    Utilities.sharedInstance.goToLoginScreen()
                                    
                                })
                                
                            }

                            
                        }
                        
                        
                    }
                    else {
                        
                        Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(), messege: "app.Pleasecheckyourinternetconnection!".localize(), clickAction: {
                            
                            self.stopRefresher()
                        })
                                            }
                    
                    
                    
                }
            }
        })
        
        let cancelAction = UIAlertAction(title: "app.Cancel".localize(), style: UIAlertActionStyle.cancel, handler: {(alert: UIAlertAction!) in print("cancel")
        
            self.presentingViewController?.dismiss(animated: true, completion: nil)
            self.dismiss(animated: true, completion: nil)
            
            self.requesttableView.frame = CGRect(x: self.view.frame.origin.x, y: 130, width: self.view.frame.size.width, height: self.view.frame.size.height)
            
            self.view.addSubview(self.requesttableView)
            
            self.navigationController?.isNavigationBarHidden = true
            
            
            self.agentDetailsArray.removeAll()
            self.filteredAgentArr.removeAll()
            
            self.getAgentRequestInfoAPICall()
        
        })
        
        alertController.addAction(somethingAction)
        alertController.addAction(cancelAction)
     //   alertController.view.tintColor = UIColor.black
        
        self.present(alertController, animated: true, completion: nil)
    
    }
    
//MARK: - textView delegate methods
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"  // Recognizes enter key in keyboard
        {
            textView.resignFirstResponder()
            return false
        }
        
        
        
        
        return true
    }
    
    
    func textView(textView: UITextView, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if !string.canBeConverted(to: String.Encoding.ascii){
            return false
        }
        
        if string.characters.count > 0 {
            
            let currentCharacterCount = textView.text?.characters.count ?? 0
            if (range.length + range.location > currentCharacterCount){
                return false
            }
            let newLength = currentCharacterCount + string.characters.count - range.length
            
            
            return newLength <= 40
        }
        
        return true
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if customView.text == "app.Comments".localize() || customView.text == "app.Pleaseenteryourcomments".localize(){
            customView.text = ""
            customView.textColor = UIColor.black
        }
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if customView.text.isEmpty {
            //customView.text = "Comments"
            customView.textColor = UIColor.lightGray
        }
    }
    
    
    
    
//MARK: - Api Call for Update Agent Request
    
    func UpdateAgentRequestAPICall(){
 
        let paramsDict = [ "AgentRequestId": 26,
                           "StatusTypeId": 44,
                           "AssignToUserId": "071862aa-d6b6-448a-bf23-943d88739f9d",
                           "Comments": "Hi",
                           "Id": 26,
                           "IsActive": true
                           ] as [String:Any]
        
        
        print("paramsDict:\(paramsDict)")
        
        APIModel().postRequest(self, withUrl: UPDATEAGENTREQUESTINFO_API, parameters: paramsDict, successBlock: { (json) in
            
            print("json:\(json)")
            
            
            if (json.count > 0){
                
                
                let updateAgetAgentRequestArray = ParsingModelClass.sharedInstance.updateAgentRequesgtInfoAPIModelParsing(object: json as AnyObject?)
                
                print(updateAgetAgentRequestArray)
                
                
                if(updateAgetAgentRequestArray.count > 0){
                    
                    for updateAgentRequestInfo in updateAgetAgentRequestArray{
                        
                        print("firstName:\(String(describing: updateAgentRequestInfo.statusTypeId))")
                        
                        self.updateAgentArr.append(updateAgentRequestInfo.statusTypeId!)
                        
                        let commetns = updateAgentRequestInfo.comments
                        
                       print("commetns:\(commetns)")
                        
                    }
                }
                
            }
            
            
        }) { (failureMessage) in
            
            
            
        }
        
    }
   
//MARK: - UIButton Action
    
    @IBAction func backClicked(_ sender: Any) {
        
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
//MARK: - UIButton Action    
    
    @IBAction func logOutBtnAction(_ sender: Any) {
        
        Utilities.sharedInstance.alertWithYesNoButtonAction(vc: self, alertTitle: "app.Alert".localize(), messege: "app.AreYouSureWantToLogout".localize()) {
            
            let LoginNav : UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginNav") as! UINavigationController
            
            UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
            UserDefaults.standard.synchronize()
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = LoginNav
            
        }
    }
    
//MARK: - Buttun Actions
    
    @IBAction func homeClicked(_ sender: Any) {
        
      self.navigationController?.popViewController(animated: true)
    }
    
    
}
