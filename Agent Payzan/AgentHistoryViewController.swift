//
//  AgentHistoryViewController.swift
//  Agent Payzan
//
//  Created by CalibrageMac02 on 28/11/17.
//  Copyright © 2017 Naveen. All rights reserved.
//

import UIKit

class AgentHistoryViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var historyTableView: UITableView!
    
    @IBOutlet weak var headerImgHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var headerImgVW: UIImageView!
    
    @IBOutlet weak var agentNameLabel: UILabel!
    
    var historyArr = [CommenthistoryResultVo]()
    
    var serviceController = ServiceController()
    
    var agentId:String! = ""
    var agentName:String! = ""
    
     var refresher:UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItems = []
        navigationItem.hidesBackButton = true
        for subview in (self.navigationController?.navigationBar.subviews)! {
            
            subview.isHidden = true
        }
        
        agentNameLabel.text = agentName
        
        self.historyTableView.separatorStyle = .none
        
         getHistoryAPICall()
        
        historyTableView.dataSource = self
        historyTableView.delegate = self
        
        historyTableView.register(UINib.init(nibName: "AgentHistoryTableViewCell", bundle: nil),
                              forCellReuseIdentifier: "AgentHistoryTableViewCell")

        
        self.refresher = UIRefreshControl()
        
        self.refresher.tintColor = #colorLiteral(red: 0.5019607843, green: 0, blue: 0, alpha: 0.9251123716)
        self.refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
        self.historyTableView.addSubview(self.refresher)
        
        
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


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = true
        super.viewWillAppear(animated)
        
    }
    
    
    func loadData() {
        //code to execute during refresher
        //Call this to stop refresher
        
        getHistoryAPICall()
        
    }
    
    func stopRefresher() {
        self.refresher.endRefreshing()
    }
    
    
    
//MARK: - uitableview delegate methods
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return historyArr.count
        
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AgentHistoryTableViewCell") as! AgentHistoryTableViewCell
        
        if historyArr.count > indexPath.row{
            
            let historyObj = historyArr[indexPath.row]
            
            cell.statusLabel.text = historyObj.StatusType
            cell.assignToLabel.text = historyObj.AssignToUser
            cell.commentsLabel.text = historyObj.Comments
            
            let createdDate = historyObj.Created
            
        let stringB = self.formattedDateFromString(dateString: createdDate!, withFormat: "MMM dd, yyyy")
            
            if stringB != nil {
                
                cell.dateLabel.text = stringB
                
            }
            
           
            if historyObj.IsActive == true {
                
                 cell.isActiveBtn.isHidden = false
            }else {
                
                cell.isActiveBtn.isHidden = true
            }

            
            cell.selectionStyle = .none
            
            
        }
        
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 120
    }
    
    
//MARK: - Date formater
    
    func formattedDateFromString(dateString: String, withFormat format: String) -> String? {
        
        let inputFormatter = DateFormatter()
        
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        
        if let date = inputFormatter.date(from: dateString) {
            
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format
            
            return outputFormatter.string(from: date)
        }
        
        return nil
    }
    
    func dateFormatter_yyyy_MM_dd_hh_mm_ss_SSSSSSS_Z() -> DateFormatter {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.system
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZ" //2016-01-01T11:57:55.6738531+05:30
        dateFormatter.systemTimeZone()
        return dateFormatter
    }

//MARK: - API Call for get History 
    
    func getHistoryAPICall(){
        
        let strUrl = GETHISTORY_API + agentId
        
        serviceController.requestGETURL(self, strURL:strUrl, success:{(result) in
            DispatchQueue.main.async()
                {
                    self.stopRefresher()
                    let respVO : CommentHistoryInfoVo = Mapper().map(JSONObject: result)!
                    
                    
                    let isActive = respVO.IsSuccess
                    
                    if(isActive == true){
                        
                        if !(respVO.ListResult?.isEmpty)! {
                            
                            
                            let historyInfo = respVO.ListResult
                            
                            self.historyArr.removeAll()
                            
                            self.historyArr = historyInfo!
                            
                            
                            self.historyTableView.reloadData()
                        }
                       
                        
                    } else if(isActive == false) {
                        
                        
                        
                    }
            }
            
        },
         failure:  {(error) in
            
            self.stopRefresher()
            
            if error == "unAuthorized" {
                
                self.serviceController.refreshTokenForLogin(self, successHandler: { (json) in
                    
                    self.getHistoryAPICall()
                    
                    
                }, failureHandler: { (failureMassage) in
                    
                    Utilities.sharedInstance.goToLoginScreen()
                    
                })
                
            }
            
        })
        
        
        
        
    }

//MARK: - Button Actions
    
    @IBAction func backBtnAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func logoutBtnAction(_ sender: Any) {
        
        Utilities.sharedInstance.alertWithYesNoButtonAction(vc: self, alertTitle: "app.Alert".localize(), messege: "app.AreYouSureWantToLogout".localize()) {
            
            let LoginNav : UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginNav") as! UINavigationController
            
            UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
            UserDefaults.standard.synchronize()
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = LoginNav
            
        }
    }
}
