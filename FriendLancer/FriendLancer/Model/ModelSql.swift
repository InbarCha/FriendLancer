//
//  ModelSql.swift
//  FriendLancer
//
//  Created by yaniv hachmon on 18/01/2020.
//  Copyright © 2020 Nitzan & Inbar. All rights reserved.
//

import Foundation

class ModelSql {
     var database: OpaquePointer? = nil
    
    init() {
        let dbFileName = "databaseFriendLancer31.db"
        if let dir = FileManager.default.urls(for: .documentDirectory, in:
        .userDomainMask).first{
            let path = dir.appendingPathComponent(dbFileName)
            if sqlite3_open(path.absoluteString, &database) != SQLITE_OK {
                print("Failed to open db file: \(path.absoluteString)")
                return
            }
            
            createTables()
        }
    }
    
    func createTables() {
        var errormsg: UnsafeMutablePointer<Int8>? = nil
        
        //create Forums Table
        let res1 = sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS FORUMS (FORUM_TOPIC TEXT PRIMARY KEY, FORUM_TOPIC_AVATAR TEXT)", nil, nil, &errormsg);
        if(res1 != 0){
            print("error creating table");
            return
        }
        
        //create Posts Table
        let res2 = sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS POSTS (POST_ID TEXT PRIMARY KEY, POST_TITLE TEXT, POST_SUBJECT TEXT, MEETING_PLACE TEXT, FORUM_NAME TEXT, POST_OWNER_USER_EMAIL TEXT, PARTICIPANT1EMAIL TEXT, PARTICIPANT2EMAIL TEXT, PARTICIPANT3EMAIL TEXT, PARTICIPANT4EMAIL TEXT, PARTICIPANT5EMAIL TEXT, PARTICIPANT1STATUS TEXT, PARTICIPANT2STATUS TEXT, PARTICIPANT3STATUS TEXT, PARTICIPANT4STATUS TEXT, PARTICIPANT5STATUS TEXT)", nil, nil, &errormsg);
        if(res2 != 0){
            print("error creating table");
            return
        }
        
        //create comments Table
        let res3 = sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS COMMENTS (COMMENT_ID TEXT PRIMARY KEY, POST_ID TEXT, USER_EMAIL TEXT, USER_NAME TEXT, USER_PROFESSION TEXT, COMMENT TEXT)", nil, nil, &errormsg);
        if(res3 != 0){
            print("error creating table");
            return
        }
        
        //create MeetPlaceTypes Table
        let res4 = sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS MEETPLACETYPES (TYPE_ID TEXT PRIMARY KEY, TYPE TEXT)", nil, nil, &errormsg);
        if(res4 != 0){
            print("error creating table");
            return
        }
        
        //create MeetPlaces Table
        let res5 = sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS MEETPLACES (MEET_PLACE_ID TEXT PRIMARY KEY, MEET_PLACE_TYPE_ID TEXT, NAME TEXT, CITY TEXT, ADDRESS TEXT, IMAGE TEXT)", nil, nil, &errormsg);
        if(res5 != 0){
            print("error creating table");
            return
        }
        
        //create Users Table
        let res6 = sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS USERS (USER_EMAIL TEXT PRIMARY KEY, NAME TEXT, PROFESSION TEXT, IMAGE TEXT, IS_ADMIN TEXT)", nil, nil, &errormsg);
        if(res6 != 0){
            print("error creating table");
            return
        }
        
        //create Last Update Date Table
        let res7 = sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS LAST_UPDATE_DATE (TABLE_NAME TEXT PRIMARY KEY, LUD NUMBER)", nil, nil, &errormsg);
        if(res7 != 0){
            print("error creating table");
            return
        }
        
    }
    
