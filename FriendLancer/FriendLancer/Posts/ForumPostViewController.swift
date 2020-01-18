//
//  PostViewController.swift
//  FriendLancer
//
//  Created by Studio on 10/01/2020.
//  Copyright © 2020 Nitzan & Inbar. All rights reserved.
//

import UIKit
import Firebase

class ForumPostViewController: UIViewController {
    
    var post:Post?
    var observer1:Any?;
    var observer2:Any?
    var observer3:Any?
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var coverLbl: UILabel!
    @IBOutlet weak var deletePostBtn: UIButton!
    
    @IBOutlet weak var postTitleLbl: UILabel!
    @IBOutlet weak var subjectLbl: UILabel!
    @IBOutlet weak var MeetingPlaceLbl: UILabel!
    @IBOutlet weak var arrivingBtn: UIButton!
    @IBOutlet weak var maybeArrivingBtn: UIButton!
    @IBOutlet weak var notArrivingBtn: UIButton!
    @IBOutlet weak var toCommentsBtn: UIButton!
    @IBOutlet weak var toCommentsArrow: UIImageView!
    @IBOutlet weak var editBtn: UIBarButtonItem!
    
    @IBOutlet weak var firstParticipantName: UILabel!
    @IBOutlet weak var secondParticipantName: UILabel!
    @IBOutlet weak var thirdParticipantName: UILabel!
    @IBOutlet weak var forthParticipantName: UILabel!
    @IBOutlet weak var fifthParticipantName: UILabel!
    
    @IBOutlet weak var firstParticipantProf: UILabel!
    @IBOutlet weak var secondParticipantProf: UILabel!
    @IBOutlet weak var thirdParticipantProf: UILabel!
    @IBOutlet weak var forthParticipantProf: UILabel!
    @IBOutlet weak var fifthParticipantProf: UILabel!
    
    @IBOutlet weak var firstParticipantQuestion: UIImageView!
    @IBOutlet weak var secondParticipantQuestion: UIImageView!
    @IBOutlet weak var thirdParticipantQuestion: UIImageView!
    @IBOutlet weak var forthParticipantQuestion: UIImageView!
    @IBOutlet weak var fifthParticipantQuestion: UIImageView!
    
    @IBOutlet weak var firstParticipantV: UIImageView!
    @IBOutlet weak var secondParticipantV: UIImageView!
    @IBOutlet weak var thirdParticipantV: UIImageView!
    @IBOutlet weak var forthParticipantV: UIImageView!
    @IBOutlet weak var fifthParticipantV: UIImageView!
    
    @IBOutlet weak var firstParticipantX: UIImageView!
    @IBOutlet weak var secondParticipantX: UIImageView!
    @IBOutlet weak var thirdParticipantX: UIImageView!
    @IBOutlet weak var forthParticipantX: UIImageView!
    @IBOutlet weak var fifthParticipantX: UIImageView!
    
    @IBOutlet weak var oneLbl: UILabel!
    @IBOutlet weak var twoLbl: UILabel!
    @IBOutlet weak var threeLbl: UILabel!
    @IBOutlet weak var fourLbl: UILabel!
    @IBOutlet weak var fiveLbl: UILabel!
    
    @IBOutlet weak var noParticipantsImage: UIImageView!
    
