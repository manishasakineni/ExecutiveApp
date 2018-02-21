//
//  AgentRequestViewController.swift
//  Agent Payzan
//
//  Created by Nani Mac on 07/10/17.
//  Copyright © 2017 Naveen. All rights reserved.
//

import UIKit

class AgentRequestViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {
    
    var getStatesAPIModelArray : Array<ParametersAPIModel> = Array()
    
    
    @IBOutlet weak var agentTableview: UITableView!
    
    let agentReqPicker = UIPickerView()
    
    var pickerData = Array<String>()
    
    var placeholdersAry  = ["State Name","District","Mandal","Village","First Name","Middle Name","Last Name","","Email ID","Address 1","Address 2","Land Mark","Enter your comments"]
    
    var sampleStatesAry = ["State 1","State 2","State 3","State 4","State 5"]
    
    var sampleDistrictsAry = ["District 1","District 2","District 3","District 4","District 5"]
    
  //  var statesAry = NSMutableArray()
    
    var stateStr = String()
    
    var districtStr = String()
    
    var activeTextField : UITextField?
    

    override func viewDidLoad() {
        super.viewDidLoad()


////// Register AgentReqTableViewCell ///////
    
        let nib = UINib(nibName : "AgentReqTableViewCell", bundle : nil)
        agentTableview.register(nib, forCellReuseIdentifier: "AgentReqTableViewCell")
        
        let nib1 = UINib(nibName : "PhoneNoTableViewCell", bundle : nil)
        agentTableview.register(nib1, forCellReuseIdentifier: "PhoneNoTableViewCell")
        
        let nib2 = UINib(nibName : "ButtonsTableViewCell", bundle : nil)
        agentTableview.register(nib2, forCellReuseIdentifier: "ButtonsTableViewCell")
        
         agentReqPicker.delegate = self
         agentReqPicker.dataSource = self
      
         self.getStatesAPICall()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    func getStatesAPICall()  {
    
    
        let classTypeID = "1"
        APIModel.sharedInstance.getRequest(self, withUrl: STATES_API + classTypeID, successBlock: { (json) in
            
            if(json.count > 0){
                
            let getStatesArray = ParsingModelClass.sharedInstance.getStatesAPIModelParsing(object: json as AnyObject?)
                
                if(getStatesArray.count > 0){
                    for stateInfo in getStatesArray{
                        
                        if let stateName = stateInfo.name as? String{
                            
                            print(stateName)
                        }
                    }
                    
                }
                
             
            }
            
          //  print("getStatesAPIModelArray:", self.getStatesAPIModelArray)
            
        }) { (fail) in
          
            print("Fail")
        }
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    
//    override func viewDidAppear(_ animated: Bool) {
//        
//        
//        self.navigationController?.isNavigationBarHidden = true
//    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return 14
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 40
        
    }
    
 
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        let view = UIView(frame: CGRect(x: 0, y: 5, width: agentTableview.frame.size.width, height: 40))
        /* Create custom view to display section header... */
        let label = UILabel(frame: CGRect(x: 0, y: 5, width: agentTableview.frame.size.width, height: 20))
       // label.font = UIFont.boldSystemFont(ofSize: 15)
        
        label.font = UIFont(name: "HelveticaNeue", size: 17)
        let string: String = "Agent Request"
        /* Section header is in 0th index... */
        label.text = string
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.addSubview(label)
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return view
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
       
        
        if indexPath.row == 7 {
            
            let cell1 = agentTableview.dequeueReusableCell(withIdentifier: "PhoneNoTableViewCell", for: indexPath) as! PhoneNoTableViewCell
            
//            let cell1 = Bundle.main.loadNibNamed("PhoneNoTableViewCell", owner: self, options: nil)?.first as!      
//              PhoneNoTableViewCell
            
            cell1.phoneNoDropdownBtn.addTarget(self, action: #selector(phoneNoDropdownBtnClicked), for: .touchUpInside)
            cell1.phoneNoTF.placeholder="Mobile Number"
            
            return cell1
        }
        
        if indexPath.row == 13 {
            
            let cell2 = agentTableview.dequeueReusableCell(withIdentifier: "ButtonsTableViewCell", for: indexPath) as! ButtonsTableViewCell
        
 
            return cell2
        }
        
        
        else
        {
            let cell3 = agentTableview.dequeueReusableCell(withIdentifier: "AgentReqTableViewCell", for: indexPath) as! AgentReqTableViewCell
        
             cell3.agentDetailsTF.placeholder = placeholdersAry[indexPath.row]
            
             cell3.agentDetailsTF.tag = indexPath.row
             cell3.agentDetailsTF.delegate = self
           
            
            
            
             if indexPath.row == 0 {
                
                agentReqPicker.tag = 0
                
              cell3.agentDetailsTF.inputView = agentReqPicker
                
              cell3.agentDetailsTF.text = stateStr
                
               
                
            }
            
            else if indexPath.row == 1 {
                
                agentReqPicker.tag = 1
                
                cell3.agentDetailsTF.inputView = agentReqPicker

                cell3.agentDetailsTF.text = districtStr
                
                
            }
                
             if indexPath.row == 2 {
                
           //     cell3.agentDetailsTF.inputView = agentReqPicker
             
                
           //     cell3.agentDetailsTF.text = stateStr
                
            }
       
            
            return cell3
        }
    }
    
    
    
    func phoneNoDropdownBtnClicked() {
    
    print("phoneNoDropdownBtnClicked")
        

    }
    
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        
        
        if textField.tag == 6 {
            
            
        }
        
    return true
        
        
        
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        activeTextField = textField
        
        if textField.tag == 0 {
        
            pickerData = sampleStatesAry
            
            agentReqPicker.reloadAllComponents()
            agentReqPicker.selectRow(0, inComponent: 0, animated: false)
        
        }
        
        
        else if textField.tag == 1{
        
        
            pickerData = sampleDistrictsAry
            agentReqPicker.reloadAllComponents()
            agentReqPicker.selectRow(0, inComponent: 0, animated: false)
        
        }
        
       
        
    }
    
 ///////////// pickerView //////////
    
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

       
        if(activeTextField?.tag == 0){
            
            stateStr = sampleStatesAry[row]
            
        }else if(activeTextField?.tag == 1){
            districtStr = sampleDistrictsAry[row]
        }
      
        
          self.agentTableview.endEditing(true)
        
          agentTableview.reloadData()
        
       
        
    }
    
    
    
    @IBAction func backClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }

}
