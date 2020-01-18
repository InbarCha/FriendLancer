//
//  Forum.swift
//  FriendLancer
//
//  Created by Studio on 03/01/2020.
//  Copyright © 2020 Nitzan & Inbar. All rights reserved.
//

import Foundation
import Firebase

class Forum {
    var forumTopic:String = ""
    var forumTopicAvatar:String = ""
    var lastUpdated:Int64 = 0
    
    init(forumTopic:String, forumTopicAvatar:String) {
        self.forumTopic = forumTopic;
        self.forumTopicAvatar = forumTopicAvatar;
    }
    
    init(json:[String:Any]){
        self.forumTopic = json["forumTopic"] as! String;
        self.forumTopicAvatar = json["forumTopicAvatar"] as! String;
        let ts = json["lastUpdated"] as! Timestamp
        self.lastUpdated = ts.seconds
    }
    
    
    func toJson() -> [String:Any] {
        var json = [String:Any]();
        json["forumTopic"] = self.forumTopic
        json["forumTopicAvatar"] = self.forumTopicAvatar
        json["lastUpdated"] = FieldValue.serverTimestamp()
        return json;
    }
    
}