    func setLastUpdateDate(name:String, lud:Int64) {
        var sqlite3_stmt: OpaquePointer? = nil
        
        if (sqlite3_prepare_v2(database,"INSERT OR REPLACE INTO LAST_UPDATE_DATE(TABLE_NAME, LUD) VALUES (?,?);",-1, &sqlite3_stmt,nil) == SQLITE_OK){
            sqlite3_bind_text(sqlite3_stmt, 1, name.cString(using: .utf8),-1,nil);
            sqlite3_bind_int64(sqlite3_stmt, 2, lud);
            if (sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
                print("new row added succefully")
                
            }
        }
    }
    
    func getLastUpdateDate(tableName:String)->Int64 {
        var sqlite3_stmt: OpaquePointer? = nil
        var lud:Int64 = 0
        if (sqlite3_prepare_v2(database,"SELECT * from LAST_UPDATE_DATE where TABLE_NAME=?",-1,&sqlite3_stmt,nil) == SQLITE_OK){
            sqlite3_bind_text(sqlite3_stmt, 1, tableName.cString(using: .utf8),-1,nil);
            if(sqlite3_step(sqlite3_stmt) == SQLITE_ROW){
                lud = sqlite3_column_int64(sqlite3_stmt, 1)
            }
        }
        sqlite3_finalize(sqlite3_stmt)
        return lud
    }
    
    func add(forum:Forum) {
        var sqlite3_stmt: OpaquePointer? = nil
        
        if (sqlite3_prepare_v2(database,"INSERT OR REPLACE INTO FORUMS(FORUM_TOPIC, FORUM_TOPIC_AVATAR) VALUES (?,?);",-1, &sqlite3_stmt,nil) == SQLITE_OK){
            let forumTopic = forum.forumTopic.cString(using: .utf8)
            let forumTopicAvatar = forum.forumTopicAvatar.cString(using: .utf8)
            sqlite3_bind_text(sqlite3_stmt, 1, forumTopic,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 2, forumTopicAvatar,-1,nil);
            if (sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
                print("new row added succefully")
            }
        }
    }
    
    func add(post:Post) {
        var sqlite3_stmt: OpaquePointer? = nil
        
        if (sqlite3_prepare_v2(database,"INSERT OR REPLACE INTO POSTS(POST_ID, POST_TITLE, POST_SUBJECT, MEETING_PLACE, FORUM_NAME, POST_OWNER_USER_EMAIL, PARTICIPANT1EMAIL, PARTICIPANT2EMAIL, PARTICIPANT3EMAIL, PARTICIPANT4EMAIL, PARTICIPANT5EMAIL, PARTICIPANT1STATUS, PARTICIPANT2STATUS, PARTICIPANT3STATUS, PARTICIPANT4STATUS, PARTICIPANT5STATUS) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);",-1, &sqlite3_stmt,nil) == SQLITE_OK){
            let postId = post.postId.cString(using: .utf8)
            let postTitle = post.postTitle.cString(using: .utf8)
            let postSubject = post.postSubject.cString(using: .utf8)
            let meetingPlace = post.meetingPlace.cString(using: .utf8)
            let forumName = post.forumName.cString(using: .utf8)
            let postOwnerUserEmail = post.postOwnerUserEmail.cString(using: .utf8)
            let participant1Email = post.participant1Email.cString(using: .utf8)
            let participant2Email = post.participant2Email.cString(using: .utf8)
            let participant3Email = post.participant3Email.cString(using: .utf8)
            let participant4Email = post.participant4Email.cString(using: .utf8)
            let participant5Email = post.participant5Email.cString(using: .utf8)
            let participant1Status = post.participant1Status.cString(using: .utf8)
            let participant2Status = post.participant2Status.cString(using: .utf8)
            let participant3Status = post.participant3Status.cString(using: .utf8)
            let participant4Status = post.participant4Status.cString(using: .utf8)
            let participant5Status = post.participant5Status.cString(using: .utf8)
            
            sqlite3_bind_text(sqlite3_stmt, 1, postId,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 2, postTitle,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 3, postSubject,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 4, meetingPlace,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 5, forumName,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 6, postOwnerUserEmail,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 7, participant1Email,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 8, participant2Email,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 9, participant3Email,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 10, participant4Email,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 11, participant5Email,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 12, participant1Status,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 13, participant2Status,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 14, participant3Status,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 15, participant4Status,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 16, participant5Status,-1,nil);
            if (sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
                print("new row added succefully")
                
            }
        }
    }
    
