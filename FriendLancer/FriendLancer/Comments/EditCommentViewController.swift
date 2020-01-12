//
//  EditCommentViewController.swift
//  FriendLancer
//
//  Created by Studio on 12/01/2020.
//  Copyright © 2020 Nitzan & Inbar. All rights reserved.
//

import UIKit

class EditCommentViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var professionTextField: UITextField!
    @IBOutlet weak var commentTextField: UITextField!
    
    var post:Post?
    var comment:Comment?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.text = comment?.userName
        professionTextField.text = comment?.userProfession
        commentTextField.text = comment?.comment
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        comment?.comment = commentTextField.text!
        comment?.userName = nameTextField.text!
        comment?.userProfession = professionTextField.text!
        
        Model.instance.update(comment:self.comment!)
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
