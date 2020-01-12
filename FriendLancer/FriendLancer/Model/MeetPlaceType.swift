//
//  MeetPlaceType.swift
//  FriendLancer
//
//  Created by Studio on 12/01/2020.
//  Copyright © 2020 Nitzan & Inbar. All rights reserved.
//

import Foundation

class MeetPlaceType {
    var type:String = ""
    var typeId:String = ""
    
    init(type:String) {
        self.type = type
        
        let identifier = UUID()
        self.typeId = identifier.uuidString
    }
    
    init(json:[String:Any]) {
        self.type = json["type"] as! String;
        self.typeId = json["typeId"] as! String;

    }
    
    func toJson() ->[String:String] {
        var json = [String:String]();
        json["type"] = self.type
        json["typeId"] = self.typeId
        return json;
    }
    
}
