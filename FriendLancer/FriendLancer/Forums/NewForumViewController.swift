//
//  NewForumViewController.swift
//  FriendLancer
//
//  Created by Studio on 03/01/2020.
//  Copyright © 2020 Nitzan & Inbar. All rights reserved.
//

import UIKit

class NewForumViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate{

    @IBOutlet weak var ForumTopicNameInput: UITextField!
    @IBOutlet weak var ForumIcon: UIImageView!
    @IBOutlet weak var chooseIconBtn: UIButton!
    @IBOutlet weak var saveNewForumBtn: UIButton!
    
    var selectedForumIcon:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func Save(_ sender: Any) {
        let forum = Forum(id: "0", forumTopic: self.ForumTopicNameInput.text!, forumTopicAvatar:"");
                Model.instance.add(forum: forum);
                self.navigationController?.popViewController(animated: true);
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           selectedForumIcon = info[UIImagePickerController.InfoKey.originalImage] as? UIImage;
           self.ForumIcon.image = selectedForumIcon;
           dismiss(animated: true, completion: nil);
       }
    
    @IBAction func addIconFormGallery(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerController.SourceType.photoLibrary) {
           let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
           imagePicker.sourceType =
            UIImagePickerController.SourceType.photoLibrary;
           imagePicker.allowsEditing = true
           self.present(imagePicker, animated: true, completion: nil)
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