    func add(comment:Comment) {
        var sqlite3_stmt: OpaquePointer? = nil
        
        if (sqlite3_prepare_v2(database,"INSERT OR REPLACE INTO COMMENTS(COMMENT_ID, POST_ID, USER_EMAIL, USER_NAME, USER_PROFESSION, COMMENT) VALUES (?,?,?,?,?,?);",-1, &sqlite3_stmt,nil) == SQLITE_OK){
            let commentId = comment.commentId.cString(using: .utf8)
            let postId = comment.postId.cString(using: .utf8)
            let userEmail = comment.userEmail.cString(using: .utf8)
            let userName = comment.userName.cString(using: .utf8)
            let userProfession = comment.userProfession.cString(using: .utf8)
            let comment = comment.comment.cString(using: .utf8)
            sqlite3_bind_text(sqlite3_stmt, 1, commentId,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 2, postId,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 3, userEmail,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 4, userName,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 5, userProfession,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 6, comment,-1,nil);
            if (sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
                print("new row added succefully")
                
            }
        }
    }
    
    func add(meetPlaceType:MeetPlaceType) {
        var sqlite3_stmt: OpaquePointer? = nil
        
        if (sqlite3_prepare_v2(database,"INSERT OR REPLACE INTO MEETPLACETYPES(TYPE_ID, TYPE) VALUES (?,?);",-1, &sqlite3_stmt,nil) == SQLITE_OK){
            let typeId = meetPlaceType.typeId.cString(using: .utf8)
            let type = meetPlaceType.type.cString(using: .utf8)
            sqlite3_bind_text(sqlite3_stmt, 1, typeId,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 2, type,-1,nil);
            if (sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
                print("new row added succefully")
                
            }
        }
    }
    
    func add(meetPlace:MeetPlace) {
        var sqlite3_stmt: OpaquePointer? = nil
        
        if (sqlite3_prepare_v2(database,"INSERT OR REPLACE INTO MEETPLACES(MEET_PLACE_ID, MEET_PLACE_TYPE_ID, NAME, CITY, ADDRESS, IMAGE) VALUES (?,?,?,?,?,?);",-1, &sqlite3_stmt,nil) == SQLITE_OK){
            let meetPlaceId = meetPlace.meetPlaceId.cString(using: .utf8)
            let meetPlaceTypeId = meetPlace.meetPlaceTypeId.cString(using: .utf8)
            let name = meetPlace.name.cString(using: .utf8)
            let city = meetPlace.city.cString(using: .utf8)
            let address = meetPlace.address.cString(using: .utf8)
            let image = meetPlace.image.cString(using: .utf8)
            sqlite3_bind_text(sqlite3_stmt, 1, meetPlaceId,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 2, meetPlaceTypeId ,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 3, name ,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 4, city ,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 5, address ,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 6, image ,-1,nil);
            if (sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
                print("new row added succefully")
                
            }
        }
    }
    
    func add(user:User) {
        var sqlite3_stmt: OpaquePointer? = nil
        
        if (sqlite3_prepare_v2(database,"INSERT OR REPLACE INTO USERS(USER_EMAIL, NAME, PROFESSION, IMAGE, IS_ADMIN) VALUES (?,?,?,?,?);",-1, &sqlite3_stmt,nil) == SQLITE_OK){
            let email = user.email.cString(using: .utf8)
            let name = user.name.cString(using: .utf8)
            let profession = user.profession.cString(using: .utf8)
            let image = user.image.cString(using: .utf8)
            let isAdmin = user.isAdmin.cString(using: .utf8)
            sqlite3_bind_text(sqlite3_stmt, 1, email,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 2, name ,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 3, profession ,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 4, image ,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 5, isAdmin ,-1,nil);
            if (sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
                print("new row added succefully")
                
            }
        }
    }
    
