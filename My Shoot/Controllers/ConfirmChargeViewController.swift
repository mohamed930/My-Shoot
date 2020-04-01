//
//  ConfirmChargeViewController.swift
//  My Shoot
//
//  Created by Mohamed Ali on 3/28/20.
//  Copyright © 2020 Mohamed Ali. All rights reserved.
//

import UIKit
import FirebaseFirestore
import SVProgressHUD

class ConfirmChargeViewController: UIViewController {

    // TODO: This Sektion For Intialize The Varible Here.
    @IBOutlet weak var ImageCover: UIImageView!
    @IBOutlet weak var TXTFlixAmount: UITextField!
    
    var Email:Request?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DesignForTextField()
        
        loadPage()
    }
    
    // TODO: This Action Method For Button Back.
    @IBAction func BTNBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // TODO: This Action Method For Add Flix Coin To The User.
    @IBAction func BTNChargeFlix(_ sender: Any) {
        sendFlixToUser()
    }
    
    var id = ""
    var flix = 0
    var dic : [String:Int]?
    
    // TODO: This Mehtod for Send Flix To User.
    func sendFlixToUser() {
        SVProgressHUD.show()
        Firestore.firestore().collection("Guest").whereField("Email", isEqualTo: Email!.getEmail()).getDocuments { (q, error) in
            if error != nil {
                SVProgressHUD.dismiss()
                Tools.createAlert(Title: "Erorr", Mess: "Internet is Poor", ob: self)
            }
            else {
                for doc in q!.documents {
                    self.id = doc.documentID
                    self.flix = doc.get("FlixCount") as! Int
                }
                SVProgressHUD.dismiss()
                
                if self.Email?.getindexNumber() == 1 {
                    self.dic = ["FlixCount":Int(self.flix + 150)]
                }
                else {
                    self.dic = ["FlixCount":Int(self.flix + 300)]
                }
                
                Firestore.firestore().collection("Guest").document(self.id).updateData(self.dic!){
                    error in
                    if error == nil {
                        Firestore.firestore().collection("Requests").document(self.Email!.getid()).delete()
                    }
                }
            }
        }
    }
    
    // TODO: Make A Desgin For TextField
    func DesignForTextField() {
        TXTFlixAmount.backgroundColor = .white
        TXTFlixAmount.layer.cornerRadius = 28.0
        TXTFlixAmount.layer.masksToBounds = true
        TXTFlixAmount.layer.borderColor = UIColor.black.cgColor
        TXTFlixAmount.layer.borderWidth = 1.0
        TXTFlixAmount.placeholder = "Flix Amount Charge"
    }
    
    func loadPage() {
        if Email?.getindexNumber() == 1 {
            ImageCover.image = UIImage(named: "c2")
            TXTFlixAmount.text = "150 Flix"
        }
        else if Email?.getindexNumber() == 2 {
            ImageCover.image = UIImage(named: "c3")
            TXTFlixAmount.text = "300 Flix"
        }
        
        
    }
    
}
