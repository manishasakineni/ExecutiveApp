//
//  AddDocumentViewController.swift
//  Agent Payzan
//
//  Created by CalibrageMac02 on 20/10/17.
//  Copyright © 2017 Naveen. All rights reserved.
//

import UIKit


func getDocumentsURL() -> URL {
    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    return documentsURL
}

func fileInDocumentsDirectory(_ filename: String) -> String {
    
    let fileURL = getDocumentsURL().appendingPathComponent(filename)
    return fileURL.path
    //let profiledata
    
}

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}



class AddDocumentViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDataSource,UITableViewDelegate,UIDocumentPickerDelegate {
    
    
    @IBOutlet weak var headerImgVW: UIImageView!
    @IBOutlet weak var headerImgHeight: NSLayoutConstraint!
    
    var strId : String = ""
    
    var filename : String = ""
    
    var docUrl : URL = NSURL() as URL
    
    @IBOutlet weak var nameLabel: UITextField!
    
    @IBOutlet weak var numberLabel: UITextField!
    
    @IBOutlet weak var imageDocView: UIImageView!
    
    @IBOutlet weak var imageDoc1: UIImageView!
    
    @IBOutlet weak var imageDoc2: UIImageView!
    
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet weak var docTableView: UITableView!
    
    @IBOutlet weak var finishBtn: UIButton!
    
    @IBOutlet weak var uploadBtn: UIButton!
    var image  = UIImage()
    var newImage = UIImage()
    
    var serviceController = ServiceController()
    
    
    fileprivate var documentInteractionController = UIDocumentInteractionController()
    

    var selectedImagesArray: Array<UIImage> = []
    
    
    var imageUrlArr = [String]()
    
    var deleteIdArr = [Int]()
    
    var fileUrlArr = [String]()
    var fileTypeArr = [String]()
    
    @IBOutlet weak var docsCollectionView: UICollectionView!
    
    var userId:String = ""
      var fromBack : Bool = false
    
    var paramsDict = Dictionary<String, Any>()
    
    var myImagePicker = UIImagePickerController()
    
    
    var documentPicker: UIDocumentPickerViewController = UIDocumentPickerViewController(documentTypes:  ["com.apple.iwork.pages.pages", "com.apple.iwork.numbers.numbers", "com.apple.iwork.keynote.key","public.image", "com.apple.application", "public.item","public.data", "public.content", "public.audiovisual-content", "public.movie", "public.audiovisual-content", "public.video", "public.audio", "public.text", "public.data", "public.zip-archive", "com.pkware.zip-archive", "public.composite-content", "public.text"], in: UIDocumentPickerMode.open)
    
    let pickerView = UIPickerView()
    
   private var imagePicked = 0

     var jpgImageData:Data!
    
   private var count = 0
    
    var imageViews:[UIImageView] = []
    
    var ImageBytes:Data!
    
    var ImagePath:String!
    
    var isImageSave:Bool = false
    
    var imageStr:NSString!
    
    var aspNetUserId : String = ""
    var agentReqID : String = ""
    
    var agentIdd : String = ""
    
    var deleteId : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItems = []
        navigationItem.hidesBackButton = true
        for subview in (self.navigationController?.navigationBar.subviews)! {
            
            subview.isHidden = true
        }
        
        documentInteractionController.delegate = self
        
        docTableView.dataSource = self
        docTableView.delegate = self
        
//        saveProfilePic()
        
        
        let defaults = UserDefaults.standard
        
        if let aid = defaults.string(forKey: AId) {
            
            userId = aid
            
            print("defaults savedString: \(userId)")
        }
        
        if let agentId = defaults.string(forKey: "AgentId") {
            
            agentIdd = agentId
            
            print("defaults savedString: \(agentIdd)")
        }
        
        if let uniqueID = defaults.string(forKey: "AspNetUserId") {
            
            aspNetUserId = uniqueID
            
            print("defaults savedString: \(aspNetUserId)")
        }
        
        if let agetReqid = defaults.string(forKey: "AgentRequestId") {
            
            agentReqID = agetReqid
            
            print("defaults savedString: \(aspNetUserId)")
        }
        
        myImagePicker.delegate = self
        documentPicker.delegate = self
        
