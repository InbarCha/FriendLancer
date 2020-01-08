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
    
    func add(forum:Forum){
        modelFirebase.add(forum:forum);
        ModelEvents.ForumDataNotification.post();
    }
    
    func add(post:Post) {
        modelFirebase.add(post: post)
        ModelEvents.PostDataNotification.post();
    }
    
    func getAllForums(callback:@escaping ([Forum]?)->Void){
        modelFirebase.getAllForums(callback: callback)
    }
    
    func getAllPosts(callback:@escaping ([Post]?)->Void){
        modelFirebase.getAllPosts(callback: callback)
    }
    

}

class ModelEvents{
    static let ForumDataNotification = ModelEventsTemplate(name: "com.nitzanInbar.ForumDataNotification");
    static let PostDataNotification = ModelEventsTemplate(name:"com.nitzanInbar.PostDataNotification")
    
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
