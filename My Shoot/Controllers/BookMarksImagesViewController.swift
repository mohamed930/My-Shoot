//
//  BookMarksImagesViewController.swift
//  My Shoot
//
//  Created by Mohamed Ali on 3/30/20.
//  Copyright © 2020 Mohamed Ali. All rights reserved.
//

import UIKit
import CoreData

class BookMarksImagesViewController: UIViewController , UICollectionViewDelegateFlowLayout , UICollectionViewDelegate , UICollectionViewDataSource{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var Arr = [SavedImages]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        getDataFormCoreData()
    }
    
    // TODO: This MEthod For Action For Button Back.
    @IBAction func BTNBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // TODO: These Method For CollectionView.
    // -------------------------------------------
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : ImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageCell
        
        cell.Image.image = (Arr[indexPath.row].image as! UIImage)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath:
        IndexPath) -> CGSize {
        
        let w1 = self.collectionView.frame.width - (12 * 2)
        let cell_width = (w1 - (12 * 2)) / 3
        
        return CGSize(width: cell_width, height: 200.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "Details", sender: Arr[indexPath.row])
    }
    
    // -------------------------------------------
    
    func getDataFormCoreData() {
        let fetchrequest:NSFetchRequest<SavedImages> = SavedImages.fetchRequest()
        do {
            Arr = try! context.fetch(fetchrequest)
            collectionView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Details" {
            if let f1 = sender as? SavedImages {
                let vc = segue.destination as! BookMarksDetailsViewController
                vc.ob = f1
            }
        }
    }
}
