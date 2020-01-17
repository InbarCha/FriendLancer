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
    
    func add(comment:Comment) {
        let db = Firestore.firestore()
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil

        ref = db.collection("Comments").addDocument(data: comment.toJson(), completion: { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Forum added with ID: \(ref!.documentID)")
                }
        })
    }
    
    func add(meetPlaceType: MeetPlaceType) {
        let db = Firestore.firestore()
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil

        ref = db.collection("MeetPlaceTypes").addDocument(data: meetPlaceType.toJson(), completion: { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Forum added with ID: \(ref!.documentID)")
                }
        })
    }
    
    func add(meetPlace: MeetPlace) {
        let db = Firestore.firestore()
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil

        ref = db.collection("MeetPlaces").addDocument(data: meetPlace.toJson(), completion: { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Forum added with ID: \(ref!.documentID)")
                }
        })
    }
    
    
    func add(user:User) {
        let db = Firestore.firestore()
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil

        ref = db.collection("Users").addDocument(data: user.toJson(), completion: { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Forum added with ID: \(ref!.documentID)")
                }
        })
    }
    
    func update(comment:Comment) {
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        
        db.collection("Users").whereField("commentId", isEqualTo: comment.commentId).getDocuments{ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    document.reference.updateData(comment.toJson())
                }
            }
        };
    }
    
    func update(post:Post) {
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        
        db.collection("Posts").whereField("postId", isEqualTo: post.postId).getDocuments{ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    document.reference.updateData(post.toJson())
                }
            }
        };
    }
    
    func update(user:User) {
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        
        db.collection("Users").whereField("email", isEqualTo: user.email).getDocuments{ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    document.reference.updateData(user.toJson()) { (_error:Error?) in
                        ModelEvents.UserDataNotification.post()
                    }
                }
            }
        };
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
    
    func getAllMeetingPlaces(callback: @escaping ([MeetPlace]?)->Void, meetPlaceTypeId:String){
        let db = Firestore.firestore()
        db.collection("MeetPlaces").whereField("meetPlaceTypeId", isEqualTo: meetPlaceTypeId).getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                callback(nil);
            } else {
                var data = [MeetPlace]();
                for document in querySnapshot!.documents {
                    data.append(MeetPlace(json: document.data()));
                }
                callback(data);
            }
        };
    }
    
    func getAllMeetingPlaceTypes(callback: @escaping ([MeetPlaceType]?)->Void){
        let db = Firestore.firestore()
        db.collection("MeetPlaceTypes").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                callback(nil);
            } else {
                var data = [MeetPlaceType]();
                for document in querySnapshot!.documents {
                    data.append(MeetPlaceType(json: document.data()));
                }
                callback(data);
            }
        };
    }
    
    func getPostById(callback: @escaping (Post?)->Void, postId: String){
        let db = Firestore.firestore()
        
        db.collection("Posts").whereField("postId", isEqualTo: postId).getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                callback(nil);
            } else {
                let post = Post(json: querySnapshot!.documents[querySnapshot!.documents.startIndex].data())
                callback(post);
            }
        };
    }
    
    func getUserByEmail(callback: @escaping (User?)->Void, email: String) {
        let db = Firestore.firestore()
        
        db.collection("Users").whereField("email", isEqualTo: email).getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                callback(nil);
            } else {
                let myUser = User(json: querySnapshot!.documents[querySnapshot!.documents.startIndex].data())
                callback(myUser);
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
    
    func getAllComments(callback: @escaping ([Comment]?)->Void, postId: String){
        let db = Firestore.firestore()
        
        db.collection("Comments").whereField("postId", isEqualTo: postId).getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                callback(nil);
            } else {
                var data = [Comment]();
                for document in querySnapshot!.documents {
                    data.append(Comment(json: document.data()));
                }
                callback(data);
            }
        };
    }
}