    func delete(post:Post) {
        var sqlite3_stmt: OpaquePointer? = nil
        
        if (sqlite3_prepare_v2(database,"DELETE FROM POSTS where POST_ID=?",-1, &sqlite3_stmt,nil) == SQLITE_OK){
            let postId = post.postId.cString(using: .utf8)
            sqlite3_bind_text(sqlite3_stmt, 1, postId,-1,nil);
            if (sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
                print("deleted row added succefully")
                
            }
        }
    }
    
    func delete(comment:Comment) {
        var sqlite3_stmt: OpaquePointer? = nil
        
        if (sqlite3_prepare_v2(database,"DELETE FROM COMMENTS where COMMENT_ID=?",-1, &sqlite3_stmt,nil) == SQLITE_OK){
            let commentId = comment.commentId.cString(using: .utf8)
            sqlite3_bind_text(sqlite3_stmt, 1, commentId,-1,nil);
            if (sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
                print("deleted row added succefully")
                
            }
        }
    }
    
    func getUserByEmail(email:String)->User? {
        var sqlite3_stmt: OpaquePointer? = nil
        var data = [User]()
        if (sqlite3_prepare_v2(database,"SELECT * from USERS where USER_EMAIL=?;",-1,&sqlite3_stmt,nil) == SQLITE_OK){
            sqlite3_bind_text(sqlite3_stmt, 1, email.cString(using: .utf8),-1,nil);
            while(sqlite3_step(sqlite3_stmt) == SQLITE_ROW){
                let userEmail = String(cString:sqlite3_column_text(sqlite3_stmt,0)!);
                let name = String(cString:sqlite3_column_text(sqlite3_stmt,1)!);
                let profession = String(cString:sqlite3_column_text(sqlite3_stmt,2)!);
                let image = String(cString:sqlite3_column_text(sqlite3_stmt,3)!);
                let isAdmin = String(cString:sqlite3_column_text(sqlite3_stmt,4)!);
                data.append(User(email: userEmail, name: name, profession: profession, image: image, isAdmin: isAdmin))
            }
        }
        sqlite3_finalize(sqlite3_stmt)
        if (data.count > 0){
            return data[0]
        }
        else {
            return nil
        }
    }
    
    func getPostById(postId:String)->Post? {
        var sqlite3_stmt: OpaquePointer? = nil
        var data = [Post]()
        if (sqlite3_prepare_v2(database,"SELECT * from POSTS where POST_ID=?;",-1,&sqlite3_stmt,nil) == SQLITE_OK){
            sqlite3_bind_text(sqlite3_stmt, 1, postId.cString(using: .utf8),-1,nil);
            while(sqlite3_step(sqlite3_stmt) == SQLITE_ROW){
                let postId = String(cString:sqlite3_column_text(sqlite3_stmt,0)!);
                let postTitle = String(cString:sqlite3_column_text(sqlite3_stmt,1)!);
                let postSubject = String(cString:sqlite3_column_text(sqlite3_stmt,2)!);
                let meetingPlace = String(cString:sqlite3_column_text(sqlite3_stmt,3)!);
                let forumName = String(cString:sqlite3_column_text(sqlite3_stmt,4)!);
                let postOwnerUserEmail = String(cString:sqlite3_column_text(sqlite3_stmt,5)!);
                let participant1Email = String(cString:sqlite3_column_text(sqlite3_stmt,6)!);
                let participant2Email = String(cString:sqlite3_column_text(sqlite3_stmt,7)!);
                let participant3Email = String(cString:sqlite3_column_text(sqlite3_stmt,8)!);
                let participant4Email = String(cString:sqlite3_column_text(sqlite3_stmt,9)!);
                let participant5Email = String(cString:sqlite3_column_text(sqlite3_stmt,10)!);
                let participant1Status = String(cString:sqlite3_column_text(sqlite3_stmt,11)!);
                let participant2Status = String(cString:sqlite3_column_text(sqlite3_stmt,12)!);
                let participant3Status = String(cString:sqlite3_column_text(sqlite3_stmt,13)!);
                let participant4Status = String(cString:sqlite3_column_text(sqlite3_stmt,14)!);
                let participant5Status = String(cString:sqlite3_column_text(sqlite3_stmt,15)!);
                data.append(Post(postTitle: postTitle, postSubject: postSubject, meetingPlace: meetingPlace, forumName: forumName, postOwnerUserEmail: postOwnerUserEmail, participant1Email: participant1Email, participant2Email: participant2Email, participant3Email: participant3Email, participant4Email: participant4Email, participant5Email: participant5Email, participant1Status: participant1Status, participant2Status: participant2Status, participant3Status: participant3Status, participant4Status: participant4Status, participant5Status: participant5Status, postId: postId))
            }
        }
        sqlite3_finalize(sqlite3_stmt)
        if (data.count > 0){
            return data[0]
        }
        else {
            return nil
        }
    }
    
