//
//  RequestsViewController.swift
//  My Shoot
//
//  Created by Mohamed Ali on 3/27/20.
//  Copyright © 2020 Mohamed Ali. All rights reserved.
//

import UIKit
import SVProgressHUD
import FirebaseFirestore

class RequestsViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    // TODO: This Sektion For Intialize The Varible Here.
    @IBOutlet weak var tableView: UITableView!
    var N = [Request]()
    var pickEmail = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "CatagoryCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        getData()
    }
    
    @IBAction func BTNBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return N.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : CatagoryCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CatagoryCell
        cell.LBLCatagoryTitle.text = N[indexPath.row].getEmail()
        cell.Cell.backgroundColor = UIColor().hexStringToUIColor(hex: "3CEDFF")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "Confirm", sender: N[indexPath.row])
    }
    
    func getData() {
        
        N.removeAll()
        
        SVProgressHUD.show()
        Firestore.firestore().collection("Requests").getDocuments { (quary, error) in
            if error != nil {
                SVProgressHUD.dismiss()
                Tools.createAlert(Title: "Error", Mess: "Your Internet Is Poor", ob: self)
            }
            else {
                for doc in quary!.documents {
                    let ob = Request()
                    ob.setid(id: doc.documentID)
                    ob.setEmail(Email: doc.get("Email") as! String)
                    ob.setindexNumer(indexNumer: doc.get("RequestCoast") as! Int)
                    self.N.append(ob)
                    self.tableView.reloadData()
                }
                SVProgressHUD.dismiss()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Confirm" {
            if let f1 = sender as? Request {
                let vc = segue.destination as! ConfirmChargeViewController
                vc.Email = f1
            }
        }
    }
    
}
