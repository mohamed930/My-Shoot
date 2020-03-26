//
//  AddImageViewController.swift
//  My Shoot
//
//  Created by Mohamed Ali on 3/26/20.
//  Copyright © 2020 Mohamed Ali. All rights reserved.
//

import UIKit

class AddImageViewController: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource , UIImagePickerControllerDelegate , UINavigationControllerDelegate , UITextFieldDelegate {
    
    // TODO: This Sektion Here For Intialize Varibles.
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var TXTFlixCoast: UITextField!
    var arr = ["Apple","Orange","Bananna"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        Tools.setLeftPadding(textfield: TXTFlixCoast, Text: "Flix Coast", padding: 25.0)
    }
    
    // TODO: This Action Method For Button Back.
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
            Image.image = image
        }
        else
        {
            
        }
        self.dismiss(animated: true, completion: nil)
    }
    // ---------------------------------------
    
    @IBAction func BTNAddImage(_ sender: Any) {
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
    // -----------------------------------------
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    
}
