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

    @IBOutlet weak var BannerImage: UIImageView!
    @IBOutlet weak var ForumTopicNameInput: UITextField!
    @IBOutlet weak var ForumIcon: UIImageView!
    @IBOutlet weak var chooseIconBtn: UIButton!
    @IBOutlet weak var saveNewForumBtn: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var selectedForumIcon:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BannerImage.image = UIImage(named: "NewForumBannerImage2")
        ForumIcon.image = UIImage(named:"avatar")
        spinner.isHidden = true
        saveNewForumBtn.isEnabled = true
    }
    
    
    @IBAction func Save(_ sender: Any) {
        spinner.isHidden = false
        saveNewForumBtn.isEnabled = false
        if let image = selectedForumIcon {
            Model.instance.saveImage(image: image) { (url) in
                print("saved image url \(url)")
                
                let forum = Forum(forumTopic: self.ForumTopicNameInput.text!, forumTopicAvatar:url);
                Model.instance.add(forum: forum);
                self.navigationController?.popViewController(animated: true);
            }
        }
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
