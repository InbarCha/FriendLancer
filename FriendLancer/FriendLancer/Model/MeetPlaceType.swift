//
//  MeetPlaceType.swift
//  FriendLancer
//
//  Created by Studio on 12/01/2020.
//  Copyright © 2020 Nitzan & Inbar. All rights reserved.
//

import Foundation
import Firebase

class MeetPlaceType {
    var type:String = ""
    var typeId:String = ""
    //var lastUpdated:Int64 = 0
    
    init(type:String, typeId:String="") {
        self.type = type
        
        if(typeId == "") {
            let identifier = UUID()
            self.typeId = identifier.uuidString
        }
        else {
            self.typeId = typeId
        }
    }
    
    init(json:[String:Any]) {
        self.type = json["type"] as! String;
        self.typeId = json["typeId"] as! String;
        //let ts = json["lastUpdated"] as! Timestamp
        //self.lastUpdated = ts.seconds
    }
    
    func toJson() ->[String:Any] {
        var json = [String:Any]();
        json["type"] = self.type
        json["typeId"] = self.typeId
        //json["lastUpdated"] = FieldValue.serverTimestamp()
        return json;
    }
    
}
