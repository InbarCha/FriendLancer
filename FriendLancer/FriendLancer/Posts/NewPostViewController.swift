//
//  NewPostViewController.swift
//  FriendLancer
//
//  Created by Studio on 08/01/2020.
//  Copyright © 2020 Nitzan & Inbar. All rights reserved.
//

import UIKit
import Firebase

class NewPostViewController: UIViewController {

    @IBOutlet weak var postTitle: UITextField!
    @IBOutlet weak var postSubjectTextView: UITextView!
    @IBOutlet weak var meetingPlaceTextField: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    
    var forumTopic:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func Save(_ sender: Any) {
        let currentUserEmail = Auth.auth().currentUser?.email
        let post = Post(postTitle: self.postTitle.text!, postSubject: self.postSubjectTextView.text!, meetingPlace: self.meetingPlaceTextField.text!, forumName: self.forumTopic, postOwnerUserEmail: currentUserEmail!)
        Model.instance.add(post: post);
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
