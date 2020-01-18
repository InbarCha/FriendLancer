//
//  MeetPlaceViewController.swift
//  FriendLancer
//
//  Created by Studio on 12/01/2020.
//  Copyright © 2020 Nitzan & Inbar. All rights reserved.
//

import UIKit

class NewMeetPlaceViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var meetPlaceImage: UIImageView!
    @IBOutlet weak var chooseBtn: UIButton!
    
    var selectedMeetPlaceImage:UIImage?
    var meetPlaceType:MeetPlaceType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.isHidden = true
        saveBtn.isEnabled = true
        chooseBtn.isEnabled = true

        // Do any additional setup after loading the view.
    }
    
    @IBAction func choosePic(_ sender: Any) {
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        selectedMeetPlaceImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage;
        self.meetPlaceImage.image = selectedMeetPlaceImage;
        dismiss(animated: true, completion: nil);
    }
    
    @IBAction func Save(_ sender: Any) {
        spinner.isHidden = false
        saveBtn.isEnabled = false
        chooseBtn.isEnabled = false
        if let image = selectedMeetPlaceImage {
            Model.instance.saveImage(image: image) { (url) in
                print("saved image url \(url)")
                
                let meetPlace = MeetPlace(name: self.nameTextField.text!, meetPlaceTypeId: self.meetPlaceType!.typeId, address: self.addressTextField.text!, city: self.cityTextField.text!, image: url)
                Model.instance.add(meetPlace: meetPlace);
                self.navigationController?.popViewController(animated: true);
            }
        }
        else {
            Model.instance.saveImage(image: UIImage(named:"avatar")!) { (url) in
                print("saved image url \(url)")
                           
                let meetPlace = MeetPlace(name: self.nameTextField.text!, meetPlaceTypeId: self.meetPlaceType!.typeId, address: self.addressTextField.text!, city: self.cityTextField.text!, image: url)
                Model.instance.add(meetPlace: meetPlace);
                self.navigationController?.popViewController(animated: true);
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