    func reloadData(){
        if (post != nil) {
            Model.instance.getPostById(callback: { (_data:Post?) in
                if(_data != nil) {
                    self.post = _data!
                    self.postTitleLbl.text = _data!.postTitle
                    self.subjectLbl.text = _data!.postSubject
                    self.MeetingPlaceLbl.text = _data!.meetingPlace
                    
                    self.setView()
                }
            }, postId: post!.postId)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
        setView()
        observer1 = ModelEvents.PostDataNotification.observe{
            self.reloadData();();
        }
        observer2 = ModelEvents.UserLoggedInDataNotification.observe {
            self.reloadData()
        }
        observer3 = ModelEvents.UserLoggedOutDataNotification.observe {
            self.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        reloadData()
        setView()
        observer1 = ModelEvents.PostDataNotification.observe{
            self.reloadData();();
        }
        observer2 = ModelEvents.UserLoggedInDataNotification.observe {
            self.reloadData()
        }
        observer3 = ModelEvents.UserLoggedOutDataNotification.observe {
            self.reloadData()
        }
    }
    
    func setView() {
        ifUserLoggedIn()
        
        //first participant
        firstParticipantQuestion.isHidden = true
        firstParticipantV.isHidden = true
        firstParticipantX.isHidden = true
        oneLbl.isHidden = true
        noParticipantsImage.isHidden = true
        
        if (post?.participant1Email != "") {
            Model.instance.getUserByEmail(callback: { (myUser:User?) in
                if(myUser != nil) {
                    self.firstParticipantName.text = myUser?.name
                    self.firstParticipantProf.text = myUser?.profession
                }
            }, email: post!.participant1Email)
            oneLbl.isHidden = false
            
            if (post?.participant1Status == "arriving") {
                firstParticipantV.isHidden = false
            }
            else if (post?.participant1Status == "not arriving") {
                firstParticipantX.isHidden = false
            }
            else {
                firstParticipantQuestion.isHidden = false
            }
        }

        //second participant
        secondParticipantQuestion.isHidden = true
        secondParticipantV.isHidden = true
        secondParticipantX.isHidden = true
        twoLbl.isHidden = true
        
        if (post?.participant2Email != "") {
            Model.instance.getUserByEmail(callback: { (myUser:User?) in
                if(myUser != nil) {
                    self.secondParticipantName.text = myUser?.name
                    self.secondParticipantProf.text = myUser?.profession
                }
            }, email: post!.participant2Email)
            twoLbl.isHidden = false
            
            if (post?.participant2Status == "arriving") {
                secondParticipantV.isHidden = false
            }
            else if (post?.participant2Status == "not arriving") {
                secondParticipantX.isHidden = false
            }
            else {
                secondParticipantQuestion.isHidden = false
            }
        }
        
        //third participant
        thirdParticipantQuestion.isHidden = true
        thirdParticipantV.isHidden = true
        thirdParticipantX.isHidden = true
        threeLbl.isHidden = true
        
        if (post?.participant3Email != "") {
            Model.instance.getUserByEmail(callback: { (myUser:User?) in
                if(myUser != nil) {
                    self.thirdParticipantName.text = myUser?.name
                    self.thirdParticipantProf.text = myUser?.profession
                }
            }, email: post!.participant3Email)
            threeLbl.isHidden = false
            
            if (post?.participant3Status == "arriving") {
                thirdParticipantV.isHidden = false
            }
            else if (post?.participant3Status == "not arriving") {
                thirdParticipantX.isHidden = false
            }
            else {
                thirdParticipantQuestion.isHidden = false
            }
        }
        
        //forth participant
        forthParticipantQuestion.isHidden = true
        forthParticipantV.isHidden = true
        forthParticipantX.isHidden = true
        fourLbl.isHidden = true
        
        if (post?.participant4Email != "") {
            Model.instance.getUserByEmail(callback: { (myUser:User?) in
                if(myUser != nil) {
                    self.forthParticipantName.text = myUser?.name
                    self.forthParticipantProf.text = myUser?.profession
                }
            }, email: post!.participant4Email)
            fourLbl.isHidden = false
            
            if (post?.participant4Status == "arriving") {
                forthParticipantV.isHidden = false
            }
            else if (post?.participant4Status == "not arriving") {
                forthParticipantX.isHidden = false
            }
            else {
                forthParticipantQuestion.isHidden = false
            }
        }
        
        //fifth participant
        fifthParticipantQuestion.isHidden = true
        fifthParticipantV.isHidden = true
        fifthParticipantX.isHidden = true
        fiveLbl.isHidden = true
        
        if (post?.participant5Email != "") {
            Model.instance.getUserByEmail(callback: { (myUser:User?) in
                if(myUser != nil) {
                    self.fifthParticipantName.text = myUser?.name
                    self.fifthParticipantProf.text = myUser?.profession
                }
            }, email: post!.participant5Email)
            fiveLbl.isHidden = false
            
            if (post?.participant5Status == "arriving") {
                fifthParticipantV.isHidden = false
            }
            else if (post?.participant5Status == "not arriving") {
                fifthParticipantX.isHidden = false
            }
            else {
                fifthParticipantQuestion.isHidden = false
            }
        }
        
        if (post?.participant1Email == "" && post?.participant2Email == "" && post?.participant3Email == "" && post?.participant4Email == "" && post?.participant5Email == "") {
            noParticipantsImage.isHidden = false
        }
    }
    
    func ifUserLoggedIn() {
        self.editBtn.isEnabled = false
        if (Auth.auth().currentUser != nil) {
            //user is logged in. check if it's admin
            let email = Auth.auth().currentUser?.email
            Model.instance.getUserByEmail(callback: { (myUser:User?) in
                if(myUser != nil) {
                    self.coverImage.isHidden = true
                    self.coverLbl.isHidden = true
                    
                    if (myUser?.email == self.post?.postOwnerUserEmail) {
                        self.editBtn.isEnabled = true
                        self.deletePostBtn.isEnabled = true
                        self.arrivingBtn.isEnabled = false
                        self.maybeArrivingBtn.isEnabled = false
                        self.notArrivingBtn.isEnabled = false
                    }
                    else {
                        self.editBtn.isEnabled = false
                        self.deletePostBtn.isEnabled = false
                        self.arrivingBtn.isEnabled = true
                        self.maybeArrivingBtn.isEnabled = true
                        self.notArrivingBtn.isEnabled = true
                    }
                }
            }, email: email!)
        }
        else {
            self.coverImage.isHidden = false
            self.coverLbl.isHidden = false
            self.editBtn.isEnabled = false
            self.deletePostBtn.isEnabled = false
        }
    }
    
    @IBAction func arrivingBtnPressed(_ sender: Any) {
        changeParticipants(status: "arriving")
    }
    
    @IBAction func MaybeArrivingBtnPressed(_ sender: Any) {
        changeParticipants(status: "maybe")
    }
    
    @IBAction func NotArrivingBtnPressed(_ sender: Any) {
        changeParticipants(status: "not arriving")
    }
    
    
    func changeParticipants(status:String) {
        let email = Auth.auth().currentUser?.email
        let postTitle = self.post!.postTitle
        let postSubject = self.post!.postSubject
        let meetingPlace = self.post!.meetingPlace
        let forumName = self.post!.forumName
        let postOwnerUserEmail = self.post!.postOwnerUserEmail
        let postId = self.post!.postId
        let participant1Email = self.post!.participant1Email
        let participant2Email = self.post!.participant2Email
        let participant3Email = self.post!.participant3Email
        let participant4Email = self.post!.participant4Email
        let participant5Email = self.post!.participant5Email
        let participant1Status = self.post!.participant1Status
        let participant2Status = self.post!.participant2Status
        let participant3Status = self.post!.participant3Status
        let participant4Status = self.post!.participant4Status
        let participant5Status = self.post!.participant5Status
        
        var flag:Int = 0
        if (email == participant1Email) {
            flag = 1
        }
        else if (email == participant2Email) {
            flag = 2
        }
        else if (email == participant3Email) {
            flag = 3
        }
        else if (email == participant4Email) {
            flag = 4
        }
        else if (email == participant5Email) {
            flag = 5
        }
        else if (participant1Email == "") {
            flag = 1
        }
        else if (participant2Email == "") {
            flag = 2
        }
        else if (participant3Email == "") {
            flag = 3
        }
        else if (participant4Email == "") {
            flag = 4
        }
        else if (participant5Email == "") {
            flag = 5
        }
         
        if (flag == 1) {
            let post = Post(postTitle: postTitle, postSubject: postSubject, meetingPlace: meetingPlace, forumName: forumName, postOwnerUserEmail: postOwnerUserEmail, participant1Email: email!, participant2Email: participant2Email, participant3Email: participant3Email, participant4Email:participant4Email, participant5Email: participant5Email, participant1Status: status, participant2Status: participant2Status, participant3Status: participant3Status, participant4Status: participant4Status, participant5Status: participant5Status, postId: postId)
            Model.instance.update(post: post)
        }
        else if (flag == 2) {
            let post = Post(postTitle: postTitle, postSubject: postSubject, meetingPlace: meetingPlace, forumName: forumName, postOwnerUserEmail: postOwnerUserEmail, participant1Email: participant1Email, participant2Email: email!, participant3Email: participant3Email, participant4Email:participant4Email, participant5Email: participant5Email, participant1Status: participant1Status, participant2Status: status, participant3Status: participant3Status, participant4Status: participant4Status, participant5Status: participant5Status, postId: postId)
            Model.instance.update(post: post)
        }
        else if (flag == 3) {
            let post = Post(postTitle: postTitle, postSubject: postSubject, meetingPlace: meetingPlace, forumName: forumName, postOwnerUserEmail: postOwnerUserEmail, participant1Email: participant1Email, participant2Email: participant2Email, participant3Email: email!, participant4Email:participant4Email, participant5Email: participant5Email, participant1Status: participant1Status, participant2Status: participant2Status, participant3Status: status, participant4Status: participant4Status, participant5Status: participant5Status, postId: postId)
            Model.instance.update(post: post)
        }
        else if (flag == 4) {
            let post = Post(postTitle: postTitle, postSubject: postSubject, meetingPlace: meetingPlace, forumName: forumName, postOwnerUserEmail: postOwnerUserEmail, participant1Email: participant1Email, participant2Email: participant2Email, participant3Email: participant3Email, participant4Email: email!, participant5Email: participant5Email, participant1Status: participant1Status, participant2Status: participant2Status, participant3Status: participant3Status, participant4Status: status, participant5Status: participant5Status, postId: postId)
            Model.instance.update(post: post)
        }
        else if (flag == 5) {
            let post = Post(postTitle: postTitle, postSubject: postSubject, meetingPlace: meetingPlace, forumName: forumName, postOwnerUserEmail: postOwnerUserEmail, participant1Email: participant1Email, participant2Email: participant2Email, participant3Email: participant3Email, participant4Email:participant4Email, participant5Email: email!, participant1Status: participant1Status, participant2Status: participant2Status, participant3Status: participant3Status, participant4Status: participant4Status, participant5Status: status, postId: postId)
            Model.instance.update(post: post)
        }
        else {
            let alert = UIAlertController(title: "Error", message: "You can't join the meeting, there are already five participants. Sorry!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    switch action.style{
                        case .default:
                            print("default")
                            self.dismiss(animated: true, completion: nil)

                        case .cancel:
                            print("cancel")
                            self.dismiss(animated: true, completion: nil)

                        case .destructive:
                            print("destructive")
                            self.dismiss(animated: true, completion: nil)
                    }}))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toCommentsSegue"){
            let vc:CommentsTableViewController = segue.destination as! CommentsTableViewController
            vc.post = self.post
        }
        if (segue.identifier == "toEditPostSegue") {
            let vc:EditPostViewController = segue.destination as! EditPostViewController
            vc.post = self.post
        }
    }
    
    @IBAction func deletePostBtnPressed(_ sender: Any) {
        Model.instance.delete(post: self.post!)
        self.navigationController?.popViewController(animated: true);
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
