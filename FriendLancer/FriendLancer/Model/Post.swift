//
//  Post.swift
//  FriendLancer
//
//  Created by Studio on 10/01/2020.
//  Copyright © 2020 Nitzan & Inbar. All rights reserved.
//

import Foundation
import Firebase

class Post {
    var postId:String = ""
    var postTitle:String = ""
    var postSubject = """
                      """
    var meetingPlace:String = ""
    var forumName:String = ""
    
    var postOwnerUserEmail:String = ""
    
    var participant1Email:String = ""
    var participant2Email:String = ""
    var participant3Email:String = ""
    var participant4Email:String = ""
    var participant5Email:String = ""
    
    var participant1Status:String = ""
    var participant2Status:String = ""
    var participant3Status:String = ""
    var participant4Status:String = ""
    var participant5Status:String = ""
    var lastUpdated:Int64 = 0
    
    init(postTitle:String, postSubject: StringLiteralType, meetingPlace:String, forumName:String, postOwnerUserEmail:String = "", participant1Email:String = "", participant2Email:String = "", participant3Email:String = "",  participant4Email:String = "", participant5Email:String = "",participant1Status:String = "", participant2Status:String = "", participant3Status:String = "", participant4Status:String = "", participant5Status:String = "", postId:String = "") {
        self.postSubject = postSubject
        self.meetingPlace = meetingPlace
        self.forumName = forumName
        self.postTitle = postTitle
        self.postOwnerUserEmail = postOwnerUserEmail
        self.participant1Email = participant1Email
        self.participant2Email = participant2Email
        self.participant3Email = participant3Email
        self.participant4Email = participant4Email
        self.participant5Email = participant5Email
        self.participant1Status = participant1Status
        self.participant2Status = participant2Status
        self.participant3Status = participant3Status
        self.participant4Status = participant4Status
        self.participant5Status = participant5Status
        
        //generate post ID
        if (postId == "") {
            let identifier = UUID()
            self.postId = identifier.uuidString
        }
        else {
            self.postId = postId
        }
        
    }
    
    init(json:[String:Any]){
        self.postSubject = json["postSubject"] as! StringLiteralType;
        self.meetingPlace = json["meetingPlace"] as! String;
        self.forumName = json["forumName"] as! String;
        self.postTitle = json["postTitle"] as! String
        self.postOwnerUserEmail = json["postOwnerUserEmail"] as! String
        self.participant1Email = json["participant1Email"] as! String
        self.participant2Email = json["participant2Email"] as! String
        self.participant3Email = json["participant3Email"] as! String
        self.participant4Email = json["participant4Email"] as! String
        self.participant5Email = json["participant5Email"] as! String
        self.participant1Status = json["participant1Status"] as! String;
        self.participant2Status = json["participant2Status"] as! String;
        self.participant3Status = json["participant3Status"] as! String;
        self.participant4Status = json["participant4Status"] as! String;
        self.participant5Status = json["participant5Status"] as! String;
        let ts = json["lastUpdated"] as! Timestamp
        self.lastUpdated = ts.seconds
        self.postId = json["postId"] as! String;
    }
    
    func toJson() -> [String:Any] {
        var json = [String:Any]();
        json["postSubject"] = self.postSubject
        json["meetingPlace"] = self.meetingPlace
        json["forumName"] = self.forumName
        json["postTitle"] = self.postTitle
        json["postOwnerUserEmail"] = self.postOwnerUserEmail
        json["participant1Email"] = self.participant1Email
        json["participant2Email"] = self.participant2Email
        json["participant3Email"] = self.participant3Email
        json["participant4Email"] = self.participant4Email
        json["participant5Email"] = self.participant5Email
        json["participant1Status"] = self.participant1Status
        json["participant2Status"] = self.participant2Status
        json["participant3Status"] = self.participant3Status
        json["participant4Status"] = self.participant4Status
        json["participant5Status"] = self.participant5Status
        json["postId"] = self.postId
        json["lastUpdated"] = FieldValue.serverTimestamp()
        return json;
    }
    
}
