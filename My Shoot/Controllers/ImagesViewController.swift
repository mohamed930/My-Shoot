//
//  ImagesViewController.swift
//  My Shoot
//
//  Created by Mohamed Ali on 3/24/20.
//  Copyright © 2020 Mohamed Ali. All rights reserved.
//

import UIKit

class ImagesViewController: UIViewController , UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
    // TODO: This Sektion For Intialize The Varible.
    @IBOutlet weak var collectionView: UICollectionView!
    
    let arr = ["c2","c2","c2","c2","c2","c2","c2","c2","c2","c2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
    }
    
    // TODO: This Action For Button Back.
    @IBAction func BTNback(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // TODO: These Method For CollectionView.
    // --------------------------------------
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : ImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageCell
        
        cell.Image.image = UIImage(named: arr[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath:
        IndexPath) -> CGSize {
        
        let w1 = self.collectionView.frame.width - (12 * 2)
        let cell_width = (w1 - (12 * 2)) / 3
        
        return CGSize(width: cell_width, height: 200.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "SavedImage", sender: self)
    }
    
    // --------------------------------------
    
}
