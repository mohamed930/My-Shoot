//
//  SignUpViewController.swift
//  My Shoot
//
//  Created by Mohamed Ali on 3/24/20.
//  Copyright © 2020 Mohamed Ali. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController , UITextFieldDelegate, UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    // TODO: This Sektion For Intialize The Varible Here.
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var TXTName: UITextField!
    @IBOutlet weak var TXTEmail: UITextField!
    @IBOutlet weak var TXTPassword: UITextField!
    @IBOutlet weak var TXTConfirmPasswrod: UITextField!
    @IBOutlet weak var V: NSLayoutConstraint!
    @IBOutlet weak var Scroll: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MakeCircle(ProfileImage)
        setPadding()
        
        Scroll.keyboardDismissMode = .interactive
        //put this where you initialize your scroll view
        let theTap = UITapGestureRecognizer(target: self, action: #selector(scrollViewTapped))
        Scroll.addGestureRecognizer(theTap)
        
    }
    
    @IBAction func BTNBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
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
        }
        else
        {
            
        }
        self.dismiss(animated: true, completion: nil)
    }
    

    
    
    func MakeCircle (_ image:AnyObject) {
        image.layer.borderWidth = 1
        image.layer.masksToBounds = false
        image.layer.backgroundColor = UIColor.black.cgColor
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.cornerRadius = image.frame.height/2
        ProfileImage.clipsToBounds = true
    }
    
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
