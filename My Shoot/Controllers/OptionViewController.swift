//
//  OptionViewController.swift
//  My Shoot
//
//  Created by Mohamed Ali on 3/30/20.
//  Copyright © 2020 Mohamed Ali. All rights reserved.
//

import UIKit

protocol ImageProfile1 {
    func getImage(Image:UIImage)
}

class OptionViewController: UIViewController , ProfileImage , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
  
    @IBOutlet weak var collectionView: UICollectionView!
    
    var d : ImageProfile1?
    
    var Images = ["10211761","logo-icon","EmailIcon","unnamed"]
    var Names = ["Your Profile","Your Images","FeedBack","Info"]
    var ColourCode = ["#22fce6","#fff700","#00ff3c","#ff0000"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UINib(nibName: "OptionCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
    }
    
    @IBAction func BTNBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UpdateProfile1" {
            let vc = segue.destination as! ProfileViewController
            vc.delegate = self
        }
    }
    
    func ChangeImage(Image: UIImage) {
        d?.getImage(Image: Image)
    }
    
    // TODO: These Methods For Collection View Int This Page
    // ------------------------------------------------------
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : OptionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! OptionCell
        cell.Email.image = UIImage(named: Images[indexPath.row])
        cell.LBLText.text = Names[indexPath.row]
        cell.Container.backgroundColor = UIColor().hexStringToUIColor(hex: ColourCode[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath:
        IndexPath) -> CGSize {
        
        let w1 = self.collectionView.frame.width - (19 * 2)
        let cell_width = (w1 - 19) / 2
        
        return CGSize(width: cell_width, height: 250.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.performSegue(withIdentifier: "UpdateProfile1", sender: self)
        }
        else if indexPath.row == 3 {
            Tools.createAlert(Title: "Info", Mess: "This App Gives User 4K Images he wanna to downloaded it Developed by Eng/ Mohamed Ali Ebrahim", ob: self)
        }
    }
    // ------------------------------------------------------

}
