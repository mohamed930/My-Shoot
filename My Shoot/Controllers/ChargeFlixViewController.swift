//
//  ChargeFlixViewController.swift
//  My Shoot
//
//  Created by Mohamed Ali on 3/26/20.
//  Copyright © 2020 Mohamed Ali. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import GoogleMobileAds
import SVProgressHUD

protocol AddFilx {
    func AddFlix(coin:Int)
}

class ChargeFlixViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout , GADRewardBasedVideoAdDelegate {
    
    // TODO: This Sektion For Intialize Varibles here.
    @IBOutlet weak var collectionView: UICollectionView!
    
    var Images = ["c","c2","c3"]
    var Names = ["50 Flix","150 Flix","300 Flix"]
    var pay = ["Watch Video","Pay 30$ In Fawry","Pay 50$ In Fawry"]
    
    var delegate:AddFilx?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.register(UINib(nibName: "ChargeCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        GADRewardBasedVideoAd.sharedInstance().load(GADRequest(), withAdUnitID:
            "ca-app-pub-3940256099942544/1712485313")
        GADRewardBasedVideoAd.sharedInstance().delegate = self
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if GADRewardBasedVideoAd.sharedInstance().isReady == true {
                GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController: self)
            }
            else {
                Tools.createAlert(Title: "Failed", Mess: "There is no video...", ob: self)
            }
        }
        else {
            Tools.createAlert(Title: "Attention", Mess: "This Number in Fawry 2253388 we must pay it to send your Flix", ob: self)
            
            let dic : [String:Any] = ["Email":(Auth.auth().currentUser?.email!)!,
                                      "RequestCoast": Int(indexPath.row)]
            SVProgressHUD.show()
            Firestore.firestore().collection("Requests").document().setData(dic){
                error in
                if error == nil {
                    SVProgressHUD.dismiss()
                }
                else {
                    SVProgressHUD.dismiss()
                    Tools.createAlert(Title: "Error", Mess: "Your Request Don't Enter System Because Internet Don't Stable", ob: self)
                }
            }
            
        }
    }
    
    // ---------------------------------------
    
    func rewardBasedVideoAdDidClose(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        // Use This Code When You Upload it on App Store
        // ca-app-pub-7749348761545617/7600614967
        GADRewardBasedVideoAd.sharedInstance().load(GADRequest(), withAdUnitID:
            "ca-app-pub-3940256099942544/1712485313")
    }
    
    var coin = 0
    var id = ""
    var current_Coin = 0
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd, didRewardUserWith reward: GADAdReward) {
        coin += 50
        delegate?.AddFlix(coin: coin)
        
        SVProgressHUD.show()
        let Email = Auth.auth().currentUser?.email
        
        Firestore.firestore().collection("Guest").whereField("Email", isEqualTo: Email!).getDocuments { (quary, error) in
            if error != nil {
                SVProgressHUD.dismiss()
                Tools.createAlert(Title: "Error", Mess: "Your Internet is Poor", ob: self)
            }
            else {
                for doc in quary!.documents {
                    self.id = doc.documentID
                    self.current_Coin = doc.get("FlixCount") as! Int
                }
            }
            
            Firestore.firestore().collection("Guest").document(self.id).updateData([
                "FlixCount" : Int(self.current_Coin + self.coin)
            ]){
                error in
                if error == nil {
                    SVProgressHUD.dismiss()
                    Tools.createAlert(Title: "Success", Mess: "Your Flix Added To Your Account Successfully!", ob: self)
                }
            }
        }
        
    }
}