        myImagePicker.sourceType = .savedPhotosAlbum
        myImagePicker.allowsEditing = false
        
        docsCollectionView.delegate = self
        docsCollectionView.dataSource = self
        
        docsCollectionView.register(UINib.init(nibName : "DocsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DocsCollectionViewCell")
        
        docTableView.register(UINib.init(nibName: "DocTableViewCell", bundle: nil),
                              forCellReuseIdentifier: "DocTableViewCell")
        
        
       saveBtn.isHidden = true
        
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
    
    
    override func viewWillAppear(_ animated: Bool) {

        
        if fromBack == true {

        getAllDocumentsAPICall()
        
        }
        
    }
    
//MARK: - Api call for get All Documents 
    
    func getAllDocumentsAPICall(){
    
        let strUrl = GETDOCUMENTS_API + aspNetUserId
        
        serviceController.requestGETURL(self, strURL:strUrl, success:{(result) in
            DispatchQueue.main.async()
                {
                    
                    let respVO : GetDocumentsVo = Mapper().map(JSONObject: result)!
                    
                    
                    let isActive = respVO.IsSuccess
                    
                    if(isActive == true){
                        
                        if !(respVO.ListResult?.isEmpty)! {

                            self.finishBtn.isEnabled = true
                        
                        let IDInfo = respVO.ListResult

                            
                            self.fileUrlArr.removeAll()
                            self.fileTypeArr.removeAll()
                            self.imageUrlArr.removeAll()
                            self.deleteIdArr.removeAll()
                        
                        for(_,element) in (IDInfo?.enumerated())! {
                            
                            
                            self.imageUrlArr.append(element.FileUrl!)
                            
                            self.fileUrlArr.append(element.FileName!)
                            
                            self.deleteIdArr.append(element.Id!)
                            self.fileTypeArr.append(element.FileExtension!)
                            
                        }
                        
                        self.docTableView.reloadData()
                        }
                        else {

                            //self.finishBtn.isEnabled = false
                            
                        }
                        
                    } else if(isActive == false) {
                        
                        
                        
                    }
            }
            
        },
        failure:  {(error) in
            
            
            if error == "unAuthorized" {
                
                self.serviceController.refreshTokenForLogin(self, successHandler: { (json) in
                    
                    self.getAllDocumentsAPICall()
                    
                    
                }, failureHandler: { (failureMassage) in
                    
                    Utilities.sharedInstance.goToLoginScreen()
                    
                })
                
            }

            
        })
        
    
    }
    
//MARK: - Api call for delete
    
    func deleteGetService(delId:String!){
        
        let strUrl = DELETEDOCUMENT_API + delId

        
        serviceController.requestGETURL(self, strURL:strUrl, success:{(result) in
            DispatchQueue.main.async()
                {
                    
                    let respVO:DeleteDocVo = Mapper().map(JSONObject: result)!
                    
                    
                    let isActive = respVO.IsSuccess
                    
                    if(isActive == true){
                        
                        if !(respVO.ListResult?.isEmpty)! {
                            
                            let successMsg = respVO.EndUserMessage
                            
                            self.docsCollectionView.reloadData()
                            self.getAllDocumentsAPICall()
                            self.docTableView.reloadData()
                            
                            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Success".localize(), messege: successMsg!, clickAction: {
                                
                                
                            })
                            
                            
                        }
                        
                        
                        else{
                        
                        
                            let successMsg = respVO.EndUserMessage
                            
                            self.docsCollectionView.reloadData()
                            self.getAllDocumentsAPICall()
                            self.docTableView.reloadData()
                            
                            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Success".localize(), messege: successMsg!, clickAction: {
                                
                                
                            })
                        
                        }
                        
                        
                        
                        
                    } else if(isActive == false) {
                        
                        let successMsg = respVO.EndUserMessage
                        
                        
                        Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Success".localize(), messege: successMsg!, clickAction: {
                            
                            
                        })
                        
                    }
            }
            
        },
                                        
        failure:  {(error) in
            
            
            if error == "unAuthorized" {
                
                self.serviceController.refreshTokenForLogin(self, successHandler: { (json) in
                    
                    self.deleteGetService(delId: self.strId)
                    
                    
                }, failureHandler: { (failureMassage) in
                    
                    Utilities.sharedInstance.goToLoginScreen()
                    
                })
                
            }
            
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//MARK: - Button Actions
    
    @IBAction func backAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitAction(_ sender: Any) {
        

}
    
    func addDocumentPostService(){
        
        
        
        for row in 0 ..< docsCollectionView.numberOfItems(inSection: 0)
        {
            
            let indexPath : IndexPath = IndexPath(row: row, section: 0)
  
            if let newCell : DocsCollectionViewCell = docsCollectionView.cellForItem(at: indexPath) as? DocsCollectionViewCell {
                
                let imageData = UIImagePNGRepresentation(newCell.docsImage.image!)


        let base64String = imageData!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
                
        
        let agentDocDict = [
            
            "AgentId": aspNetUserId,
            "FileTypeId": 23,
            "FileExtension": ".png",
            "Base64File": base64String,
            "IsActive": true,
            "CreatedBy": userId,
            "ModifiedBy": userId
            
            ] as [String : Any]
        
        
        
        let dictHeaders = ["":"","":""] as NSDictionary
        
        //    let dictHeaders = ["Authorization":UserDefaults.standard.value(forKey: accessToken) as! String,"Authorization":UserDefaults.standard.value(forKey: accessToken) as! String] as NSDictionary
        
        print("dictHeader:\(dictHeaders)")
        
        let strUrl = AGENTDOCUMENTS_API
        
        serviceController.requestPOSTURL(self, strURL: strUrl as NSString, postParams: agentDocDict as NSDictionary, postHeaders: dictHeaders, successHandler:{(result) in
            DispatchQueue.main.async()
                {
                    
                    print("result:\(result)")
                    
                    let respVO:AgentDocumentsVo = Mapper().map(JSONObject: result)!
                    
                    
                    let statusCode = respVO.IsSuccess
                    
                    print("StatusCode:\(String(describing: statusCode))")
                    
                    
                    if statusCode == true
                    {
                        
                        let successMsg = respVO.EndUserMessage
                        
                        self.docTableView.reloadData()
                        self.getAllDocumentsAPICall()
                        self.saveBtn.isHidden = true
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
                        
                        Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(), messege: "app.ServerError".localize(), clickAction: {
                            
                            
                        })
                    }
            }
        }, failureHandler: {(error) in
            
            
            if error == "unAuthorized" {
                
                self.serviceController.refreshTokenForLogin(self, successHandler: { (json) in
                    
                    self.addDocumentPostService()
                    
                    
                }, failureHandler: { (failureMassage) in
                    
                    Utilities.sharedInstance.goToLoginScreen()
                    
                })
                
            }
        })
                
            }
           
            self.docTableView.reloadData()
            

            
        }
    }
    
