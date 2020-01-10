//
//  Forum.swift
//  FriendLancer
//
//  Created by Studio on 03/01/2020.
//  Copyright © 2020 Nitzan & Inbar. All rights reserved.
//

import Foundation

class Forum {
    var forumTopic:String = ""
    var forumTopicAvatar:String = ""
    
    init(forumTopic:String, forumTopicAvatar:String) {
        self.forumTopic = forumTopic;
        self.forumTopicAvatar = forumTopicAvatar;
    }
    
    init(json:[String:Any]){
        self.forumTopic = json["forumTopic"] as! String;
        self.forumTopicAvatar = json["forumTopicAvatar"] as! String;
    }
    
    
    func toJson() -> [String:String] {
        var json = [String:String]();
        json["forumTopic"] = self.forumTopic
        json["forumTopicAvatar"] = self.forumTopicAvatar
        return json;
    }
    
}
