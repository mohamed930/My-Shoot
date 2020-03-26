//
//  ProfileViewController.swift
//  My Shoot
//
//  Created by Mohamed Ali on 3/26/20.
//  Copyright © 2020 Mohamed Ali. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController , UITextFieldDelegate , UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    // TODO: This Sektion For Intialize The Varible Here.
    @IBOutlet weak var TXTName: UITextField!
    @IBOutlet weak var TXTEmail: UITextField!
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var V: NSLayoutConstraint!
    @IBOutlet weak var View1: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        Tools.setLeftPadding(textfield: TXTName, Text: "Enter Your Updated Name", padding: 25.0)
        Tools.setLeftPadding(textfield: TXTEmail, Text: "Enter Your Updated Email", padding: 25.0)
        
        let theTap = UITapGestureRecognizer(target: self, action: #selector(ViewTapped))
        View1.addGestureRecognizer(theTap)
        Tools.MakeCircle(ProfileImage)
        ProfileImage.clipsToBounds = true
    }
    
    // TODO: This Action Method For Button Back.
    @IBAction func BTNBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // TODO: This Action Method For Pick Image From USER.
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
    // ---------------------------------------
    
    // TODO: This Action Method For Send Update To Database.
    @IBAction func BTNUpdateProfile(_ sender: Any) {
    }
    
    
    ///////////////////////////////////////////
    
    //MARK:- TextField Delegate Methods
    
    
    //TODO: Declare textFieldDidBeginEditing here:
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.5) {
            self.V.constant = 505
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @objc func ViewTapped(recognizer: UIGestureRecognizer) {
        View1.endEditing(true)
    }
    
    
}
