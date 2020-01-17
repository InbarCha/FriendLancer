//
//  User.swift
//  FriendLancer
//
//  Created by yaniv hachmon on 15/01/2020.
//  Copyright © 2020 Nitzan & Inbar. All rights reserved.
//

import Foundation

class User {
    var email:String = ""
    var name:String = ""
    var profession:String = ""
    var image:String = ""
    
    init(email:String, name:String, profession:String, image:String = "") {
        self.email = email
        self.name = name
        self.profession = profession
        self.image = image
    }
    
    init(json:[String:Any]){
        self.email = json["email"] as! String;
        self.name = json["name"] as! String;
        self.profession = json["profession"] as! String;
        self.image = json["image"] as! String;
    }
    
    
    func toJson() -> [String:String] {
        var json = [String:String]();
        json["email"] = self.email
        json["name"] = self.name
        json["profession"] = self.profession
        json["image"] = self.image
        return json;
    }
    
}
