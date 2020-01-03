//
//  Forum.swift
//  FriendLancer
//
//  Created by Studio on 03/01/2020.
//  Copyright © 2020 Nitzan & Inbar. All rights reserved.
//

import Foundation

class Forum {
    var id:String = ""
    var forumTopic:String = ""
    var forumTopicAvatar:String = ""
    
    init(id:String, forumTopic:String, forumTopicAvatar:String) {
        self.forumTopic = forumTopic;
        self.forumTopicAvatar = forumTopicAvatar;
        self.id = id;
    }
    
    init(json:[String:Any]){
        self.forumTopic = json["forumTopic"] as! String;
        self.forumTopicAvatar = json["forumTopicAvatar"] as! String;
        self.id = json["id"] as! String;
    }
    
    
    func toJson() -> [String:String] {
        var json = [String:String]();
        json["forumTopic"] = self.forumTopic
        json["forumTopicAvatar"] = self.forumTopicAvatar
        json["id"] = self.id
        return json;
    }
    
}
