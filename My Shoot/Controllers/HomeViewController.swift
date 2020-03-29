//
//  HomeViewController.swift
//  My Shoot
//
//  Created by Mohamed Ali on 3/24/20.
//  Copyright © 2020 Mohamed Ali. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import SVProgressHUD

class HomeViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    // TODO: This Sektion For Intialize Varible Here.
    @IBOutlet weak var AddProbertiy: UIButton!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var ProfileImage: UIImageView!
    
    var Arr = [""]
    
    var Email = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        // This Sektion For Changing Desgin Based on Email Login Admin or User
        // -------------------------------------------
        if Email.hasPrefix("admin") == true {
            // Admin Login
            ChngeButton()
        }
        else {
            // User Login
            changeButton1()
        }
        // Ididntifier The Cell From Xib file.
        tableview.register(UINib(nibName: "CatagoryCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        ProfileImage.layer.borderWidth = 1
        ProfileImage.layer.masksToBounds = false
        ProfileImage.layer.backgroundColor = UIColor.black.cgColor
        ProfileImage.layer.borderColor = UIColor.black.cgColor
        ProfileImage.layer.cornerRadius = 23.0
        ProfileImage.layer.masksToBounds = true
        // -------------------------------------------
        
        // This Sektion For BakcEnd Code Here
        // --------------------------------------
        getImage()
        getCollecitonName()
        // --------------------------------------
    }
    
    // TODO: Make Action For Method Add Catagory
    @IBAction func BTNAdd(_ sender: Any) {
        
        var x = UITextField()
        
        let alert = UIAlertController(title:"Enter The Catagory Name: ", message: "", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(action1)
        
        let action2 = UIAlertAction(title: "Add", style: .default) { (AlertAction) in
            // Send It In FireBase.
            SVProgressHUD.show()
            Firestore.firestore().collection("Parts").document(x.text!).setData(["Image":""])
            Tools.createAlert(Title: "Sucess", Mess: "Catagory is Created", ob: self)
            self.Arr.append(x.text!)
            self.tableview.reloadData()
            SVProgressHUD.dismiss()
        }
        
        alert.addAction(action2)
        
        alert.addTextField { (TextField) in
            TextField.placeholder = "Enter The Catagory Name"
            x = TextField
        }
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    // TODO: This Action Method For UpdateProfile For USER Or Add Image To App For ADMIN.
    @IBAction func BTNProfile(_ sender: Any) {
        
        if Email.hasPrefix("admin") == true {
            self.performSegue(withIdentifier: "AddPhoto", sender: self)
        }
        else {
            self.performSegue(withIdentifier: "UpdateProfile", sender: self)
        }
    }
    
    // TODO: This Action Method For Add Flix Coin.
    @IBAction func BTNAddFlix(_ sender: Any) {
        
        if Email.hasPrefix("admin") == true {
            self.performSegue(withIdentifier: "SendFlix", sender: self)
        }
        else {
            self.performSegue(withIdentifier: "ChargeFlix", sender: self)
        }
    }
    
    
    
    // TODO: These Method For TableView.
    // ---------------------------------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : CatagoryCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CatagoryCell
        
        cell.LBLCatagoryTitle.text = Arr[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "CollectionPhoto", sender: self)
    }
    // ---------------------------------------
    
    // TODO: Make Method For Getting Profile Image.
    func getImage()  {
    
        if Email.hasPrefix("admin") == true {
            
            SVProgressHUD.show()
            Firestore.firestore().collection("Admins").whereField("Email", isEqualTo: Email).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        
                        Tools.downloadImage(FolderURL: "gs://flix-coin-system.appspot.com/Users Picture", url: document.get("ImagePath") as! String, Image: self.ProfileImage)
                    }
                }
            }
            
        }
        else {
            
            SVProgressHUD.show()
            Firestore.firestore().collection("Guest").whereField("Email", isEqualTo: Email).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        
                        Tools.downloadImage(FolderURL: "gs://flix-coin-system.appspot.com/Guest Picture", url: document.get("ImagePath") as! String, Image: self.ProfileImage)
                    }
                }
            }
            
        }
    }
    
    // TODO: This Method Get All CollectionName.
    func getCollecitonName() {
        Arr.removeAll()
        Firestore.firestore().collection("Parts").getDocuments { (quary, error) in
            if error != nil {
                print("Error getting documents: \(error!)")
            } else {
                for document in quary!.documents {
                    self.Arr.append(document.documentID)
                    self.tableview.reloadData()
                }
            }
        }
    }
    
    
    // TODO: This Place Will Add Desgin Sektion On This Page
    
    // These Sektion For Desgin Code on This Page
    // ------------------------------------------
    func ChngeButton () {
        AddProbertiy.layer.borderWidth = 1
        AddProbertiy.layer.masksToBounds = false
        AddProbertiy.layer.backgroundColor = UIColor.green.cgColor
        AddProbertiy.layer.borderColor = UIColor.black.cgColor
        AddProbertiy.layer.cornerRadius = 22.0
        AddProbertiy.clipsToBounds = true
        AddProbertiy.setTitle("Add Catagory", for: .normal)
    }
    
    func changeButton1() {
        AddProbertiy.layer.backgroundColor = UIColor.clear.cgColor
        AddProbertiy.isEnabled = false
        AddProbertiy.setTitle("Catagories", for: .normal)
    }
    // ------------------------------------------
}
