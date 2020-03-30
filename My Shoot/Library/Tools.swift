//
//  Tools.swift
//  My Shoot
//
//  Created by Mohamed Ali on 3/24/20.
//  Copyright © 2020 Mohamed Ali. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage
import SVProgressHUD

class Tools {
    
    public static func setLeftPadding (textfield:UITextField , Text:String, padding:Double) {
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: padding, height: 2.0))
        textfield.leftView = leftView
        textfield.leftViewMode = .always
        textfield.placeholder = Text
    }
    
    public static func MakeCircle (_ image:AnyObject) {
        image.layer.borderWidth = 1
        image.layer.masksToBounds = false
        image.layer.backgroundColor = UIColor.black.cgColor
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.cornerRadius = image.frame.height/2
    }
    
    public static func createAlert (Title:String , Mess:String , ob:UIViewController)
    {
        let alert = UIAlertController(title: Title , message:Mess
            , preferredStyle:UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title:"OK",style:UIAlertAction.Style.default,handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
        ob.present(alert,animated:true,completion: nil)
    }
    
    public static func addDataToFirebase(collectionName:String , dic:[String:Any] , Mess:String , ob:UIViewController) {
        Firestore.firestore().collection(collectionName).document().setData(dic){
            err in
            if err != nil {
                SVProgressHUD.dismiss()
                print("Error!")
            }
            else {
                SVProgressHUD.dismiss()
                Tools.createAlert(Title: "Sucess", Mess: Mess, ob: ob)
            }
        }
    }
    
    
    public static func UploadImage(url:String , GlobalImage:UIImage , name:String)  -> String {
        let StorageRef = Storage.storage().reference(forURL: url)
        
        // convert image to Data
        var data = NSData()
        data = GlobalImage.jpegData(compressionQuality:0.8)! as NSData
        let dateFormate = DateFormatter()
        dateFormate.dateFormat = "DD_MM_yy_h_mm_a"
        //let imagename = dateFormate.string(from: NSDate() as Date)
        let SS = name
        let FinalName = "\(SS).jpg"
        // Create storage reference
        let mainReference = StorageRef.child(FinalName)
        
        // Create file metadata including the content type
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        // upload file and metadata
        mainReference.putData(data as Data, metadata: metadata)
        
        return FinalName
    }
    
    public static func downloadImage(FolderURL:String , url:String , Image:UIImageView)  {
        
        SVProgressHUD.show()
        let StorageRef = Storage.storage().reference(forURL: FolderURL)
        
        let islandRef = StorageRef.child(url)
        
        islandRef.getData(maxSize: 8*1024*1024) { (data, error) in
            if let error = error {
                print(error)
            } else {
                Image.image = UIImage(data: data!)
                SVProgressHUD.dismiss()
            }
        }
    }
}
