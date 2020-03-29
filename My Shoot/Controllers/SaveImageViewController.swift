//
//  SaveImageViewController.swift
//  My Shoot
//
//  Created by Mohamed Ali on 3/24/20.
//  Copyright © 2020 Mohamed Ali. All rights reserved.
//

import UIKit
import SVProgressHUD

class SaveImageViewController: UIViewController {
    
    // TODO: This Sektion for Intialize The Varible Here
    @IBOutlet weak var ImageCover: UIImageView!
    var PickImageURL:ImageData?
    var URL:String?

    override func viewDidLoad() {
        super.viewDidLoad()

        DownloadImage()
    }
    
    // TODO: This Action Method For Button Back
    @IBAction func BTNBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func BTNSave(_ sender: Any) {
    }
    
    
    // TODO: This Method For getting pick image.
    func DownloadImage() {
        SVProgressHUD.show()
        Tools.downloadImage(FolderURL: URL!, url: (PickImageURL?.getImageURL())!, Image: ImageCover)
    }
    
}
