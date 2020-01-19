//
//  Model.swift
//  FriendLancer
//
//  Created by Studio on 03/01/2020.
//  Copyright © 2020 Nitzan & Inbar. All rights reserved.
//

import Foundation
import UIKit

class Model {
    static let instance = Model();
    var modelFirebase:ModelFirebase = ModelFirebase()
    var modelSql:ModelSql = ModelSql()
    
    func add(forum:Forum){
        modelFirebase.add(forum:forum);
        modelSql.add(forum: forum)
    }
    
    func add(post:Post) {
        modelFirebase.add(post: post)
        modelSql.add(post: post)
        ModelEvents.PostDataNotification.post();
    }
    
    func add(comment:Comment) {
        modelFirebase.add(comment: comment)
        modelSql.add(comment: comment)
    }
    
    func add(meetPlace:MeetPlace) {
        modelFirebase.add(meetPlace: meetPlace)
        modelSql.add(meetPlace: meetPlace)
    }
    
    func add(meetPlaceType:MeetPlaceType) {
        modelFirebase.add(meetPlaceType: meetPlaceType)
        modelSql.add(meetPlaceType: meetPlaceType)
        ModelEvents.MeetPlacesTypeDataNotification.post();
    }
    
    func add(user:User) {
        modelFirebase.add(user:user)
        modelSql.add(user:user)
        ModelEvents.UserLoggedInDataNotification.post()
    }
    
    func update(comment:Comment) {
        modelFirebase.update(comment:comment)
        modelSql.add(comment:comment)
        ModelEvents.CommentDataNotification.post();
    }
    
    func update(post:Post) {
        modelFirebase.update(post:post)
        modelSql.add(post: post)
    }
    
    func update(user:User) {
        modelFirebase.update(user: user)
        modelSql.add(user: user)
    }
    
    func delete(post:Post) {
        modelFirebase.delete(post:post)
        modelSql.delete(post: post)
        ModelEvents.PostDataNotification.post()
    }
    
    func delete(comment:Comment) {
        modelFirebase.delete(comment:comment)
        modelSql.delete(comment: comment)
        ModelEvents.CommentDataNotification.post()
    }
    
    func getUserByEmail(callback:@escaping (User?)->Void, email:String) {
        modelFirebase.getUserByEmail(callback: callback, email: email)
    }
    
    func getPostById(callback:@escaping (Post?)->Void, postId:String){
        modelFirebase.getPostById(callback: callback, postId: postId)
    }
    
    func getAllForums(callback:@escaping ([Forum]?)->Void){
        //get the local last update date
        let lud = modelSql.getLastUpdateDate(tableName: "FORUMS")
        
        //get the records from firebase since the local last update date
        modelFirebase.getAllForums(since:lud) { (forumsArray) in
            //save the new records to the local db (SQL)
            var localLud:Int64 = 0
            for forum in forumsArray! {
                self.modelSql.add(forum: forum)
                if (forum.lastUpdated > localLud) {
                    localLud = forum.lastUpdated
                }
            }
            
            //save the new local last update date
            self.modelSql.setLastUpdateDate(name: "FORUMS", lud: localLud)
            
            //get the complete data from the local db
            let completeData = self.modelSql.getAllForums()
            
            //return the complete data to the caller
            callback(completeData)
        }
    }
    
    func getAllMeetingPlaces(callback:@escaping ([MeetPlace]?)->Void, meetPlaceTypeId:String) {
        modelFirebase.getAllMeetingPlaces(meetPlaceTypeId: meetPlaceTypeId, callback: callback)
    }
    
    func getAllMeetingPlaceTypes(callback:@escaping ([MeetPlaceType]?)->Void){
        modelFirebase.getAllMeetingPlaceTypes(callback: callback)
    }
    
    func getAllPosts(callback:@escaping ([Post]?)->Void, forumName:String){
        //get the local last update date
        let lud = modelSql.getLastUpdateDate(tableName: "POSTS")
        
        //get the records from firebase since the local last update date
        modelFirebase.getAllPosts(callback: { (postsArray) in
            //save the new records to the local db (SQL)
            var localLud:Int64 = 0
            for post in postsArray! {
                self.modelSql.add(post: post)
                if (post.lastUpdated > localLud) {
                    localLud = post.lastUpdated
                }
            }
            
             //save the new local last update date
            self.modelSql.setLastUpdateDate(name: "POSTS", lud: localLud)
            
            //get the complete data from the local db
            let completeData = self.modelSql.getAllPosts(forumName:forumName)
            
            //return the complete data to the caller
            callback(completeData)
            
        }, forumName: forumName, since:lud)
    }
    
    func getAllComments(callback:@escaping ([Comment]?)->Void, postId:String) {
        //modelFirebase.getAllComments(callback: callback, postId: postId)
        
        let lud = modelSql.getLastUpdateDate(tableName: "COMMENTS")
        
        modelFirebase.getAllComments(callback: { (commentsArray) in
            var localLud:Int64 = 0
            for comment in commentsArray! {
                self.modelSql.add(comment: comment)
                if (comment.lastUpdated > localLud) {
                    localLud = comment.lastUpdated
                }
            }
            
            self.modelSql.setLastUpdateDate(name: "COMMENTS", lud: localLud)
            
            let completeData = self.modelSql.getAllComments(postId: postId)
            
            callback(completeData)
            
        }, postId: postId, since: lud)
        
    }
    
    func saveImage(image:UIImage, callback: @escaping (String)->Void){
        FirebaseStorage.saveImage(image: image, callback: callback)
    }
}

class ModelEvents{
    static let ForumDataNotification = ModelEventsTemplate(name: "com.nitzanInbar.ForumDataNotification");
    static let PostDataNotification = ModelEventsTemplate(name:"com.nitzanInbar.PostDataNotification")
    static let CommentDataNotification = ModelEventsTemplate(name: "com.nitzanInbar.CommentDataNotification")
    static let MeetPlacesTypeDataNotification = ModelEventsTemplate(name: "com.nitzanInbar.MeetPlacesTypeDataNotification")
    static let MeetPlacesDataNotification = ModelEventsTemplate(name: "com.nitzanInbar.MeetPlacesDataNotification")
    static let UserLoggedInDataNotification = ModelEventsTemplate(name: "com.nitzanInbar.UserLoggedInDataNotification")
    static let UserLoggedOutDataNotification = ModelEventsTemplate(name: "com.nitzanInbar.UserLoggedOutDataNotification")
    static let UserDataNotification = ModelEventsTemplate(name: "com.nitzanInbar.UserDataNotification")
    
    static func removeObserver(observer:Any){
        NotificationCenter.default.removeObserver(observer)
    }
    private init(){}
}


class ModelEventsTemplate{
    let notificationName:String;
    
    init(name:String){
        notificationName = name;
    }
    func observe(callback:@escaping ()->Void)->Any{
        return NotificationCenter.default.addObserver(forName: NSNotification.Name(notificationName),
                                                      object: nil, queue: nil) { (data) in
                                                        callback();
        }
    }
    
    func post(){
        NotificationCenter.default.post(name: NSNotification.Name(notificationName), object: self,userInfo:nil);
    }


}
