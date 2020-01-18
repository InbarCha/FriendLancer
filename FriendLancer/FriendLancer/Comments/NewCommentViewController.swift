//
//  NewCommentViewController.swift
//  FriendLancer
//
//  Created by Studio on 12/01/2020.
//  Copyright © 2020 Nitzan & Inbar. All rights reserved.
//

import UIKit
import Firebase

class NewCommentViewController: UIViewController {
    
    var post:Post?

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var professionTextField: UITextField!
    @IBOutlet weak var CommentTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let email = Auth.auth().currentUser?.email
        Model.instance.getUserByEmail(callback: { (myUser:User?) in
            if(myUser != nil) {
                self.nameTextField.text = myUser?.name
                self.nameTextField.isEnabled = false
                
                self.professionTextField.text = myUser?.profession
                self.professionTextField.isEnabled = false
            }
        }, email: email!)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func SaveBtnPressed(_ sender: Any) {
        let comment = Comment(userEmail:(Auth.auth().currentUser?.email)!, userName: nameTextField.text!, userProfession: professionTextField.text!, comment: CommentTextField.text!, postId: post!.postId)
        Model.instance.add(comment: comment);
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
