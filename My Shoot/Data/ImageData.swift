//
//  ImageData.swift
//  My Shoot
//
//  Created by Mohamed Ali on 3/29/20.
//  Copyright © 2020 Mohamed Ali. All rights reserved.
//

import Foundation

class ImageData {
    private var ImageURL:String?
    private var ImageCoast:Int?
    
    public func getImageURL() -> String {
        return ImageURL!
    }
    
    public func getImageCoast() -> Int {
        return ImageCoast!
    }
    
    public func setImageURL(ImageURL:String) {
        self.ImageURL = ImageURL
    }
    
    public func setImageCoast(ImageCoast:Int) {
        self.ImageCoast = ImageCoast
    }
}
