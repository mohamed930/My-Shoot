//
//  OptionCell.swift
//  My Shoot
//
//  Created by Mohamed Ali on 3/30/20.
//  Copyright © 2020 Mohamed Ali. All rights reserved.
//

import UIKit

class OptionCell: UICollectionViewCell {
    
    @IBOutlet weak var Container: UIView!
    @IBOutlet weak var Email: UIImageView!
    @IBOutlet weak var LBLText: UILabel!
    @IBOutlet weak var ImageHight: NSLayoutConstraint!
    @IBOutlet weak var LabelHight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        ImageHight.constant = CGFloat(Container.frame.height * 0.8)
        LabelHight.constant = CGFloat(Container.frame.height * 0.2)
    }

}
