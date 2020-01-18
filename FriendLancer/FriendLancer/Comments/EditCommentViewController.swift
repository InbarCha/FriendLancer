//
//  EditCommentViewController.swift
//  FriendLancer
//
//  Created by Studio on 12/01/2020.
//  Copyright © 2020 Nitzan & Inbar. All rights reserved.
//

import UIKit
import Firebase

class EditCommentViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var professionTextField: UITextField!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var deleteCommentBtn: UIButton!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var coverLbl: UILabel!
    
    var post:Post?
    var comment:Comment?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ifUserLoggedIn()
        
        nameTextField.text = comment?.userName
        professionTextField.text = comment?.userProfession
        commentTextField.text = comment?.comment
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        ifUserLoggedIn()
        
        nameTextField.text = comment?.userName
        professionTextField.text = comment?.userProfession
        commentTextField.text = comment?.comment
    }
    
    func ifUserLoggedIn() {
        if (Auth.auth().currentUser != nil) {
            let email = Auth.auth().currentUser?.email
            Model.instance.getUserByEmail(callback: { (myUser:User?) in
                if(myUser != nil) {
                    if (myUser?.email == self.comment?.userEmail) {
                        self.coverImage.isHidden = true
                        self.coverLbl.isHidden = true
                    }
                }
            }, email: email!)
        }
        else {
            self.coverImage.isHidden = false
            self.coverLbl.isHidden = false
        }
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        comment?.comment = commentTextField.text!
        comment?.userName = nameTextField.text!
        comment?.userProfession = professionTextField.text!
        
        Model.instance.update(comment:self.comment!)
        self.navigationController?.popViewController(animated: true);
    }
    
    @IBAction func deleteBtnPressed(_ sender: Any) {
        Model.instance.delete(comment: self.comment!)
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