//MARK: - resize Image
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
   
//MARK: - Button Actions
    
    @IBAction func addDcocAction(_ sender: UIButton) {
        
        fromBack = false
 
        
        let menu = UIAlertController(title: nil, message: "app.SelectImage".localize(), preferredStyle: .actionSheet)
        
        let gallery = UIAlertAction(title: "app.FromGallery".localize(), style: .default, handler: { (alert : UIAlertAction!)
            -> Void in
            
            
            print("select from gallery")
            
            
            self.myImagePicker.delegate = self
            
            self.myImagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            
            
            self.myImagePicker.allowsEditing = false
            
            self.present(self.myImagePicker, animated : true){
                
                ///
            }
            
            
            
        })
        
        let camera = UIAlertAction(title: "app.FromCamera".localize(), style: .default, handler: { (alert : UIAlertAction!)
            -> Void in
            
            
            print("select from camera")
            
            self.myImagePicker.delegate = self
            
            self.myImagePicker.sourceType = UIImagePickerControllerSourceType.camera
            
            self.myImagePicker.allowsEditing = false
            
            self.present(self.myImagePicker, animated : true){
                
                ///
            }
            
            
            
        })
        
        let document = UIAlertAction(title: "app.UploadDocument".localize(), style: .default, handler: { (alert : UIAlertAction!)
            -> Void in

            
      
            self.documentPicker.delegate = self
            
            self.present(self.documentPicker, animated: true, completion: {
            
            print("documentPicker presented")
            })
            
            
        })
        
        
        let cancel = UIAlertAction(title: "app.Cancel".localize(), style: .cancel, handler: nil)
        
        
        menu.addAction(gallery)
        menu.addAction(camera)
        menu.addAction(document)
        menu.addAction(cancel)
       
        
        
        // present(menu, animated: true, completion: nil)
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone) {
            
            
            present(menu, animated: true, completion: nil)
        }
            
        else{
            
            let popup = UIPopoverController.init(contentViewController: menu)
            
            popup.present(from: CGRect(x:self.view.frame.size.width/2, y:self.view.frame.size.height/4, width:0, height:0), in: self.view, permittedArrowDirections: UIPopoverArrowDirection.any, animated: true)
            
            // CGRect(x: 0, y: 0, width: 100, height: 100)
        }
        
    }
    
    
    @IBAction func AddPdfClicked(_ sender: Any) {
        
       
       
        
        
    } 
    
