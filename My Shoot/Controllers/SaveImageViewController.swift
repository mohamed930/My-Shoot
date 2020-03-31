//
//  SaveImageViewController.swift
//  My Shoot
//
//  Created by Mohamed Ali on 3/24/20.
//  Copyright © 2020 Mohamed Ali. All rights reserved.
//

import UIKit
import SVProgressHUD
import SafariServices
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore
import Alamofire

class SaveImageViewController: UIViewController {
    
    // TODO: This Sektion for Intialize The Varible Here
    @IBOutlet weak var ImageCover: UIImageView!
    var PickImageURL:ImageData?
    var URL1:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DownloadImage()
    }
    
    // TODO: This Action Method For Button Back
    @IBAction func BTNBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var coin = 0
    var id = ""
    
    // TODO: This Action Method For Button Save
    @IBAction func BTNSave(_ sender: Any) {
        
        // Make Action Sheet For cHooce Action
        let alert = UIAlertController(title: "Attention", message: "Chooce Your Action", preferredStyle: .actionSheet)
        
        let action1 = UIAlertAction(title: "Download Image", style: .default) { (alert) in
            self.buyImage()
        }
        alert.addAction(action1)
        
        let action2 = UIAlertAction(title: "Add To BookMarks", style: .default) { (alert) in
            self.SaveToBookMarks()
        }
        alert.addAction(action2)
        
        let action3 = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(action3)
        
        present(alert,animated: true,completion: nil)
        
        
    }
    
    // TODO: This Method Check If You Have Flix Coin or not to buy Image.
    func buyImage() {
        SVProgressHUD.show()
        let Email = Auth.auth().currentUser?.email
        
        Firestore.firestore().collection("Guest").whereField("Email", isEqualTo: Email!).getDocuments { (quary, error) in
            if error != nil {
                Tools.createAlert(Title: "Error", Mess: "Your Internet is poor", ob: self)
            }
            else {
                for doc in quary!.documents {
                    self.coin = doc.get("FlixCount") as! Int
                    self.id = doc.documentID
                }
                
                // Make Aciton
                if self.coin >= (self.PickImageURL?.getImageCoast())! {
                    // Buy The Image
              Firestore.firestore().collection("Guest").document(self.id).updateData([
                        "FlixCount": Int(self.coin - (self.PickImageURL?.getImageCoast())!)
                    ]){
                        error in
                        if error == nil {
                            let alert = UIAlertController(title: "Sucess" , message:"You Buied Image Successfully"
                                , preferredStyle:UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title:"OK",style:UIAlertAction.Style.default,handler: {(action) in
                                self.download()
                            }))
                            self.present(alert,animated:true,completion: nil)
                        }
                    }
                }
                else {
                    // You Can't
                    SVProgressHUD.dismiss()
                    Tools.createAlert(Title: "Error", Mess: "You Must add \((self.PickImageURL?.getImageCoast())! - self.coin) or more flix to buy it", ob: self)
                }
            }
        }
        
    }
    
    // TODO: This Method For Download Image.
    func download() {
        // Create a reference to the file you want to download
        let StorageRef = Storage.storage().reference(forURL: URL1!)
        
        let starsRef = StorageRef.child(PickImageURL!.getImageURL())
        
        // Fetch the download URL
        starsRef.downloadURL { url22, error in
            if error != nil {
                print("Error \(error!)")
            } else {
                // Get the download URL for 'images/stars.jpg'
                print("URL: ")
                print(url22!)
                SVProgressHUD.dismiss()
                let safariVC = SFSafariViewController(url: url22!)
                self.present(safariVC, animated: true)
                
            }
        }
    }
    
    // TODO: This Method For Save Image In CoreData
    func SaveToBookMarks() {
        let ob = SavedImages(context: context)
        ob.coast = Int32(self.PickImageURL!.getImageCoast())
        ob.statue = false
        
        // This Sektion Of Code For Download Image And Save it in CoreData.
        
        let StorageRef = Storage.storage().reference(forURL: URL1!)
        
        let starsRef = StorageRef.child(PickImageURL!.getImageURL())
        SVProgressHUD.show()
        // Fetch the download URL
        starsRef.downloadURL { url22, error in
            if error != nil {
                print("Error \(error!)")
            } else {
                // Get the download URL for 'images/stars.jpg'
                
                Alamofire.request(url22!).responseData {
                    (response) in
                    if response.error != nil {
                        Tools.createAlert(Title: "Failed", Mess: "\(response.result)", ob: self)
                    }
                    
                    if let data = response.data {
                        ob.image = UIImage(data: data)
                        ad.saveContext()
                        SVProgressHUD.dismiss()
                        Tools.createAlert(Title: "Success", Mess: "Your Article is Saved Successfully", ob: self)
                    }
                }
            }
        }
        
    }
    
    
    // TODO: This Method For getting pick image.
    func DownloadImage() {
        Tools.downloadImage(FolderURL: URL1!, url: (PickImageURL?.getImageURL())!, Image: ImageCover)
    }
    
}
