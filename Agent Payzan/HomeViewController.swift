//
//  HomeViewController.swift
//  Agent Payzan
//
//  Created by Nani Mac on 18/10/17.
//  Copyright © 2017 Naveen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UIScrollViewDelegate {
    
    @IBOutlet weak var eefreshScrollView: UIScrollView!
  
    @IBOutlet weak var headerImgHeight: NSLayoutConstraint!
    
    @IBOutlet weak var headerImgVW: UIImageView!
    
    
    @IBOutlet weak var agentReqCountLabel: UILabel!
    
    @IBOutlet weak var yetGoCountLabel: UILabel!
    
    @IBOutlet weak var unVerifyCountLabel: UILabel!
    
    @IBOutlet weak var verifyCountLabel: UILabel!
    
    @IBOutlet weak var UserNameLabel: UILabel!
    
    
    
    var userName:String = ""
    
    var jpgImageData:Data!
    
    var userIdd:String = ""
    
    var agentReqCountAry : Array<Int> = Array()
    var yetGoCountAry : Array<Int> = Array()
    var unVerifyCountArray :  Array<Int> = Array()
    var verifyCountArray :  Array<Int> = Array()
    
    var homeRequestsCountArray :  Array<String> = Array()
    var homeRequestsStatusTypeArray :  Array<String> = Array()
    
    var marginX:CGFloat!
    var marginY:CGFloat!
    var rect = CGRect()
    var customView = UITextView()
    
    var serviceController = ServiceController()
    var refresher:UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
      self.navigationController?.isNavigationBarHidden = true
        
        let defaults = UserDefaults.standard
        
        if let userid = defaults.string(forKey: AId) {
            
            userIdd = userid
            
            print("defaults savedString: \(userIdd)")
        }
        if let uname = defaults.string(forKey: AuserName) {
            
            userName = uname
            
            print("defaults savedString: \(userName)")
        }
        
        
        UserNameLabel.text = userName
        self.eefreshScrollView.delegate = self
        
        self.refresher = UIRefreshControl()
        
        self.refresher.tintColor = UIColor.white
        
       //  [self.scrollView insertSubview:refreshControl atIndex:0];
       self.refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
        self.eefreshScrollView.insertSubview(self.refresher, at: 0)
     //  self.eefreshScrollView.addSubview(self.refresher)
        
        
        
      //  requestsAPICall()
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

    
    override func viewDidAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = true
        
        super.viewDidAppear(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.eefreshScrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height:UIScreen.main.bounds.size.height + 200)
        self.eefreshScrollView.showsVerticalScrollIndicator = false
        requestsAPICall()
        
        
        self.navigationController?.isNavigationBarHidden = true
        super.viewWillAppear(animated)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    
    func loadData() {
        //code to execute during refresher
       // requestsAPICall()
                 //Call this to stop refresher
    }
    
    func stopRefresher() {
        self.refresher.endRefreshing()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
       print("scrollViewDidScroll")
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView){
    
        requestsAPICall()
        print("scrollViewWillBeginDragging")
        
    
    }

