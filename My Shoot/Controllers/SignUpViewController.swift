//
//  SignUpViewController.swift
//  My Shoot
//
//  Created by Mohamed Ali on 3/24/20.
//  Copyright © 2020 Mohamed Ali. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import SVProgressHUD

class SignUpViewController: UIViewController , UITextFieldDelegate, UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    // TODO: This Sektion For Intialize The Varible Here.
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var TXTName: UITextField!
    @IBOutlet weak var TXTEmail: UITextField!
    @IBOutlet weak var TXTPassword: UITextField!
    @IBOutlet weak var TXTConfirmPasswrod: UITextField!
    @IBOutlet weak var V: NSLayoutConstraint!
    @IBOutlet weak var Scroll: UIScrollView!
    
    var url = ""
    var GlobalImage:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // This Sektion For Make Design On The Page
        // -----------------------------------------
        Tools.MakeCircle(ProfileImage)
         ProfileImage.clipsToBounds = true
        setPadding()
        
        Scroll.keyboardDismissMode = .interactive
        //put this where you initialize your scroll view
        let theTap = UITapGestureRecognizer(target: self, action: #selector(scrollViewTapped))
        Scroll.addGestureRecognizer(theTap)
        // -----------------------------------------
        
    }
    
    // TODO: This Action Method For Button Back for Return.
    @IBAction func BTNBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // TODO: This Action Method For Send Data To Database.
    @IBAction func BTNSignUp(_ sender: Any) {
        
        if TXTName.text == "" || TXTEmail.text == "" || TXTPassword.text == "" || TXTConfirmPasswrod.text == "" || GlobalImage == nil {
            Tools.createAlert(Title: "Error", Mess: "Please Fill All Fields", ob: self)
        }
        else {
            if TXTPassword.text != TXTConfirmPasswrod.text {
                Tools.createAlert(Title: "Error", Mess: "Please, Check The Password And Confirmation is identical", ob: self)
                TXTPassword.text = ""
                TXTConfirmPasswrod.text = ""
            }
            else {
                if TXTEmail.text?.hasPrefix("admin") == true {
                    // Make Admin Action
                    checkAdmin()
                }
                else {
                    // Make User Action
                    MakeUserOrAdmin()
                }
            }
        }
    }
    
    // TODO: Write Method For Making Admin Account Under Condition
    func checkAdmin() {
        SVProgressHUD.show()
        Firestore.firestore().collection("Admins").getDocuments { (quary, error) in
            print(quary!.count)
            
            if quary!.count < 2 {
                Auth.auth().createUser(withEmail: self.TXTEmail.text!, password: self.TXTPassword.text!, completion: { (auth, error) in
                    if error != nil {
                        SVProgressHUD.dismiss()
                        Tools.createAlert(Title: "Error", Mess: "Your Internet Have a Problem", ob: self)
                    }
                    else {
                        
                         self.url = Tools.UploadImage(url: "gs://flix-coin-system.appspot.com/Users Picture", GlobalImage: self.GlobalImage!, name: self.TXTEmail.text!)
                        
                        let dic : [String:String] = ["Name":self.TXTName.text!,
                                   "Email":self.TXTEmail.text!,
                                   "ImagePath":self.url]
                        
                        Tools.addDataToFirebase(collectionName: "Admins", dic: dic, Mess: "Your Account is Created Successfully", ob: self)
                    }
                })
            }
            else {
                // You Can't Add Admin
                SVProgressHUD.dismiss()
                Tools.createAlert(Title: "Sorry", Mess: "You Can't Add Any Admin", ob: self)
            }
        }
    }
    
    // Make Method For User
    func MakeUserOrAdmin () {
        SVProgressHUD.show()
        Auth.auth().createUser(withEmail: self.TXTEmail.text!, password: self.TXTPassword.text!, completion: { (auth, error) in
            if error != nil {
                SVProgressHUD.dismiss()
                Tools.createAlert(Title: "Error", Mess: "Your Internet Have a Problem", ob: self)
            }
            else {
                
                self.url = Tools.UploadImage(url: "gs://flix-coin-system.appspot.com/Guest Picture", GlobalImage: self.GlobalImage!, name: self.TXTEmail.text!)
                
                let dic : [String:String] = ["Name":self.TXTName.text!,
                                             "Email":self.TXTEmail.text!,
                                             "ImagePath":self.url]
                
                Tools.addDataToFirebase(collectionName: "Guest", dic: dic, Mess: "Your Account is Created Successfully", ob: self)
            }
        })
    }
    
    // TODO: This Sektion In Code For PickImage From User And Put it in her profile.
    // ---------------------------------
    @IBAction func BTNPickImage(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        self.present(image,animated: false)
        {
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            ProfileImage.image = image
            GlobalImage = image
        }
        else
        {
            
        }
        self.dismiss(animated: true, completion: nil)
    }
    // ----------------------------------
    
    
    // TODO: This Method For Add Padding For Fields
    func setPadding() {
        Tools.setLeftPadding(textfield: TXTName, Text: "Enter Your Name Here", padding: 25.0)
        Tools.setLeftPadding(textfield: TXTEmail, Text: "Enter Your Email Here", padding: 25.0)
        Tools.setLeftPadding(textfield: TXTPassword, Text: "Enter Your Password Here", padding: 25.0)
        Tools.setLeftPadding(textfield: TXTConfirmPasswrod, Text: "Repeate Your Password Here", padding: 25.0)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    ///////////////////////////////////////////
    
    //MARK:- TextField Delegate Methods
    
    
    //TODO: Declare textFieldDidBeginEditing here:
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.5) {
            self.V.constant = 308
            self.view.layoutIfNeeded()
        }
    }
    
    //TODO: Declare textFieldDidEndEditing here:
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.5) {
            self.V.constant = 50
            self.view.layoutIfNeeded()
        }
    }
    
    // TODO: Declare Return Button Action Here
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    ///////////////////////////////////////////
    
    //This can go anywhere in your class
    @objc func scrollViewTapped(recognizer: UIGestureRecognizer) {
        Scroll.endEditing(true)
    }
}