//MARK: - documentPicker Delegate methods
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        
        self.docUrl = url as URL
        
         print("The Url is : \(docUrl)")
        
        self.filename = docUrl.pathExtension
        
        print("The Url is : \(filename)")

        
        self.documentPickAPICall()
        
//        let webView = WKWebView(frame: CGRect(x:20,y:20,width:view.frame.size.width-40, height:view.frame.size.height-40))
//        webView.load(data, mimeType: "application/pdf", characterEncodingName:"", baseURL: pdfURL.deletingLastPathComponent())
//        view.addSubview(webView)
        
        let fileManager = FileManager.default
        let documentsUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0] as NSURL
        print(documentsUrl)
        
        do
        {
//            let fileDictionary = try FileManager.default.attributesOfItem(atPath: path)
//            let fileSize = fileDictionary[FileAttributeKey.size]
//            print ("\(fileSize)")
        }
        catch{
            print("Error: \(error)")
        }
        let localDocumentsURL = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: .userDomainMask).last
        let iCloudDocumentsURL = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent("Documents")
        //        URLForUbiquityContainerIdentifier(nil)?.appendPathComponent("Documents")
        //        URLByAppendingPathComponent("Documents").URLByAppendingPathComponent("iTunes File Sharing")
        
        if let iCloudDocumentsURL = iCloudDocumentsURL {
            var error:NSError?
            var isDir:ObjCBool = false
            if (FileManager.default.fileExists(atPath: iCloudDocumentsURL.path, isDirectory: &isDir)) {
                
                
                do {
                    
                    try FileManager.default.removeItem(at: iCloudDocumentsURL)
  
                }
                catch {
                    
                    
                }
                
            }
            
            
        }

        
    }
    
    
    func documentPickAPICall(){
    
    
        if filename == "pdf" || filename == "Doc" || filename == "doc" || filename == "docx" || filename == "Docx" || filename == "Txt" || filename == "txt" || filename == "rtf"{
            
            do {
                
                Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "app.Alert".localize(), messege: "app.Areyousurewanttouploadthisdocument?".localize()) {
                    
                    let fileExt:String = "." + self.filename
                    
                    let data = try! Data(contentsOf: self.docUrl)
                    
                    print("The data is : \(data)")
                    
                    let base64String = data.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
                    
                    
                    let agentDocDict = [
                        
                        "AgentId": self.aspNetUserId,
                        "FileTypeId": 22,
                        "FileExtension": fileExt,
                        "Base64File": base64String,
                        "IsActive": true,
                        "CreatedBy": self.userId,
                        "ModifiedBy": self.userId
                        
                        ] as [String : Any]
                    
                    
                    
                    let dictHeaders = ["":"","":""] as NSDictionary
                    
                    //    let dictHeaders = ["Authorization":UserDefaults.standard.value(forKey: accessToken) as! String,"Authorization":UserDefaults.standard.value(forKey: accessToken) as! String] as NSDictionary
                    
                    print("dictHeader:\(dictHeaders)")
                    
                    let strUrl = AGENTDOCUMENTS_API
                    
                    self.serviceController.requestPOSTURL(self, strURL: strUrl as NSString, postParams: agentDocDict as NSDictionary, postHeaders: dictHeaders, successHandler:{(result) in
                        DispatchQueue.main.async()
                            {
                                
                                print("result:\(result)")
                                
                                let respVO:AgentDocumentsVo = Mapper().map(JSONObject: result)!
                                
                                
                                let statusCode = respVO.IsSuccess
                                
                                print("StatusCode:\(String(describing: statusCode))")
                                
                                
                                if statusCode == true
                                {
                                    
                                    let successMsg = respVO.EndUserMessage
                                    
                                    self.getAllDocumentsAPICall()
                                    //                            self.docTableView.reloadData()
                                    self.getAllDocumentsAPICall()
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
                                    
                                    Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(), messege: "app.Success".localize(), clickAction: {
                                        
                                        
                                    })
                                }
                        }
                    }, failureHandler: {(error) in
                        
                        
                    })
                    
                }
                
                
            }
            catch {
                
                print("Error")
            }
        }
            
        else {
            
            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(), messege: "app.Thatdocumentnotaccessing".localize(), clickAction: {
                
                
            })
            
        }
    
    
    
    }
    
    
    @available(iOS 8.0, *)
    
   public func documentMenu(_ documentMenu:     UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        
        documentPicker.delegate = self as UIDocumentPickerDelegate
        present(documentPicker, animated: true, completion: nil)
        
    }
    
    
    
    @available(iOS 8.0, *)
    
   public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        
     // self.presentedViewController?.dismiss(animated: true, completion: nil)
            self.documentPicker = UIDocumentPickerViewController(documentTypes:  ["com.apple.iwork.pages.pages", "com.apple.iwork.numbers.numbers", "com.apple.iwork.keynote.key","public.image", "com.apple.application", "public.item","public.data", "public.content", "public.audiovisual-content", "public.movie", "public.audiovisual-content", "public.video", "public.audio", "public.text", "public.data", "public.zip-archive", "com.pkware.zip-archive", "public.composite-content", "public.text"], in: UIDocumentPickerMode.open)
