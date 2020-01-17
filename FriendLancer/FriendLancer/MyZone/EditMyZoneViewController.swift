//
//  EditMyZoneViewController.swift
//  FriendLancer
//
//  Created by yaniv hachmon on 17/01/2020.
//  Copyright © 2020 Nitzan & Inbar. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

class EditMyZoneViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var chooseImageBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var emailValLbl: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var professionTextField: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var cancelBtn: UIButton!
    
    var selectedImage:UIImage?
    var currentUser:User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.isHidden = true
        saveBtn.isEnabled = true
        chooseImageBtn.isEnabled = true
        cancelBtn.isEnabled = true
        
        let email = Auth.auth().currentUser?.email
        emailValLbl.text = email
        Model.instance.getUserByEmail(callback: { (myUser:User?) in
            if(myUser != nil) {
                self.currentUser = myUser
                self.nameTextField.text = myUser?.name
                self.professionTextField.text = myUser?.profession
                
                if (myUser?.image != "") {
                    self.myImage.kf.setImage(with: URL(string: myUser!.image))
                }
                else {
                    self.myImage.image = UIImage(named: "avatar")
                }
            }
        }, email: email!)
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        spinner.isHidden = false
        saveBtn.isEnabled = false
        chooseImageBtn.isEnabled = false
        cancelBtn.isEnabled = false
        if let image = selectedImage {
            Model.instance.saveImage(image: image) { (url) in
                print("saved image url \(url)")
                
                let user = User(email: self.emailValLbl.text!, name: self.nameTextField.text!, profession: self.professionTextField.text!, image: url)
                Model.instance.update(user: user);
                self.dismiss(animated: true, completion: nil)
            }
        }
        else {
            let user = User(email: self.emailValLbl.text!, name: self.nameTextField.text!, profession: self.professionTextField.text!, image: currentUser!.image)
            Model.instance.update(user: user);
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage;
        self.myImage.image = selectedImage;
        dismiss(animated: true, completion: nil);
    }
    
    @IBAction func chooseImage(_ sender: Any) {
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
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
