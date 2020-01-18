//
//  Comment.swift
//  FriendLancer
//
//  Created by Studio on 12/01/2020.
//  Copyright © 2020 Nitzan & Inbar. All rights reserved.
//

import Foundation

class Comment {
    var commentId:String = ""
    var postId:String = ""
    var userEmail:String = ""
    var userName:String = ""
    var userProfession:String = ""
    var comment:String = ""
    
    init(userEmail:String,userName:String, userProfession:String, comment:String, postId:String, commentId:String="") {
        self.userEmail = userEmail
        self.userName = userName
        self.userProfession = userProfession
        self.comment = comment
        self.postId = postId
        
        if(commentId == "") {
            let identifier = UUID()
            self.commentId = identifier.uuidString
        }
        else {
            self.commentId = commentId
        }
    }
    
    init(json:[String:Any]) {
        self.userEmail = json["userEmail"] as! String;
        self.userName = json["userName"] as! String;
        self.userProfession = json["userProfession"] as! String;
        self.comment = json["comment"] as! String;
        self.postId = json["postId"] as! String;
        self.commentId = json["commentId"] as! String;
    }
    
    func toJson() ->[String:String] {
        var json = [String:String]();
        json["userEmail"] = self.userEmail
        json["userName"] = self.userName
        json["userProfession"] = self.userProfession
        json["comment"] = self.comment
        json["postId"] = self.postId
        json["commentId"] = self.commentId
        return json;
    }
}