//         documentPicker.delegate = self
        dismiss(animated: true, completion: {
            print("we cancelled")
            
            
        })
        
//        self.documentPicker.dismiss(animated: true) { 
//          print("we cancelled")  
//        }
        
        
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        if self.presentedViewController == nil {
            // dismissed by the user
         //   myDocument.delete()
        } else {
            // dismissed by the UIDocumentPickerViewController
            // do nothing
        }
        super.dismiss(animated: flag, completion: completion)
    }
    
    
    @IBAction func saveBtnAction(_ sender: UIButton) {

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        image = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
        
        
        let size = CGSize(width: 400, height: 400)
        newImage = resizeImage(image: image,targetSize : size)
        
        
        
        selectedImagesArray.append(newImage)
        
        docsCollectionView.reloadData()
        docTableView.reloadData()

        
        self.dismiss(animated: true, completion: nil)
    }
    
    func getArrayOfBytesFromImage(imageData:NSData) -> NSMutableArray
    {
        
        // the number of elements:
        let count = imageData.length / MemoryLayout<UInt8>.size
        
        // create array of appropriate length:
        var bytes = [UInt8](repeating: 0, count: count)
        
        // copy bytes into array
        imageData.getBytes(&bytes, length:count * MemoryLayout<UInt8>.size)
        
        let byteArray:NSMutableArray = NSMutableArray()
        
        
        for i in (0..<bytes.count){
        
            byteArray.add(NSNumber(value: bytes[i]))
        }
        
        
//        print("byteArray:\(byteArray)")
        
        return byteArray
        
        
    }
    
    func saveImage (_ image: UIImage, path: String ) -> Bool{
        
        isImageSave = true
        
        //let pngImageData = UIImagePNGRepresentation(image)
        let jpgImageData = UIImageJPEGRepresentation(image, 1.0)   // if you want to save as JPEG
        let result = (try? jpgImageData!.write(to: URL(fileURLWithPath: path), options: [.atomic])) != nil
        
        return result
    }
    
    func saveProfilePic() {
        
        let base64String = self.jpgImageData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0)) // encode the image
        
