//
//  HomeViewController.swift
//  My Shoot
//
//  Created by Mohamed Ali on 3/24/20.
//  Copyright © 2020 Mohamed Ali. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    // TODO: This Sektion For Intialize Varible Here.
    @IBOutlet weak var AddProbertiy: UIButton!
    @IBOutlet weak var tableview: UITableView!
    var Arr = ["Animals","Natural","Anime"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ChngeButton()
        //changeButton1()
        
        // Ididntifier The Cell From Xib file.
        tableview.register(UINib(nibName: "CatagoryCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        
    }
    
    // TODO: Make Action For Method Add Catagory
    @IBAction func BTNAdd(_ sender: Any) {
        
        var x = UITextField()
        
        let alert = UIAlertController(title:"Enter The Catagory Name: ", message: "", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(action1)
        
        let action2 = UIAlertAction(title: "Add", style: .default) { (AlertAction) in
            // Send It In FireBase.
            print(x.text!)
        }
        
        alert.addAction(action2)
        
        alert.addTextField { (TextField) in
            TextField.placeholder = "Enter The Catagory Name"
            x = TextField
        }
        
        present(alert, animated: true, completion: nil)
        
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
    

}
