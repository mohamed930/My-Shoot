//
//  ConfirmChargeViewController.swift
//  My Shoot
//
//  Created by Mohamed Ali on 3/28/20.
//  Copyright © 2020 Mohamed Ali. All rights reserved.
//

import UIKit

class ConfirmChargeViewController: UIViewController {

    // TODO: This Sektion For Intialize The Varible Here.
    @IBOutlet weak var ImageCover: UIImageView!
    @IBOutlet weak var TXTFlixAmount: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DesignForTextField()
    }
    
    // TODO: This Action Method For Button Back.
    @IBAction func BTNBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // TODO: This Action Method For Add Flix Coin To The User.
    @IBAction func BTNChargeFlix(_ sender: Any) {
    }
    
    // TODO: Make A Desgin For TextField
    func DesignForTextField() {
        TXTFlixAmount.backgroundColor = .white
        TXTFlixAmount.layer.cornerRadius = 28.0
        TXTFlixAmount.layer.masksToBounds = true
        TXTFlixAmount.layer.borderColor = UIColor.black.cgColor
        TXTFlixAmount.layer.borderWidth = 1.0
        TXTFlixAmount.placeholder = "Flix Amount Charge"
    }
    
    
}
