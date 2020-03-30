//
//  ImagesViewController.swift
//  My Shoot
//
//  Created by Mohamed Ali on 3/24/20.
//  Copyright © 2020 Mohamed Ali. All rights reserved.
//

import UIKit
import FirebaseFirestore
import SVProgressHUD

class ImagesViewController: UIViewController , UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
    // TODO: This Sektion For Intialize The Varible.
    @IBOutlet weak var collectionView: UICollectionView!
    var Name = ""
    var PickImageURL = ""
    
    
    var arr = Array<ImageData>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        getDataFromDataBase()
    }
    
    // TODO: This Action For Button Back.
    @IBAction func BTNback(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // TODO: This Method For Getting Images For Firestore.
    func getDataFromDataBase() {
        
        arr.removeAll()
        
        SVProgressHUD.show()
        Firestore.firestore().collection(Name).getDocuments { (quary, error) in
            if error != nil {
                Tools.createAlert(Title: "Error", Mess: "Your Internet is Poor", ob: self)
            }
            else {
                for doc in quary!.documents {
                    let ob = ImageData()
                    ob.setImageURL(ImageURL: doc.get("ImageURL") as! String)
                    ob.setImageCoast(ImageCoast: doc.get("FlixCoin") as! Int)
                    self.arr.append(ob)
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    
    // TODO: These Method For CollectionView.
    // --------------------------------------
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : ImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageCell
        
        Tools.downloadImage(FolderURL: "gs://flix-coin-system.appspot.com/\(Name)", url: arr[indexPath.row].getImageURL(), Image: cell.Image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath:
        IndexPath) -> CGSize {
        
        let w1 = self.collectionView.frame.width - (12 * 2)
        let cell_width = (w1 - (12 * 2)) / 3
        
        return CGSize(width: cell_width, height: 200.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "SavedImage", sender: arr[indexPath.row])
    }
    // --------------------------------------
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SavedImage" {
            if let f1 = sender as? ImageData {
                let vc = segue.destination as! SaveImageViewController
                vc.PickImageURL = f1
                vc.URL1 = "gs://flix-coin-system.appspot.com/\(Name)"
            }
        }
    }
    
}
