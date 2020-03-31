//
//  ProfileViewController.swift
//  My Shoot
//
//  Created by Mohamed Ali on 3/26/20.
//  Copyright © 2020 Mohamed Ali. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import SVProgressHUD

protocol ProfileImage {
    func ChangeImage(Image:UIImage)
}

class ProfileViewController: UIViewController , UITextFieldDelegate , UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    // TODO: This Sektion For Intialize The Varible Here.
    @IBOutlet weak var TXTName: UITextField!
    @IBOutlet weak var TXTEmail: UITextField!
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var View1: UIView!
    @IBOutlet weak var V: NSLayoutConstraint!
    
    var GlobalImage:UIImage?
    var id = ""
    var ImagePath = ""
    
    var delegate:ProfileImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // This Sektion For Desgin On This Page
        // ------------------------------------------
        Tools.setLeftPadding(textfield: TXTName, Text: "Enter Your Updated Name", padding: 25.0)
        Tools.setLeftPadding(textfield: TXTEmail, Text: "Enter Your Updated Email", padding: 25.0)
        
        let theTap = UITapGestureRecognizer(target: self, action: #selector(ViewTapped))
        View1.addGestureRecognizer(theTap)
        Tools.MakeCircle(ProfileImage)
        ProfileImage.clipsToBounds = true
        // ------------------------------------------
        
        // This Sektion For BackEnd on This Page
        getDataProfile()
        
    }
    
    // TODO: This Action Method For Button Back.
    @IBAction func BTNBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // TODO: THis Action Method For Logout Button.
    @IBAction func BTNLogout(_ sender: Any) {
        
        let alert = UIAlertController(title: "Logout", message: "Are You Sure to logout?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Log out", style: .destructive, handler: {
            (alertAction) in
            do {
                try Auth.auth().signOut()
            } catch {
                print("Error")
                Tools.createAlert(Title: "Error", Mess: "there is error in sign out!", ob: self)
            }
            self.performSegue(withIdentifier: "Logout", sender: self)
        }))
        present(alert, animated: true, completion: nil)
        
    }
    
    // TODO: This Action Method For Pick Image From USER.
    // --------------------------------------------------
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
    // ---------------------------------------
    
    
    // TODO: This Action Method For Send Update To Database.
    @IBAction func BTNUpdateProfile(_ sender: Any) {
        UpdateData()
    }
    
    // TODO: This Mathod For Update Profile.
    func UpdateData() {
        SVProgressHUD.show()
        
        if GlobalImage == nil {
            Firestore.firestore().collection("Guest").document(id).updateData([
                "Name":self.TXTName.text!,
                "ImagePath":self.ImagePath
            ]){ err in
                if let err = err {
                    SVProgressHUD.dismiss()
                    print("Error updating document: \(err)")
                } else {
                    SVProgressHUD.dismiss()
                    Tools.createAlert(Title: "Success", Mess: "Update Data Successfully", ob: self)
                }
            }
        }
        else {
            delegate?.ChangeImage(Image: GlobalImage!)
            let url = Tools.UploadImage(url: "gs://flix-coin-system.appspot.com/Guest Picture", GlobalImage: GlobalImage!, name: TXTEmail.text!)
            
            Firestore.firestore().collection("Guest").document(id).updateData([
                "Name":self.TXTName.text!,
                "ImagePath":url
            ]){ err in
                if let err = err {
                    SVProgressHUD.dismiss()
                    print("Error updating document: \(err)")
                } else {
                    SVProgressHUD.dismiss()
                    Tools.createAlert(Title: "Success", Mess: "Update Data Successfully", ob: self)
                }
            }
        }
    }
    
    // TODO: This Method For Getting Data.
    func getDataProfile() {
        SVProgressHUD.show()
        let Email = Auth.auth().currentUser?.email
        
        SVProgressHUD.show()
        Firestore.firestore().collection("Guest").whereField("Email", isEqualTo: Email!).getDocuments { (quary, error) in
            for doc in quary!.documents {
                self.id = doc.documentID
                self.TXTName.text = doc.get("Name") as? String
                self.TXTEmail.text = doc.get("Email") as? String
                self.ImagePath = doc.get("ImagePath") as! String
                Tools.downloadImage(FolderURL: "gs://flix-coin-system.appspot.com/Guest Picture", url: doc.get("ImagePath") as! String, Image: self.ProfileImage)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Logout" {
            let vc = segue.destination as! ViewController
            vc.Action = 11
        }
    }
    
    
    ///////////////////////////////////////////
    
    //MARK:- TextField Delegate Methods
    
    
    //TODO: Declare textFieldDidBeginEditing here:
    
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @objc func ViewTapped(recognizer: UIGestureRecognizer) {
        View1.endEditing(true)
    }
}
