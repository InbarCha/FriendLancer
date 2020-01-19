//
//  MeetPlace.swift
//  FriendLancer
//
//  Created by Studio on 12/01/2020.
//  Copyright © 2020 Nitzan & Inbar. All rights reserved.
//

import Foundation
import Firebase

class MeetPlace {
    var meetPlaceId: String = ""
    var meetPlaceTypeId:String = ""
    var name:String = ""
    var city:String = ""
    var address:String = ""
    var image:String = ""
    var lastUpdated:Int64 = 0
    
    init(name:String, meetPlaceTypeId:String, address:String, city:String, image:String, meetPlaceId:String = "") {
        self.name = name
        self.meetPlaceTypeId = meetPlaceTypeId
        self.address = address
        self.city = city
        self.image = image
        
        if (meetPlaceId == "") {
            let identifier = UUID()
            self.meetPlaceId = identifier.uuidString
        }
        else {
            self.meetPlaceId = meetPlaceId
        }
    }
    
    init(json:[String:Any]) {
        self.name = json["name"] as! String;
        self.address = json["address"] as! String;
        self.city = json["city"] as! String;
        self.image = json["image"] as! String;
        self.meetPlaceId = json["meetPlaceId"] as! String;
        self.meetPlaceTypeId = json["meetPlaceTypeId"] as! String;
        let ts = json["lastUpdated"] as! Timestamp
        self.lastUpdated = ts.seconds
    }
    
    func toJson() ->[String:Any] {
        var json = [String:Any]();
        json["name"] = self.name
        json["address"] = self.address
        json["city"] = self.city
        json["image"] = self.image
        json["meetPlaceId"] = self.meetPlaceId
        json["meetPlaceTypeId"] = self.meetPlaceTypeId
        json["lastUpdated"] = FieldValue.serverTimestamp()
        return json;
    }
}
