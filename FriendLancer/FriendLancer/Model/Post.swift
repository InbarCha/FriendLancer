//
//  Post.swift
//  FriendLancer
//
//  Created by Studio on 10/01/2020.
//  Copyright © 2020 Nitzan & Inbar. All rights reserved.
//

import Foundation

class Post {
    var postTitle:String = ""
    var postSubject = """
                      """
    var meetingPlace:String = ""
    var forumName:String = ""
    
    var postId:String = ""
    
    var participant1Name:String = ""
    var participant2Name:String = ""
    var participant3Name:String = ""
    var participant4Name:String = ""
    var participant5Name:String = ""
    
    var participant1Prof:String = ""
    var participant2Prof:String = ""
    var participant3Prof:String = ""
    var participant4Prof:String = ""
    var participant5Prof:String = ""
    
    var participant1Status:String = ""
    var participant2Status:String = ""
    var participant3Status:String = ""
    var participant4Status:String = ""
    var participant5Status:String = ""
    
    init(postTitle:String, postSubject: StringLiteralType, meetingPlace:String, forumName:String, participant1Name:String = "", participant2Name:String = "",
         participant3Name:String = "", participant4Name:String = "", participant5Name:String = "", participant1Prof:String = "",
         participant2Prof:String = "", participant3Prof:String = "", participant4Prof:String = "", participant5Prof:String = "",
         participant1Status:String = "", participant2Status:String = "", participant3Status:String = "", participant4Status:String = "",
         participant5Status:String = "") {
        self.postSubject = postSubject
        self.meetingPlace = meetingPlace
        self.forumName = forumName
        self.postTitle = postTitle
        self.participant1Name = participant1Name
        self.participant2Name = participant2Name
        self.participant3Name = participant3Name
        self.participant4Name = participant4Name
        self.participant5Name = participant5Name
        self.participant1Prof = participant1Prof
        self.participant2Prof = participant2Prof
        self.participant3Prof = participant3Prof
        self.participant4Prof = participant4Prof
        self.participant5Prof = participant5Prof
        self.participant1Status = participant1Status
        self.participant2Status = participant2Status
        self.participant3Status = participant3Status
        self.participant4Status = participant4Status
        self.participant5Status = participant5Status
        
        //generate post ID
        let identifier = UUID()
        self.postId = identifier.uuidString
    }
    
    init(json:[String:Any]){
        self.postSubject = json["postSubject"] as! StringLiteralType;
        self.meetingPlace = json["meetingPlace"] as! String;
        self.forumName = json["forumName"] as! String;
        self.postTitle = json["postTitle"] as! String
        self.participant1Name = json["participant1Name"] as! String;
        self.participant2Name = json["participant2Name"] as! String;
        self.participant3Name = json["participant3Name"] as! String;
        self.participant4Name = json["participant4Name"] as! String;
        self.participant5Name = json["participant5Name"] as! String;
        self.participant1Prof = json["participant1Prof"] as! String;
        self.participant2Prof = json["participant2Prof"] as! String;
        self.participant3Prof = json["participant3Prof"] as! String;
        self.participant4Prof = json["participant4Prof"] as! String;
        self.participant5Prof = json["participant5Prof"] as! String;
        self.participant1Status = json["participant1Status"] as! String;
        self.participant2Status = json["participant2Status"] as! String;
        self.participant3Status = json["participant3Status"] as! String;
        self.participant4Status = json["participant4Status"] as! String;
        self.participant5Status = json["participant5Status"] as! String;
        self.postId = json["postId"] as! String;
    }
    
    func toJson() -> [String:String] {
        var json = [String:String]();
        json["postSubject"] = self.postSubject
        json["meetingPlace"] = self.meetingPlace
        json["forumName"] = self.forumName
        json["postTitle"] = self.postTitle
        json["participant1Name"] = self.participant1Name
        json["participant2Name"] = self.participant2Name
        json["participant3Name"] = self.participant3Name
        json["participant4Name"] = self.participant4Name
        json["participant5Name"] = self.participant5Name
        json["participant1Prof"] = self.participant1Prof
        json["participant2Prof"] = self.participant2Prof
        json["participant3Prof"] = self.participant3Prof
        json["participant4Prof"] = self.participant4Prof
        json["participant5Prof"] = self.participant5Prof
        json["participant1Status"] = self.participant1Status
        json["participant2Status"] = self.participant2Status
        json["participant3Status"] = self.participant3Status
        json["participant4Status"] = self.participant4Status
        json["participant5Status"] = self.participant5Status
        json["postId"] = self.postId
        return json;
    }
    
}
