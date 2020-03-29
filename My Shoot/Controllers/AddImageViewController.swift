//
//  AddImageViewController.swift
//  My Shoot
//
//  Created by Mohamed Ali on 3/26/20.
//  Copyright © 2020 Mohamed Ali. All rights reserved.
//

import UIKit
import FirebaseFirestore
import SVProgressHUD
import FirebaseStorage
import FirebaseAuth

class AddImageViewController: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource , UIImagePickerControllerDelegate , UINavigationControllerDelegate , UITextFieldDelegate {
    
    // TODO: This Sektion Here For Intialize Varibles.
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var TXTFlixCoast: UITextField!
    @IBOutlet weak var PickerView: UIPickerView!
    var arr = [""]
    var catagoryName = ""
    var GlobalImage:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // This Sektion For Desgin On The Page
        // ------------------------------------
        Tools.setLeftPadding(textfield: TXTFlixCoast, Text: "Flix Coast", padding: 25.0)
        // ------------------------------------
        
        // This Sektion For Backend On The Page
        // ------------------------------------
        getCatagoryName()
        // ------------------------------------
    }
    
    // TODO: This Action Method For Button Back.
    @IBAction func BTNBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // This Sektion For Pick Image From User and Print It In Container
    // ---------------------------------------------------------------
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
            Image.image = image
            GlobalImage = image
        }
        else
        {
            
        }
        self.dismiss(animated: true, completion: nil)
    }
    // ---------------------------------------
    
    // TODO: Make Action Method For Add Image
    @IBAction func BTNAddImage(_ sender: Any) {
        
        if GlobalImage == nil || TXTFlixCoast.text == "" || catagoryName == "" {
            Tools.createAlert(Title: "Error", Mess: "Please, Fill All Fields", ob: self)
        }
        else {
            // Send Image To Firebase.
            addImage()
        }
        
    }
    
    // TODO: This Method For Add Image To Database.
    func addImage () {
        
        let dateFormate = DateFormatter()
        dateFormate.dateFormat = "DD_MM_yy_h_mm_a"
        let imagename = dateFormate.string(from: NSDate() as Date)
        let n = "\((Auth.auth().currentUser?.email)!)\(imagename)"
        
        let res = Tools.UploadImage(url: "gs://flix-coin-system.appspot.com/\(catagoryName)" , GlobalImage: GlobalImage!, name: n)
        
        let dic : [String:Any] = [
                                   "FlixCoin":Int(TXTFlixCoast.text!)!,
                                   "ImageURL":res
                                 ]
        
        Tools.addDataToFirebase(collectionName: catagoryName, dic: dic, Mess: "Image Added Successfully", ob: self)
    }
    
    // TODO: This Method Get All Catagory Name And Put it in pickerView.
    func getCatagoryName() {
        arr.removeAll()
        SVProgressHUD.show()
        Firestore.firestore().collection("Parts").getDocuments { (quary, error) in
            if error != nil {
                Tools.createAlert(Title: "Error", Mess: "\(error!)", ob: self)
            }
            else {
                for doc in quary!.documents {
                    self.arr.append(doc.documentID)
                    self.PickerView.reloadAllComponents()
                }
            }
            SVProgressHUD.dismiss()
        }
    }
    
    // TODO: These Methodes For PickerView.
    // -----------------------------------------
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arr[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        catagoryName = arr[row]
        print(catagoryName)
    }
    
    // -----------------------------------------
    
    // This Sektion For Design On This Page
    // ---------------------------------------
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    // ---------------------------------------
}
