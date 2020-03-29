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

class ViewController: UIViewController, UITextFieldDelegate{
    
    // TODO: This Sektion For Declare Varible here.
    @IBOutlet weak var TXTEmail: UITextField!
    @IBOutlet weak var TXTPassword: UITextField!
    @IBOutlet weak var Scroll: UIScrollView!
    
    
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
        
    }
    
    // TODO: This Action Method For LoginButton.
    @IBAction func BTNLogin(_ sender: Any) {
        
        if TXTEmail.text == "" || TXTPassword.text == "" {
            Tools.createAlert(Title: "Error", Mess: "Please, Fill All Data To Login", ob: self)
        }
        else {
            login()
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

