 //
//  InProgressViewController.swift
//  Agent Payzan
//
//  Created by CalibrageMac02 on 02/11/17.
//  Copyright © 2017 Naveen. All rights reserved.
//

import UIKit

class InProgressViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating,UISearchBarDelegate {
    
    @IBOutlet weak var logoutView: UIView!
    @IBOutlet weak var inProgressTableView: UITableView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var headerImgHeight: NSLayoutConstraint!
    @IBOutlet weak var headerImgVW: UIImageView!
    
    var agentDetailsArray = [AgentReqInfoParamsAPIModel]()
    
    var statusTypeIdArr :  Array<Int> = Array()
    var idArr :  Array<Int> = Array()
    
    var agentReqArr = [String]()
    let textView = UITextView()
    
    var statusTypeIdd:String!
    
    var userID : String = ""
    
    var provinceId                  : Int? = nil
    var districtId                  : Int? = nil
    var mandalId                    : Int? = nil
    
    var totalPages : Int? = 0
    
    var totalRecords : Int? = 0
    
    var totalRecordsAry :  Array<Int> = Array()
    
    var filteredAgentArr = [AgentReqInfoParamsAPIModel]()
    
  //  @IBOutlet weak var searchController: UISearchBar!
    
    
    let searchController = UISearchController(searchResultsController: nil)
    
  //  @IBOutlet weak var searchController: UISearchController!
    
        var serviceController = ServiceController()
    
    var TotalPagesAry : Array<Int> = Array()
    var PageIndex = 0
    
    var refresher:UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        
        if let userid = defaults.string(forKey: AId) {
            
            userID = userid
            
            print("defaults savedString: \(userID)")
        }
        
        self.searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
      //  definesPresentationContext = true
        inProgressTableView.tableHeaderView = searchController.searchBar
        
       // searchController.searchBar.frame = CGRect(x: 0.0, y: 200.0, width: self.view.frame.width, height: 50.0)
        
       // self.view.addSubview(searchController.searchBar)
        
        self.inProgressTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        inProgressTableView.register(UINib.init(nibName: "InProgressTableViewCell", bundle: nil),
                                  forCellReuseIdentifier: "InProgressTableViewCell")
        
        self.inProgressTableView.delegate = self
        self.inProgressTableView.dataSource = self
        
        forIpodAndIphone()
        self.refresher = UIRefreshControl()
        
        self.refresher.tintColor = #colorLiteral(red: 0.5019607843, green: 0, blue: 0, alpha: 0.9251123716)
        self.refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
        self.inProgressTableView.addSubview(self.refresher)
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
    