//        print(base64String.imageFormat)
        
        let dictSave:NSDictionary = NSDictionary(objects: [base64String], forKeys:["picture" as NSCopying])
        
        let jsonData:Data = try! JSONSerialization.data(withJSONObject: dictSave, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        print("jsonData\(jsonData)")
        
        ImageBytes = jsonData
        
        
        
        
        let jsonString:NSString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)!
        
        imageStr = jsonString
        

        
    }
    
    
 //MARK: - collectionView delegate methods
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return selectedImagesArray.count

    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DocsCollectionViewCell", for:
        indexPath) as! DocsCollectionViewCell
        
        if selectedImagesArray.count > 0{
       
         cell.docsImage.image = selectedImagesArray[indexPath.row]
         saveBtn.isHidden = false
            
        }
        if  self.selectedImagesArray.count < 0 {
            self.saveBtn.isHidden = true
            
        }
//        else {
//          
//            cell.docsImage.image = newImage
//        }
        
        cell.closeBtn?.layer.setValue(indexPath.row, forKey: "index")
        cell.closeBtn.addTarget(self, action: #selector(closeBtnClicked), for: .touchUpInside)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
     //   let imageView = UIImageView(image: UIImage(named: selectedImagesArray[indexPath.row]))
        
        let imageView = UIImageView()
        
        imageView.image = selectedImagesArray[indexPath.row]
        imageView.frame = self.view.frame
        imageView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        imageView.contentMode = .center
        imageView.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        imageView.addGestureRecognizer(tap)
        
        self.view.addSubview(imageView)
    }
    
    
    
 //MARK: - tableview delegate methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
            return fileUrlArr.count
      
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocTableViewCell") as! DocTableViewCell
        
        if fileUrlArr.count > indexPath.row{
            
            let fileName = fileUrlArr[indexPath.row]
            
            cell.imageName.text = String(fileName)

            
            cell.selectionStyle = .none
            
            cell.imageUrlLabel.isHidden = true
            cell.deleteId.isHidden = true
            
            cell.deleteBtn.tag = indexPath.row
            
            cell.dowloadBtn?.layer.setValue(indexPath.row, forKey: "index")
            cell.deleteBtn?.layer.setValue(indexPath.row, forKey: "index")
            
            cell.dowloadBtn.tag = indexPath.row
            
            cell.dowloadBtn.addTarget(self, action: #selector(downloadBtnClicked), for: .touchUpInside)
            cell.deleteBtn.addTarget(self, action: #selector(deleteBtnAction), for: .touchUpInside)

            
            let fileExt = fileTypeArr[indexPath.row]
            
            if !(fileExt == ".png") && !(fileExt == ".jpg"){
                
                cell.imageDoc.image = UIImage(named:"pdf_sbi")
            }
            else {
                
                cell.imageDoc.image = UIImage(named:"jpg_sbi")
            }
        
        }
        
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 80
    }
    
    func downloadBtnClicked(sender: UIButton){
        
        
        
        let indexPath : IndexPath = IndexPath(row: sender.tag, section: 0)
        
        if let newCell : DocTableViewCell = docTableView.cellForRow(at: indexPath) as? DocTableViewCell {
            
//            newCell.imageUrlLabel.text = imageUrlArr[indexPath.row]
            
           
            
            let fileExt = fileTypeArr[indexPath.row]
            
            let imageUrl = imageUrlArr[indexPath.row]
            
            if fileExt == ".png" || fileExt == ".jpg"{
                
                let newString = imageUrl.replacingOccurrences(of: "\\", with: "/", options: .backwards, range: nil)
                
                print("filteredUrlString:\(newString)")
                
                let url = URL(string:newString)
                
                let data = try? Data(contentsOf: url!)
                
                
                let imageView: UIImage = UIImage(data: data!)!
                
                UIImageWriteToSavedPhotosAlbum(imageView, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
            }
            else {
                
                
                
                let docString = imageUrl.replacingOccurrences(of: "\\", with: "/", options: .backwards, range: nil)
                
                if let url = URL(string: docString) {
                    
                    UIApplication.shared.openURL(url)
                }
                
            }
            

    
    }
    }
    

    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    //MARK: - Saving Image here
    @IBAction func save(_ sender: AnyObject) {
        
        
    }
    
    //MARK: - Add image to Library
    func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "app.Saveerror".localize(), message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "app.OK".localize(), style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "app.Saved!".localize(), message: "app.Youralteredimagehasbeensavedtoyourphotos".localize(), preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "app.OK".localize(), style: .default))
            present(ac, animated: true)
        }
    }
    
    func deleteBtnAction(sender: UIButton){
        
        
        let indexPath : IndexPath = IndexPath(row: sender.tag, section: 0)
        
        
        if let _ : DocTableViewCell = docTableView.cellForRow(at: indexPath) as? DocTableViewCell {
            
            let id = deleteIdArr[indexPath.row]
            
          //  let strId:String = String(id)
            
            self.strId = String(id)
            
            let i : Int = (sender.layer.value(forKey: "index")) as! Int
            
            print("IValue:\(i)")
            
            
            
            Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "app.Alert".localize(), messege: "app.Areyousurewanttodeletethisdocument?".localize()) {
                
                
                self.deleteGetService(delId: self.strId)
                
                self.fileUrlArr.remove(at: i)
                self.fileTypeArr.remove(at: i)
                
                self.docTableView.reloadData()
                self.docsCollectionView.reloadData()
                
                if self.fileUrlArr.isEmpty {

                   // self.finishBtn.isEnabled = false
                    
                }
                
            }

            
        }
    
        
    }
    
    
    
 //MARK: -    Use to back from full mode
    
    func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
    }
    
    func closeBtnClicked(sender:UIButton){
    
        let i : Int = (sender.layer.value(forKey: "index")) as! Int
        
        
         Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "app.Alert".localize(), messege: "app.Areyousurewanttodeletethisimage?".localize()) {
        
        self.selectedImagesArray.remove(at: i)
            
            if self.selectedImagesArray.count > 0{
                
                self.saveBtn.isHidden = false
            
            }
            else {
            
            self.saveBtn.isHidden = true
            
            }
            
        self.docTableView.reloadData()
        self.getAllDocumentsAPICall()
          
          
        self.docsCollectionView.reloadData()
            
        }
    
    }
    