//MARK: - Api Call for Agent requests Count
    
    func requestsAPICall(){
        
        if(appDelegate.checkInternetConnectivity()){
            
            let strUrl = HOME_API + userIdd
            
            serviceController.requestGETURL(self, strURL:strUrl, success:{(result) in
                DispatchQueue.main.async()
                    {
                        
                        let respVO : AgentReqCountsVo = Mapper().map(JSONObject: result)!
                        
                        
                        let isActive = respVO.IsSuccess
                        
                        
                        if(isActive == true){
                            
                            
                            let statusObj = respVO.Result?.StatusCounts
                            
                            var agentReqCount43 : Int = 0
                            var agentReqCount47 : Int = 0
                            var agentReqCount48 : Int = 0
                            
                            
                            for homeRequests in statusObj! {
         
                                if(homeRequests.StatusTypeId == 43)  {
                                    
                                 agentReqCount43 =  homeRequests.Count!
                                    
                                }
                                if(homeRequests.StatusTypeId == 44){
                                    
                                    self.yetGoCountLabel.text!  = String(describing: homeRequests.Count!)
                                    
                                }
                                
                                if(homeRequests.StatusTypeId == 45){
                                    
                                    self.unVerifyCountLabel.text!  = String(describing: homeRequests.Count!)
                                    
                                }
                                if(homeRequests.StatusTypeId == 46){
                                    
                                    self.verifyCountLabel.text!  = String(describing: homeRequests.Count!)
                                    
                                }
                                
                                if(homeRequests.StatusTypeId == 47){
                                    
                                     agentReqCount47 =  homeRequests.Count!
                                    
                                }
                                
                                if(homeRequests.StatusTypeId == 48){
                                    
                                     agentReqCount48 =  homeRequests.Count!
                                    
                                }
                                
                self.agentReqCountLabel.text = String(agentReqCount43 +  agentReqCount47 + agentReqCount48)
                                
                                self.stopRefresher()
                                
                            }
                            
                            
                        } else if(isActive == false) {
                            
                            let failMsg = respVO.EndUserMessage
                            
                            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(), messege: failMsg!, clickAction: {
                                
                                
                            })
                            
                        }
                }
                
            },
            failure:  {(error) in
                
                if error == "unAuthorized" {
                
                self.serviceController.refreshTokenForLogin(self, successHandler: { (json) in
                    
                 self.requestsAPICall()
                    
                    
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

//MARK: - Buttun Actions
    
    @IBAction func inprogressClicked(_ sender: Any) {
        
        let requestsVC = self.storyboard?.instantiateViewController(withIdentifier: "InProgressViewController") as! InProgressViewController
        
        let idd:String = "44,45"
        
        requestsVC.statusTypeIdd = idd

        
        self.navigationController?.pushViewController(requestsVC, animated: true)

    }
    
//MARK: - Buttun Actions
    
    @IBAction func pickAgentClicked(_ sender: Any) {
        
        let requestsVC = self.storyboard?.instantiateViewController(withIdentifier: "requestsVC") as! RequestsViewController
        
        let idd:String = "43,47,48"
        
        requestsVC.statusTypeIdd = idd
        
        self.navigationController?.pushViewController(requestsVC, animated: true)

        
    
        
    }

//MARK: - Buttun Actions
    
    @IBAction func newAgentAction(_ sender: Any) {
        
                let newAgentVC = self.storyboard?.instantiateViewController(withIdentifier: "newAgentVC") as? NewAgentRegistrationViewController
        
                 newAgentVC?.directAgentString = "directAgent"
        
                self.navigationController?.pushViewController(newAgentVC!, animated: true)
        
    }
    
//MARK: - Buttun Actions
    
    @IBAction func aprrovedAction(_ sender: Any) {
        
        
                let newAgentVC = self.storyboard?.instantiateViewController(withIdentifier: "InProgressViewController") as! InProgressViewController
        
               let idd:String = "46"
        
                newAgentVC.statusTypeIdd = idd
        
                self.navigationController?.pushViewController(newAgentVC, animated: true)
        
    }
    
    
//MARK: - Buttun Actions
    
    @IBAction func logOutBtnAction(_ sender: Any) {
        
        Utilities.sharedInstance.alertWithYesNoButtonAction(vc: self, alertTitle: "app.Alert".localize(), messege: "app.AreYouSureWantToLogout".localize()) {
            
            let LoginNav : UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginNav") as! UINavigationController
            
    /*        if UserDefaults.standard.object(forKey: AuserName) != nil {
                
                UserDefaults.standard.removeObject(forKey: AuserName)
                UserDefaults.standard.synchronize()
            }
            if UserDefaults.standard.object(forKey: KFirstTimeLogin) as! String == "true" {
                
                UserDefaults.standard.removeObject(forKey: KFirstTimeLogin)
                
                UserDefaults.standard.synchronize()
            }
            if UserDefaults.standard.object(forKey: AId) != nil {
                
                UserDefaults.standard.removeObject(forKey: AId)
                UserDefaults.standard.synchronize()
            }
            if UserDefaults.standard.object(forKey: AmobileNumber) != nil {
                
                UserDefaults.standard.removeObject(forKey: AmobileNumber)
                UserDefaults.standard.synchronize()
            }
            if UserDefaults.standard.object(forKey: Aemail) != nil {
                
                UserDefaults.standard.removeObject(forKey: Aemail)
                UserDefaults.standard.synchronize()
            }
            
            if UserDefaults.standard.object(forKey: ArefreshToken) != nil {
                
                UserDefaults.standard.removeObject(forKey: ArefreshToken)
                UserDefaults.standard.synchronize()
            }
            
            if UserDefaults.standard.object(forKey: KAccessToken) != nil {
                
                UserDefaults.standard.removeObject(forKey: KAccessToken)
                UserDefaults.standard.synchronize()
            }
 
 */
            
            UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
            UserDefaults.standard.synchronize()
            
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = LoginNav
            
        }
        
        
        
    }
    
    


}
