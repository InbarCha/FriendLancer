//
//  Comment.swift
//  FriendLancer
//
//  Created by Studio on 12/01/2020.
//  Copyright © 2020 Nitzan & Inbar. All rights reserved.
//

import Foundation

class Comment {
    var userName:String = ""
    var userProfession:String = ""
    var comment:String = ""
    var postId:String = ""
    var commentId:String = ""
    
    init(userName:String, userProfession:String, comment:String, postId:String) {
        self.userName = userName
        self.userProfession = userProfession
        self.comment = comment
        self.postId = postId
        
        let identifier = UUID()
        self.commentId = identifier.uuidString
    }
    
    init(json:[String:Any]) {
        self.userName = json["userName"] as! String;
        self.userProfession = json["userProfession"] as! String;
        self.comment = json["comment"] as! String;
        self.postId = json["postId"] as! String;
        self.commentId = json["commentId"] as! String;
    }
    
    func toJson() ->[String:String] {
        var json = [String:String]();
        json["userName"] = self.userName
        json["userProfession"] = self.userProfession
        json["comment"] = self.comment
        json["postId"] = self.postId
        json["commentId"] = self.commentId
        return json;
    }
}