//MARK: - Butoon Actions 
    
    @IBAction func logOutBtnAction(_ sender: Any) {
        
        Utilities.sharedInstance.alertWithYesNoButtonAction(vc: self, alertTitle: "app.Alert".localize(), messege: "app.AreYouSureWantToLogout".localize()) {
            
            let LoginNav : UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginNav") as! UINavigationController
            
            UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
            UserDefaults.standard.synchronize()
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = LoginNav
            
        }

        
    }
    

    
    @IBAction func buttonClicked(_ sender: UIButton) {

        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func uploadBtnAction(_ sender: Any) {
        
       

        if selectedImagesArray.count != 0 {
            
         if(appDelegate.checkInternetConnectivity()){
        
        
           addDocumentPostService()

            self.selectedImagesArray.removeAll()
            self.docsCollectionView.reloadData()

            
         }
         else {
            
            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(), messege: "app.Pleasecheckyourinternetconnection!".localize(), clickAction: {
                
                
            })
            
            }
            
        }
        else {
            
            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(), messege: "app.Pleaseadddocuments".localize(), clickAction: {
                
                
            })
        }
        
    }
    
    
    
    func validations() -> Bool{
        
        var errorMessage:NSString?
        
        if fileUrlArr.count == 0 && selectedImagesArray.count == 0 {
            
         errorMessage = GlobalSupportingClass.addDocumentMessage() as String as String as NSString?

        
        }
        
        if let errorMsg = errorMessage{
            
            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Alert".localize(), messege: errorMsg as String, clickAction: {})
            
            return false
        }

        
        
    return true
    
    
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        
        
        let homeNav : UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeNav") as! UINavigationController
       
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = homeNav
        
        
    }
    
    @IBAction func finishBtnAction(_ sender: Any) {
        
        if validations(){
        
        if(appDelegate.checkInternetConnectivity()){
            
            UpdateAgentRequestAPICall()
        }
        else {
            
            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(), messege: "app.Pleasecheckyourinternetconnection!".localize(), clickAction: {
                
                
            })
            
        }
        
        }
        
    }
    

    
    func copyDocumentsToiCloudDrive() {
        
        let localDocumentsURL = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: .userDomainMask).last
        let iCloudDocumentsURL = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent("Documents")
