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
        ModelEvents.ForumDataNotification.post();
    }
    
    func add(post:Post) {
        modelFirebase.add(post: post)
        ModelEvents.PostDataNotification.post();
    }
    
    func add(comment:Comment) {
        modelFirebase.add(comment: comment)
        ModelEvents.CommentDataNotification.post();
    }
    
    func add(meetPlace:MeetPlace) {
        modelFirebase.add(meetPlace: meetPlace)
        ModelEvents.MeetPlacesDataNotification.post();
    }
    
    func add(meetPlaceType:MeetPlaceType) {
        modelFirebase.add(meetPlaceType: meetPlaceType)
        ModelEvents.MeetPlacesTypeDataNotification.post();
    }
    
    func add(user:User) {
        modelFirebase.add(user:user)
        ModelEvents.UserLoggedInDataNotification.post()
    }
    
    func update(comment:Comment) {
        modelFirebase.update(comment:comment)
        ModelEvents.CommentDataNotification.post();
    }
    
    func update(post:Post) {
        modelFirebase.update(post:post)
    }
    
    func update(user:User) {
        modelFirebase.update(user: user)
    }
    
    func delete(post:Post) {
        modelFirebase.delete(post:post)
        ModelEvents.PostDataNotification.post()
    }
    
    func delete(comment:Comment) {
        modelFirebase.delete(comment:comment)
        ModelEvents.CommentDataNotification.post()
    }
    
    func getUserByEmail(callback:@escaping (User?)->Void, email:String) {
        modelFirebase.getUserByEmail(callback: callback, email: email)
    }
    
    func getPostById(callback:@escaping (Post?)->Void, postId:String){
        modelFirebase.getPostById(callback: callback, postId: postId)
    }
    
    func getAllForums(callback:@escaping ([Forum]?)->Void){
        modelFirebase.getAllForums(callback: callback)
    }
    
    func getAllMeetingPlaces(callback:@escaping ([MeetPlace]?)->Void, meetPlaceTypeId:String) {
        modelFirebase.getAllMeetingPlaces(callback: callback, meetPlaceTypeId:meetPlaceTypeId)
    }
    
    func getAllMeetingPlaceTypes(callback:@escaping ([MeetPlaceType]?)->Void){
        modelFirebase.getAllMeetingPlaceTypes(callback: callback)
    }
    
    func getAllPosts(callback:@escaping ([Post]?)->Void, forumName:String){
        modelFirebase.getAllPosts(callback: callback, forumName: forumName)
    }
    
    func getAllComments(callback:@escaping ([Comment]?)->Void, postId:String) {
        modelFirebase.getAllComments(callback: callback, postId: postId)
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