    func getAllForums()->[Forum] {
        var sqlite3_stmt: OpaquePointer? = nil
        var data = [Forum]()
        if (sqlite3_prepare_v2(database,"SELECT * from FORUMS;",-1,&sqlite3_stmt,nil) == SQLITE_OK){
            while(sqlite3_step(sqlite3_stmt) == SQLITE_ROW){
                let forumTopic = String(cString:sqlite3_column_text(sqlite3_stmt,0)!);
                let forumTopicAvatar = String(cString:sqlite3_column_text(sqlite3_stmt,1)!);
                data.append(Forum(forumTopic: forumTopic, forumTopicAvatar: forumTopicAvatar))
            }
        }
        sqlite3_finalize(sqlite3_stmt)
        return data
    }
    
    func getAllMeetingPlaces(meetPlaceTypeId:String)->[MeetPlace] {
        var sqlite3_stmt: OpaquePointer? = nil
        var data = [MeetPlace]()
        if (sqlite3_prepare_v2(database,"SELECT * from MEETPLACES where MEET_PLACE_TYPE_ID=?;",-1,&sqlite3_stmt,nil) == SQLITE_OK){
            sqlite3_bind_text(sqlite3_stmt, 1, meetPlaceTypeId.cString(using: .utf8),-1,nil);
            while(sqlite3_step(sqlite3_stmt) == SQLITE_ROW){
                let meetPlaceId = String(cString:sqlite3_column_text(sqlite3_stmt,0)!);
                let meetPlaceTypeId = String(cString:sqlite3_column_text(sqlite3_stmt,1)!);
                let name = String(cString:sqlite3_column_text(sqlite3_stmt,2)!);
                let city = String(cString:sqlite3_column_text(sqlite3_stmt,3)!);
                let address = String(cString:sqlite3_column_text(sqlite3_stmt,4)!);
                let image = String(cString:sqlite3_column_text(sqlite3_stmt,5)!);
                data.append(MeetPlace(name: name, meetPlaceTypeId: meetPlaceTypeId, address: address, city: city, image: image, meetPlaceId: meetPlaceId))
            }
        }
        sqlite3_finalize(sqlite3_stmt)
        return data
    }
    
    func getAllMeetingPlaceTypes()->[MeetPlaceType] {
        var sqlite3_stmt: OpaquePointer? = nil
        var data = [MeetPlaceType]()
        if (sqlite3_prepare_v2(database,"SELECT * from MEETPLACETYPES;",-1,&sqlite3_stmt,nil) == SQLITE_OK){
            while(sqlite3_step(sqlite3_stmt) == SQLITE_ROW){
                let typeId = String(cString:sqlite3_column_text(sqlite3_stmt,0)!);
                let type = String(cString:sqlite3_column_text(sqlite3_stmt,1)!);
                data.append(MeetPlaceType(type: type, typeId: typeId))
            }
        }
        sqlite3_finalize(sqlite3_stmt)
        return data
    }
    