//        URLForUbiquityContainerIdentifier(nil)?.appendPathComponent("Documents")
//        URLByAppendingPathComponent("Documents").URLByAppendingPathComponent("iTunes File Sharing")
        
        if let iCloudDocumentsURL = iCloudDocumentsURL {
            var error:NSError?
            var isDir:ObjCBool = false
            if (FileManager.default.fileExists(atPath: iCloudDocumentsURL.path, isDirectory: &isDir)) {
              
                
                do {
                    
                   try FileManager.default.removeItem(at: iCloudDocumentsURL)

                }
                catch {
                    
                    
                }

            }
            
            
        }
    }
    
    
    func UpdateAgentRequestAPICall(){

        let paramsDict = [ "AgentRequestId": agentReqID,
                           "StatusTypeId": 45,
                           "AssignToUserId": userId,
                           "Comments": "finish",
                           "Id": 0,
                           "IsActive": true ] as [String:Any]

        
        print("paramsDict:\(paramsDict)")
        
        
        let dictHeaders = ["":"","":""] as NSDictionary
        
        //    let dictHeaders = ["Authorization":UserDefaults.standard.value(forKey: accessToken) as! String,"Authorization":UserDefaults.standard.value(forKey: accessToken) as! String] as NSDictionary
        
        print("dictHeader:\(dictHeaders)")
        
        let strUrl = UPDATEAGENTREQUESTINFO_API
        
        serviceController.requestPOSTURL(self, strURL: strUrl as NSString, postParams: paramsDict as NSDictionary, postHeaders: dictHeaders, successHandler:{(result) in
            DispatchQueue.main.async()
                {
                    
                    print("result:\(result)")
                    
                    let respVO:AgentRequestStatusHistoryInfoVo = Mapper().map(JSONObject: result)!
                    
                    
                    let statusCode = respVO.IsSuccess
                    
                    print("StatusCode:\(String(describing: statusCode))")
                    
                    
                    if statusCode == true
                    {
                        
                        let successMsg = respVO.EndUserMessage
                        
                        
                        Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Success".localize(), messege: successMsg!, clickAction: {

                               let homeNav : UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeNav") as! UINavigationController

                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            appDelegate.window?.rootViewController = homeNav
                            

                            
                        })
                        
                    }
                        
                    else if statusCode == false{
                        
                        let failMsg = respVO.EndUserMessage
                        
                        Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(), messege: failMsg!, clickAction: {
                            
                     })
                        
                        
                    }
                        
                    else
                    {

                        Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "app.Warning".localize(), messege: "app.ServerError".localize(), clickAction: {
                            
                            
                        })
                    }
            }
        }, failureHandler: {(error) in
            
            if error == "unAuthorized" {
                
                self.serviceController.refreshTokenForLogin(self, successHandler: { (json) in
                    
                    self.UpdateAgentRequestAPICall()
                    
                    
                }, failureHandler: { (failureMassage) in
                    
                    Utilities.sharedInstance.goToLoginScreen()
                    
                })
                
            }
  
            
        })
        
        
    }

    
}

struct ImageHeaderData{
    
    static var PNG: [UInt8] = [0x89]
    static var JPEG: [UInt8] = [0xFF]
    static var GIF: [UInt8] = [0x47]
    static var TIFF_01: [UInt8] = [0x49]
    static var TIFF_02: [UInt8] = [0x4D]
}

enum ImageFormat{
    case Unknown, PNG, JPEG, GIF, TIFF
}
extension Data {
    
    var format: String {
        let array = [UInt8](self)
        let ext: String
        switch (array[0]) {
        case 0xFF:
            ext = "jpg"
        case 0x89:
            ext = "png"
        case 0x47:
            ext = "gif"
        case 0x49, 0x4D :
            ext = "tiff"
        default:
            ext = "unknown"
        }
        return ext
    }
}
extension AddDocumentViewController: UIDocumentInteractionControllerDelegate {
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    
}

extension NSData{
    var imageFormat: ImageFormat{
        var buffer = [UInt8](repeating: 0, count: 1)
        self.getBytes(&buffer, range: NSRange(location: 0,length: 1))
        if buffer == ImageHeaderData.PNG
        {
            return .PNG
        } else if buffer == ImageHeaderData.JPEG
        {
            return .JPEG
        } else if buffer == ImageHeaderData.GIF
        {
            return .GIF
        } else if buffer == ImageHeaderData.TIFF_01 || buffer == ImageHeaderData.TIFF_02{
            return .TIFF
        } else{
            return .Unknown
        }
    }
}

