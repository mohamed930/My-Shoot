//
//  Tools.swift
//  My Shoot
//
//  Created by Mohamed Ali on 3/24/20.
//  Copyright © 2020 Mohamed Ali. All rights reserved.
//

import UIKit

class Tools {
    
    public static func setLeftPadding (textfield:UITextField , Text:String, padding:Double) {
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: padding, height: 2.0))
        textfield.leftView = leftView
        textfield.leftViewMode = .always
        textfield.placeholder = Text
    }
    
    public static func MakeCircle (_ image:AnyObject) {
        image.layer.borderWidth = 1
        image.layer.masksToBounds = false
        image.layer.backgroundColor = UIColor.black.cgColor
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.cornerRadius = image.frame.height/2
    }
}
