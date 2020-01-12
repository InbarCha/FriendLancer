//
//  MeetPlace.swift
//  FriendLancer
//
//  Created by Studio on 12/01/2020.
//  Copyright © 2020 Nitzan & Inbar. All rights reserved.
//

import Foundation

class MeetPlace {
    var name:String = ""
    var city:String = ""
    var address:String = ""
    var image:String = ""
    var meetPlaceId: String = ""
    var meetPlaceTypeId:String = ""
    
    
    init(name:String, meetPlaceTypeId:String, address:String, city:String, image:String) {
        self.name = name
        self.meetPlaceTypeId = meetPlaceTypeId
        self.address = address
        self.city = city
        self.image = image
        
        let identifier = UUID()
        self.meetPlaceId = identifier.uuidString
    }
    
    init(json:[String:Any]) {
        self.name = json["name"] as! String;
        self.address = json["address"] as! String;
        self.city = json["city"] as! String;
        self.image = json["image"] as! String;
        self.meetPlaceId = json["meetPlaceId"] as! String;
        self.meetPlaceTypeId = json["meetPlaceTypeId"] as! String;
    }
    
    func toJson() ->[String:String] {
        var json = [String:String]();
        json["name"] = self.name
        json["address"] = self.address
        json["city"] = self.city
        json["image"] = self.image
        json["meetPlaceId"] = self.meetPlaceId
        json["meetPlaceTypeId"] = self.meetPlaceTypeId
        return json;
    }
}