    func getAllPosts(forumName:String)->[Post] {
        var sqlite3_stmt: OpaquePointer? = nil
        var data = [Post]()
        if (sqlite3_prepare_v2(database,"SELECT * from POSTS where FORUM_NAME=?;",-1,&sqlite3_stmt,nil) == SQLITE_OK){
            sqlite3_bind_text(sqlite3_stmt, 1, forumName,-1,nil);
            while(sqlite3_step(sqlite3_stmt) == SQLITE_ROW){
                let postId = String(cString:sqlite3_column_text(sqlite3_stmt,0)!);
                let postTitle = String(cString:sqlite3_column_text(sqlite3_stmt,1)!);
                let postSubject = String(cString:sqlite3_column_text(sqlite3_stmt,2)!);
                let meetingPlace = String(cString:sqlite3_column_text(sqlite3_stmt,3)!);
                let forumName = String(cString:sqlite3_column_text(sqlite3_stmt,4)!);
                let postOwnerUserEmail = String(cString:sqlite3_column_text(sqlite3_stmt,5)!);
                let participant1Email = String(cString:sqlite3_column_text(sqlite3_stmt,6)!);
                let participant2Email = String(cString:sqlite3_column_text(sqlite3_stmt,7)!);
                let participant3Email = String(cString:sqlite3_column_text(sqlite3_stmt,8)!);
                let participant4Email = String(cString:sqlite3_column_text(sqlite3_stmt,9)!);
                let participant5Email = String(cString:sqlite3_column_text(sqlite3_stmt,10)!);
                let participant1Status = String(cString:sqlite3_column_text(sqlite3_stmt,11)!);
                let participant2Status = String(cString:sqlite3_column_text(sqlite3_stmt,12)!);
                let participant3Status = String(cString:sqlite3_column_text(sqlite3_stmt,13)!);
                let participant4Status = String(cString:sqlite3_column_text(sqlite3_stmt,14)!);
                let participant5Status = String(cString:sqlite3_column_text(sqlite3_stmt,15)!);
                data.append(Post(postTitle: postTitle, postSubject: postSubject, meetingPlace: meetingPlace, forumName: forumName, postOwnerUserEmail: postOwnerUserEmail, participant1Email: participant1Email, participant2Email: participant2Email, participant3Email: participant3Email, participant4Email: participant4Email, participant5Email: participant5Email, participant1Status: participant1Status, participant2Status: participant2Status, participant3Status: participant3Status, participant4Status: participant4Status, participant5Status: participant5Status, postId: postId))
            }
        }
        sqlite3_finalize(sqlite3_stmt)
        return data
    }
    
    func getAllComments(postId:String)->[Comment] {
        var sqlite3_stmt: OpaquePointer? = nil
        var data = [Comment]()
        if (sqlite3_prepare_v2(database,"SELECT * from COMMENTS;",-1,&sqlite3_stmt,nil) == SQLITE_OK){
            sqlite3_bind_text(sqlite3_stmt, 1, postId,-1,nil);
            while(sqlite3_step(sqlite3_stmt) == SQLITE_ROW){
                let commentId = String(cString:sqlite3_column_text(sqlite3_stmt,0)!);
                let currentpostId = String(cString:sqlite3_column_text(sqlite3_stmt,1)!);
                let userEmail = String(cString:sqlite3_column_text(sqlite3_stmt,2)!);
                let userName = String(cString:sqlite3_column_text(sqlite3_stmt,3)!);
                let userProfession = String(cString:sqlite3_column_text(sqlite3_stmt,4)!);
                let comment = String(cString:sqlite3_column_text(sqlite3_stmt,5)!);
                if(postId == currentpostId) {
                    data.append(Comment(userEmail: userEmail, userName: userName, userProfession: userProfession, comment: comment, postId: postId, commentId: commentId))
                }
            }
        }
        sqlite3_finalize(sqlite3_stmt)
        return data
    }
}
