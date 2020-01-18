//
//  EditPostViewController.swift
//  FriendLancer
//
//  Created by Studio on 12/01/2020.
//  Copyright © 2020 Nitzan & Inbar. All rights reserved.
//

import UIKit

class EditPostViewController: UIViewController {

    var post:Post?
    
    @IBOutlet weak var postTitleTextField: UITextField!
    @IBOutlet weak var postSubjectTextView: UITextView!
    @IBOutlet weak var meetingPlaceTextField: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var saveBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.isHidden = true
        saveBtn.isEnabled = true
        
        postTitleTextField.text = post?.postTitle
        postSubjectTextView.text = post?.postSubject
        meetingPlaceTextField.text = post?.meetingPlace
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        spinner.isHidden = false
        saveBtn.isEnabled = false
        post?.postTitle = postTitleTextField.text!
        post?.postSubject = postSubjectTextView.text!
        post?.meetingPlace = meetingPlaceTextField.text!
        
        Model.instance.update(post:self.post!)
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
