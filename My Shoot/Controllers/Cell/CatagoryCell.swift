//
//  CatagoryCell.swift
//  My Shoot
//
//  Created by Mohamed Ali on 3/24/20.
//  Copyright © 2020 Mohamed Ali. All rights reserved.
//

import UIKit

class CatagoryCell: UITableViewCell {

    @IBOutlet weak var LBLCatagoryTitle: UILabel!
    @IBOutlet weak var Cell: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.LBLCatagoryTitle.layer.cornerRadius = 9.0
        self.LBLCatagoryTitle.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 2, bottom: -10, right: 2))

    }
}
