//
//  MyZoneViewController.swift
//  FriendLancer
//
//  Created by Studio on 03/01/2020.
//  Copyright © 2020 Nitzan & Inbar. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

class MyZoneViewController: UIViewController {

    @IBOutlet weak var MyImage: UIImageView!

    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var professionLbl: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var notLoggedInImg: UIImageView!
    @IBOutlet weak var emailValLbl: UILabel!
    @IBOutlet weak var nameValLbl: UILabel!
    @IBOutlet weak var professionValLbl: UILabel!
    @IBOutlet weak var loginInfoIcon: UIImageView!
    
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    var observer1:Any?
    var observer2:Any?
    var observer3:Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observer1 = ModelEvents.UserLoggedInDataNotification.observe{
            self.userLoggedIn()
        }
        
        observer2 = ModelEvents.UserLoggedOutDataNotification.observe {
            self.userLoggedOut()
        }
        
        observer3 = ModelEvents.UserDataNotification.observe {
            self.userLoggedIn()
        }

        if (Auth.auth().currentUser != nil) {
            //user is logged in
            userLoggedIn()
        } else {
            //no user is logged in
            userLoggedOut()
        }
    }
    
    func userLoggedIn() {
        notLoggedInImg.isHidden = true
        registerBtn.isHidden = true
        registerBtn.isEnabled = false
        loginBtn.isHidden = true
        loginBtn.isEnabled = false
        MyImage.isHidden = false
        emailLbl.isHidden = false
        emailValLbl.isHidden = false
        nameLbl.isHidden = false
        nameValLbl.isHidden = false
        professionLbl.isHidden = false
        professionValLbl.isHidden = false
        editBtn.isHidden = false
        editBtn.isEnabled = true
        loginInfoIcon.isHidden = false
        
        let email = Auth.auth().currentUser?.email
        emailValLbl.text = email
        Model.instance.getUserByEmail(callback: { (myUser:User?) in
            if(myUser != nil) {
                self.nameValLbl.text = myUser?.name
                self.professionValLbl.text = myUser?.profession
                if (myUser?.image != "") {
                    self.MyImage.kf.setImage(with: URL(string: myUser!.image))
                }
                else {
                    self.MyImage.image = UIImage(named: "avatar")
                }
            }
        }, email: email!)
        
    }
    
    func userLoggedOut() {
        notLoggedInImg.isHidden = false
        registerBtn.isHidden = false
        registerBtn.isEnabled = true
        loginBtn.isHidden = false
        loginBtn.isEnabled = true
        MyImage.isHidden = true
        emailLbl.isHidden = true
        emailValLbl.isHidden = true
        nameLbl.isHidden = true
        nameValLbl.isHidden = true
        professionValLbl.isHidden = true
        professionLbl.isHidden = true
        editBtn.isEnabled = false
        editBtn.isHidden = true
        loginInfoIcon.isHidden = true
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
