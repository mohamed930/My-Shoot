//
//  ViewController.swift
//  My Shoot
//
//  Created by Mohamed Ali on 3/24/20.
//  Copyright © 2020 Mohamed Ali. All rights reserved.
//

import UIKit
import FirebaseAuth
import SVProgressHUD
import CoreData

class ViewController: UIViewController, UITextFieldDelegate{
    
    // TODO: This Sektion For Declare Varible here.
    @IBOutlet weak var TXTEmail: UITextField!
    @IBOutlet weak var TXTPassword: UITextField!
    @IBOutlet weak var Scroll: UIScrollView!
    @IBOutlet weak var V: NSLayoutConstraint!
    
    var UsersArray = [User]()
    var result = 0
    var Action = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // This Action Will Make Desgin On This Page
        // ---------------------------------------------
        Tools.setLeftPadding(textfield: TXTEmail, Text: "Email", padding: 80.0)
        Tools.setLeftPadding(textfield: TXTPassword, Text: "Password", padding: 80.0)
        
        Scroll.keyboardDismissMode = .interactive
        //put this where you initialize your scroll view
        let theTap = UITapGestureRecognizer(target: self, action: #selector(scrollViewTapped))
        Scroll.addGestureRecognizer(theTap)
        // ---------------------------------------------
        
        getDataFormCoreData()
        print(UsersArray.count)
        
        if Action != 11 {
            if UsersArray.count != 0 {
                // Read Data From CoreData And Login
                TXTEmail.text = UsersArray[0].email
                
                // Login Automatics
                SVProgressHUD.show()
                Auth.auth().signIn(withEmail: TXTEmail.text!, password: UsersArray[0].password!) { (auth, error) in
                    if error != nil {
                        SVProgressHUD.dismiss()
                        Tools.createAlert(Title: "Error", Mess: "Your Internet is Poor", ob: self)
                    }
                    else {
                        SVProgressHUD.dismiss()
                        self.performSegue(withIdentifier: "Login", sender: self)
                    }
                }
            }
        }
    }
    
    // TODO: This Action Method For LoginButton.
    @IBAction func BTNLogin(_ sender: Any) {
        
        if TXTEmail.text == "" || TXTPassword.text == "" {
            Tools.createAlert(Title: "Error", Mess: "Please, Fill All Data To Login", ob: self)
        }
        else {
            if result == 0 {
                login()
            }
            else {
                login1()
            }
            
            
        }
    }
    
    // TODO: This Method For Fetch All Data.
    func getDataFormCoreData() {
        let fetchrequest:NSFetchRequest<User> = User.fetchRequest()
        do {
            UsersArray = try! context.fetch(fetchrequest)
        }
    }
    
    // TODO: This Method For Control Switch.
    @IBAction func Swich(_ sender: UISwitch) {
        if sender.isOn == true {
            result = 1
        }
        else {
            result = 0
        }
    }
    
    // TODO: This Method For Making Login.
    func login() {
        SVProgressHUD.show()
        Auth.auth().signIn(withEmail: TXTEmail.text!, password: TXTPassword.text!) { (auth, error) in
            if error != nil {
                SVProgressHUD.dismiss()
                Tools.createAlert(Title: "Error", Mess: "\(error!)" , ob: self)
                self.TXTPassword.text = ""
            }
            else {
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "Login", sender: self)
            }
        }
    }
    
    // TODO: This Method For Making Login.
    func login1() {
        SVProgressHUD.show()
        Auth.auth().signIn(withEmail: TXTEmail.text!, password: TXTPassword.text!) { (auth, error) in
            if error != nil {
                SVProgressHUD.dismiss()
                Tools.createAlert(Title: "Error", Mess: "\(error!)" , ob: self)
                self.TXTPassword.text = ""
            }
            else {
                SVProgressHUD.dismiss()
                
                if self.UsersArray.count == 0 {
                    // Save On CoreData Normally
                    let ob = User(context: context)
                    ob.email = self.TXTEmail.text!
                    ob.password = self.TXTPassword.text!
                    ob.statue = Int16(self.result)
                    ad.saveContext()
                    self.performSegue(withIdentifier: "Login", sender: self)
                }
                else if self.UsersArray.count == 1 {
                    // There is Element In The CoreData.
                    self.UsersArray[0].setValue(self.TXTEmail.text!, forKey: "email")
                    self.UsersArray[0].setValue(self.TXTPassword.text!, forKey: "password")
                    self.UsersArray[0].setValue(Int16(self.result), forKey: "statue")
                    ad.saveContext()
                    self.performSegue(withIdentifier: "Login", sender: self)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Login" {
            let vc = segue.destination as! HomeViewController
            vc.Email = TXTEmail.text!
        }
    }
    

    // These Method For Making Design On The ViewController.
    // ---------------------------------------------------------
    func setLeftPadding (textfield:UITextField , Text:String) {
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 80.0, height: 2.0))
        textfield.leftView = leftView
        textfield.leftViewMode = .always
        textfield.placeholder = Text
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //TODO: Declare textFieldDidBeginEditing here:
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.5) {
            self.V.constant = 250
            self.view.layoutIfNeeded()
        }
    }
    
    //TODO: Declare textFieldDidEndEditing here:
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.5) {
            self.V.constant = 112
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    //This can go anywhere in your class
    @objc func scrollViewTapped(recognizer: UIGestureRecognizer) {
        Scroll.endEditing(true)
    }
    // ---------------------------------------------------------
}

