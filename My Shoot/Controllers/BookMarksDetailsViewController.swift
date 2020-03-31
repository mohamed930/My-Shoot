//
//  BookMarksDetailsViewController.swift
//  My Shoot
//
//  Created by Mohamed Ali on 3/30/20.
//  Copyright © 2020 Mohamed Ali. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import SVProgressHUD

class BookMarksDetailsViewController: UIViewController {
    
    var ob : SavedImages?
    
    @IBOutlet weak var CoverImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        getData()
    }
    
    @IBAction func BTNBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var id:String?
    var coin = 0
    
    @IBAction func BTNDownload(_ sender: Any) {
        if ob!.statue == false {
            buyImageAndDownloadIt()
        }
        else {
            let alert = UIAlertController(title: "Attention", message: "You Buied Image Before you wanna to download it again?", preferredStyle: .alert)
            
            let action1 = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(action1)
            
            let action2 = UIAlertAction(title: "OK", style: .default) { (alert) in
                self.takescreenShoot()
            }
            alert.addAction(action2)
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    func buyImageAndDownloadIt() {
        
        SVProgressHUD.show()
        
        let Email = Auth.auth().currentUser?.email
        print(Email!)
        print("The Coast = \(Int(ob!.coast))")
        
        Firestore.firestore().collection("Guest").whereField("Email", isEqualTo: Email!).getDocuments { (quary, err) in
            if err != nil {
                SVProgressHUD.dismiss()
                Tools.createAlert(Title: "Error", Mess: "\(err!)", ob: self)
            }
            else {
                for doc in quary!.documents {
                    self.id = doc.documentID
                    self.coin = doc.get("FlixCount") as! Int
                }
                
                print(self.id!)
                
                if self.coin >= Int(self.ob!.coast) {
                    
                    let res = Int(self.coin - Int(self.ob!.coast))
                    print(" The Result = \(res)")
                    Firestore.firestore().collection("Guest").document(self.id!).updateData([
                        "FlixCount": res
                    ]){
                        err in
                        if err == nil {
                            SVProgressHUD.dismiss()
                            self.takescreenShoot()
                            Tools.createAlert(Title: "Success", Mess: "Image is Buied and Saved on your Phone", ob: self)
                            self.ob!.statue = true
                        }
                        else {
                            SVProgressHUD.dismiss()
                            Tools.createAlert(Title: "Error", Mess: "\(err!.localizedDescription)", ob: self)
                        }
                    }
                }
                else {
                    Tools.createAlert(Title: "Error", Mess: "Your Flix must have more \(Int(self.ob!.coast) - self.coin)", ob: self)
                    SVProgressHUD.dismiss()
                }
            }
        }
    }
    
    func getData() {
        CoverImage.image = (ob?.image as! UIImage)
    }
    
    // This Method For Take ScreanShoot And Save On Photo Gallery.
    public func takescreenShoot () {
        UIGraphicsBeginImageContextWithOptions(CoverImage.bounds.size, false, UIScreen.main.scale)
        CoverImage.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
    }
}
