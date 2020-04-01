//
//  request.swift
//  My Shoot
//
//  Created by Mohamed Ali on 4/1/20.
//  Copyright © 2020 Mohamed Ali. All rights reserved.
//

import Foundation

class Request {
    
    private var id : String?
    private var Email :String?
    private var indexNumber:Int?
    
    public func setid(id:String) {
        self.id = id
    }
    
    public func getid() -> String{
        return id!
    }
    
    public func getEmail() -> String{
        return Email!
    }
    
    public func setEmail(Email:String) {
        self.Email = Email
    }
    
    public func getindexNumber() -> Int {
        return indexNumber!
    }
    
    public func setindexNumer (indexNumer:Int) {
        self.indexNumber = indexNumer
    }
}
