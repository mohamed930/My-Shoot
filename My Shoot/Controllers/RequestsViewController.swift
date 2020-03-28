//
//  RequestsViewController.swift
//  My Shoot
//
//  Created by Mohamed Ali on 3/27/20.
//  Copyright © 2020 Mohamed Ali. All rights reserved.
//

import UIKit

class RequestsViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    // TODO: This Sektion For Intialize The Varible Here.
    @IBOutlet weak var tableView: UITableView!
    var N = ["M","Z","g"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "CatagoryCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }
    
    @IBAction func BTNBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return N.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : CatagoryCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CatagoryCell
        cell.LBLCatagoryTitle.text = N[indexPath.row]
        cell.Cell.backgroundColor = UIColor().hexStringToUIColor(hex: "3CEDFF")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "Confirm", sender: self)
    }
    
}
