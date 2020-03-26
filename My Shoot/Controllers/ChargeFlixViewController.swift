//
//  ChargeFlixViewController.swift
//  My Shoot
//
//  Created by Mohamed Ali on 3/26/20.
//  Copyright © 2020 Mohamed Ali. All rights reserved.
//

import UIKit

class ChargeFlixViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // TODO: This Sektion For Intialize Varibles here.
    @IBOutlet weak var collectionView: UICollectionView!
    
    var Images = ["c","c2","c3"]
    var Names = ["50 Flix","150 Flix","300 Flix"]
    var pay = ["Watch Video","Pay In Fawry","Pay In Fawry"]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.register(UINib(nibName: "ChargeCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
    }
    
    // TODO: This Action Method For Back Button.
    @IBAction func BTNBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // TODO: These Methods For CollectionView.
    // ---------------------------------------
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : ChargeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ChargeCell
        cell.CoverFlix.image = UIImage(named: Images[indexPath.row])
        cell.NumberFlix.text = Names[indexPath.row]
        cell.ActionForCharge.text = pay[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath:
        IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    // ---------------------------------------
    
}