    override func viewWillAppear(_ animated: Bool) {
        
        PageIndex = 0
        totalPages = 0
        
        
        
        self.inProgressTableView.frame = CGRect(x: self.view.frame.origin.x, y: 130, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        agentDetailsArray.removeAll()
        filteredAgentArr.removeAll()
        
        self.view.addSubview(self.inProgressTableView)
        self.navigationController?.isNavigationBarHidden = true
        super.viewWillAppear(animated)
        self.getAgentRequestInfoAPICall()
        
     //   self.searchController.isActive = true
        
 //       self.inProgressTableView.setContentOffset(CGPoint.zero, animated: true)
        
//        let indexPath : IndexPath = IndexPath(row: 0, section: 0)
//        
//        self.inProgressTableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: false)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        searchController.searchBar.resignFirstResponder()
        
        self.searchController.isActive = false
    
    
    }
    
    func loadData() {
        //code to execute during refresher
        //Call this to stop refresher
        
        self.filteredAgentArr.removeAll()
        self.agentDetailsArray.removeAll()
        
        getAgentRequestInfoAPICall()
    }
    
    func stopRefresher() {
        self.refresher.endRefreshing()
    }
    
    
//MARK: - Api Call for get Agent Request Information
    
    func getAgentRequestInfoAPICall(){
        
        if(appDelegate.checkInternetConnectivity()){
            
         let null = NSNull()
            
          
                
                let paramsDict = ["UserId": self.userID,
                                  "StatusTypeIds": statusTypeIdd!,
                                  "SearchItem": null,
                                  "Index": PageIndex,
                                  "PageSize": 10] as [String:Any]
          
            
       
       
            
//            let requestURL : String  = AGENTREQUESTINFO_API + "" + self.userID
//            
//            let agentRequestInfoURL = requestURL + "/" + statusTypeIdd!
//            
//            let strUrl = agentRequestInfoURL + "/" + "null"
            
           APIModel().postRequest(self, withUrl: AGENTREQUESTINFO_API, parameters: paramsDict , successBlock: { (json) in
            
            if (json.count > 0){
                
                self.stopRefresher()
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
                    
                    

                    self.inProgressTableView.reloadData()
                    
//                    if self.PageIndex == 0{
//                        
//                    self.inProgressTableView.setContentOffset(CGPoint.zero, animated: true)
//                        
//                    let indexPath : IndexPath = IndexPath(row: 0, section: 0)
//                        
//                    self.inProgressTableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: false)
//                    
//                    }
                    
                    
                }
                    
                else{
                    
                    Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Alert".localize(), messege: "app.NoRecordsFound".localize(), clickAction: {
                        self.stopRefresher()
                        self.navigationController?.popViewController(animated: true)
                    })
                    
                }
                
            }

            
           }, failureBlock: { (failureMessage) in
//            
//            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Alert".localize(), messege: failureMessage, clickAction: {
//                
//                print(failureMessage)
//                
//                self.navigationController?.popViewController(animated: true)
//     })
            
            if failureMessage == "unAuthorized" {
                
                self.serviceController.refreshTokenForLogin(self, successHandler: { (json) in
                    
                    self.getAgentRequestInfoAPICall()
                    
                    
                }, failureHandler: { (failureMassage) in
                    
                    Utilities.sharedInstance.goToLoginScreen()
                    
                })
                
            }

            
           })
            
//
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
//                        //                    for agentRequestInfo in getAgentRequestArray{
//                        
//                        //                    }
//                        self.inProgressTableView.reloadData()
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
//            }) { (failureMessage) in
//                
//                Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Alert".localize(), messege: failureMessage, clickAction: {
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
    
    
    
//MARK: - Uitableview delegate methods 
    
    
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
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "InProgressTableViewCell", for: indexPath) as! InProgressTableViewCell
        
        if filteredAgentArr.count > indexPath.row{
        
        cell.selectionStyle = .none
        
        let agentDict = self.filteredAgentArr[indexPath.row]
            
    
        
        let agentName = agentDict.titleType + " " + agentDict.firstName + " " + agentDict.middleName + " " + agentDict.lastName
        
        cell.firstnameLabel.text = agentName
        
         let addrs = agentDict.districtName + " " + agentDict.mandalName + " " + agentDict.villageName + " " + agentDict.addressLine1 + " " + agentDict.addressLine2
        
        cell.addressLabel.text = addrs
        cell.mobileNumLabel.text = agentDict.mobileNumber
        cell.emailLabel.text = agentDict.email
        
        cell.addBtn.tag = indexPath.row
        cell.commentsBtn.tag = indexPath.row
        cell.commentsBtn.layer.borderColor = UIColor.lightGray.cgColor
        cell.commentsBtn.layer.borderWidth = 1
        cell.commentsBtn.layer.cornerRadius = 3
        cell.addBtn.addTarget(self, action: #selector(addClicked), for: .touchUpInside)
        cell.updateBtn.addTarget(self, action: #selector(updateClicked), for: .touchUpInside)
        cell.commentsBtn.addTarget(self, action: #selector(commentsBtnClicked), for: .touchUpInside)
        cell.addBtn.layer.cornerRadius = 5
        cell.updateBtn.layer.cornerRadius = 5
        cell.reviewBtn.layer.cornerRadius = 5
            
        
        
        
        
        if (agentDict.statusTypeId == 44) {
            
            cell.updateBtn.isHidden = true
            cell.isActiveBtn.isHidden = true
             cell.reviewBtn.isHidden = true
            
        }else{
            
            cell.updateBtn.isHidden = false
        }
        
        if (agentDict.statusTypeId == 45) {
            
            cell.updateBtn.isHidden = true
            cell.addBtn.isHidden = true
            cell.isActiveBtn.isHidden = true
            cell.reviewBtn.isHidden = false
            
        }
        else {
            
            cell.addBtn.isHidden = false
            
        }
        
        if (agentDict.statusTypeId == 46) {
            
            cell.updateBtn.isHidden = true
            cell.addBtn.isHidden = true
            cell.isActiveBtn.isHidden = false
            cell.reviewBtn.isHidden = true
            
        }
        }

        return cell
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //  NSLog("Table view scroll detected at offset: %f", scrollView.contentOffset.y)
        
        searchController.searchBar.resignFirstResponder()
    }
    
//MARK: - Search bar for searching results
    
    func updateSearchResults(for searchController: UISearchController) {
        
       self.inProgressTableView.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.size.width, height: self.view.frame.size.height)

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
                                    
                                    print(data!)
                                    
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
                            self.filteredAgentArr.removeAll()
                            self.agentDetailsArray.removeAll()
                            
                            for agentRequest in getAgentRequestArray{
                                
                                
                                
                                self.agentDetailsArray.append(agentRequest)
                                
                                
                            
                                self.filteredAgentArr.append(agentRequest)
                                
                            }
                            
                            
                            
                            self.inProgressTableView.reloadData()
                            
                            
                        }
                            
                        else{
                            
                            self.searchController.isActive = false
                            
                            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Alert".localize(), messege: "app.NoRecordsFound".localize(), clickAction: {
                                self.inProgressTableView.frame = CGRect(x: self.view.frame.origin.x, y: 130, width: self.view.frame.size.width, height: self.view.frame.size.height)
                                self.stopRefresher()
                                self.view.addSubview(self.inProgressTableView)
                              //  self.navigationController?.popViewController(animated: true)
                                
                                     self.filteredAgentArr.removeAll()
                                    self.getAgentRequestInfoAPICall()
                                
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

            
        }
        
        self.inProgressTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        PageIndex = 0
        totalPages = 0
        
        self.inProgressTableView.frame = CGRect(x: self.view.frame.origin.x, y: 130, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        self.view.addSubview(self.inProgressTableView)
        
        self.navigationController?.isNavigationBarHidden = true
        
        self.filteredAgentArr.removeAll()
        self.agentDetailsArray.removeAll()
        
        self.getAgentRequestInfoAPICall()
        
        
    }
    
//MARK: - UIButton Action
    
    func addClicked(_ sender: UIButton){
        
        
        let indexPath : IndexPath = IndexPath(row: sender.tag, section: 0)
        
       // var agentDetail = AgentReqInfoParamsAPIModel()
         let    agentDetail = filteredAgentArr[indexPath.row]
        
        let mobileNo = agentDetail.mobileNumber
        
        let tType = agentDetail.titleType
       
        let fName = agentDetail.firstName
        let mName = agentDetail.middleName
        let lName = agentDetail.lastName

        let emailID = agentDetail.email
        let address1 = agentDetail.addressLine1
        let address2 = agentDetail.addressLine2
        let landMark = agentDetail.landmark
        let provinceName = agentDetail.provinceName
        let districtName = agentDetail.districtName
        let mandalName = agentDetail.mandalName
        let villageName = agentDetail.villageName
        let vilageTypeId = agentDetail.villageId
        let postCode     = agentDetail.postCode
        
        let requesrId = agentDetail.id
        
        provinceId = agentDetail.provinceId
        districtId = agentDetail.districtId
        mandalId   = agentDetail.mandalId
        
        UserDefaults.standard.set(requesrId, forKey: "AgentRequestId")
        UserDefaults.standard.synchronize()
        
        
       
        
        if let _ : RequestsTableViewCell = self.inProgressTableView.cellForRow(at: indexPath) as? RequestsTableViewCell {
            
            
            
        }
        
            let newAgentVC = self.storyboard?.instantiateViewController(withIdentifier: "newAgentVC") as? NewAgentRegistrationViewController
        
            newAgentVC?.agentMobileNo = mobileNo
            newAgentVC?.phoneNo = mobileNo
        
             newAgentVC?.selectedtitleTypeStr = tType
            newAgentVC?.fName = fName
            newAgentVC?.mName = mName
            newAgentVC?.lName = lName
        
            newAgentVC?.eMail = emailID
            newAgentVC?.address1Str = address1
            newAgentVC?.address2Str = address2
            newAgentVC?.selectedProvinceStr = provinceName
            newAgentVC?.selectedDistrictStr = districtName
            newAgentVC?.selectedMandalStr = mandalName
            newAgentVC?.selectedVillageStr = villageName
            newAgentVC?.villageID = vilageTypeId!
            newAgentVC?.selectedPostalCode = "\(postCode!)"
            newAgentVC?.landMarkStr = landMark
            newAgentVC?.provinceID = provinceId!
            newAgentVC?.districtID = districtId!
            newAgentVC?.mandalID = mandalId!
            newAgentVC?.directAgentString = "notDirectAgent"
        
        
        
        
        
           newAgentVC?.fromBack = true
        
        
            self.navigationController?.pushViewController(newAgentVC!, animated: true)
        
       
    }

//MARK: - UIButton Action
    
    func commentsBtnClicked(_ sender: UIButton){
        
        let indexPath : IndexPath = IndexPath(row: sender.tag, section: 0)
        
        if let _ : RequestsTableViewCell = self.inProgressTableView.cellForRow(at: indexPath) as? RequestsTableViewCell {
            
        }
            let agentDetail:AgentReqInfoParamsAPIModel = filteredAgentArr[indexPath.row]
            
            let agentID = agentDetail.id
            let fName = agentDetail.firstName + " " + agentDetail.lastName
            

            let historyVC = self.storyboard?.instantiateViewController(withIdentifier: "AgentHistoryViewController") as! AgentHistoryViewController
            
            historyVC.agentId = String(describing: agentID!)
            historyVC.agentName = fName
            
            
            self.navigationController?.pushViewController(historyVC, animated: true)
            
       
        
        
    }
    
    func updateClicked(_ sender: UIButton){
        
        
    }

//MARK: - UIButton Action
    
    @IBAction func backAction(_ sender: Any) {
        
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
    



}
