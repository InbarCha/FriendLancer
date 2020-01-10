//
//  ModelFirebase.swift
//  FriendLancer
//
//  Created by Studio on 03/01/2020.
//  Copyright © 2020 Nitzan & Inbar. All rights reserved.
//

import Foundation
import Firebase

class ModelFirebase{
    
    func add(forum:Forum){
        let db = Firestore.firestore()
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = db.collection("Forums").addDocument(data: forum.toJson(), completion: { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Forum added with ID: \(ref!.documentID)")
                }
        })
    }
    
    func add(post:Post) {
        let db = Firestore.firestore()
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil

        ref = db.collection("Posts").addDocument(data: post.toJson(), completion: { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Forum added with ID: \(ref!.documentID)")
                }
        })
    }
    
    func getAllForums(callback: @escaping ([Forum]?)->Void){
        let db = Firestore.firestore()
        db.collection("Forums").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                callback(nil);
            } else {
                var data = [Forum]();
                for document in querySnapshot!.documents {
                    data.append(Forum(json: document.data()));
                }
                callback(data);
            }
        };
    }
    
    func getAllPosts(callback: @escaping ([Post]?)->Void, forumName: String){
        let db = Firestore.firestore()
        
        db.collection("Posts").whereField("forumName", isEqualTo: forumName).getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                callback(nil);
            } else {
                var data = [Post]();
                for document in querySnapshot!.documents {
                    data.append(Post(json: document.data()));
                }
                callback(data);
            }
        };
    }
}
