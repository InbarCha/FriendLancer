//
//  PostViewController.swift
//  FriendLancer
//
//  Created by Studio on 10/01/2020.
//  Copyright © 2020 Nitzan & Inbar. All rights reserved.
//

import UIKit

class ForumPostViewController: UIViewController {
    
    var post:Post?

    
    @IBOutlet weak var postTitleLbl: UILabel!
    @IBOutlet weak var subjectLbl: UILabel!
    @IBOutlet weak var MeetingPlaceLbl: UILabel!
    @IBOutlet weak var arrivingBtn: UIButton!
    @IBOutlet weak var maybeArrivingBtn: UIButton!
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.postTitleLbl.text = post?.postTitle
        self.subjectLbl.text = post?.postSubject
        self.MeetingPlaceLbl.text = post?.meetingPlace
        
        //first participant
        firstParticipantQuestion.isHidden = true
        firstParticipantV.isHidden = true
        firstParticipantX.isHidden = true
        oneLbl.isHidden = true
        
        if (post?.participant1Name != "") {
            firstParticipantName.text = post?.participant1Name
            firstParticipantProf.text = post?.participant1Prof
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
        
        if (post?.participant2Name != "") {
            secondParticipantName.text = post?.participant2Name
            secondParticipantProf.text = post?.participant2Prof
            twoLbl.isHidden = true
            
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
        
        if (post?.participant3Name != "") {
            thirdParticipantName.text = post?.participant3Name
            thirdParticipantProf.text = post?.participant3Prof
            threeLbl.isHidden = true
            
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
        
        if (post?.participant4Name != "") {
            forthParticipantName.text = post?.participant4Name
            forthParticipantProf.text = post?.participant4Prof
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
        
        if (post?.participant5Name != "") {
            fifthParticipantName.text = post?.participant5Name
            fifthParticipantProf.text = post?.participant5Prof
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
