//
//  ViewController.swift
//  FriendLancer
//
//  Created by Studio on 03/01/2020.
//  Copyright © 2020 Nitzan & Inbar. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var LogInBTN: UIButton!
    @IBOutlet weak var RegisterBTN: UIButton!
    @IBOutlet weak var ImageHome: UIImageView!
    @IBOutlet weak var enjoyImage: UIImageView!
    @IBOutlet weak var welcomeLbl: UILabel!
    @IBOutlet weak var logoutBtn: UIButton!
    
    var handle:AuthStateDidChangeListenerHandle?
    var observer1:Any?
    var observer2:Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observer1 = ModelEvents.UserLoggedInDataNotification.observe{
            self.userLoggedIn()
        }
        
        observer2 = ModelEvents.UserLoggedOutDataNotification.observe {
            self.userLoggedOut()
        }
        
        setView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setView()
    }

    func setView() {
        // Do any additional setup after loading the view.
        ImageHome.image = UIImage(named: "HomeImage")
        enjoyImage.image = UIImage(named: "EnjoyImage")
        
        if Auth.auth().currentUser != nil {
            //user is logged in
            userLoggedIn()
        } else {
            //no user is logged in
            userLoggedOut()
        }
    }
    
    func userLoggedIn() {
        LogInBTN.isHidden = true
        RegisterBTN.isHidden = true
        logoutBtn.isHidden = false
        let email = Auth.auth().currentUser?.email
        Model.instance.getUserByEmail(callback: { (myUser:User?) in
            if(myUser != nil) {
                self.welcomeLbl.text = "Welcome, " + String(myUser!.name)
            }
        }, email: email!)
    }
    
    func userLoggedOut() {
        LogInBTN.isHidden = false
        RegisterBTN.isHidden = false
        logoutBtn.isHidden = true
        welcomeLbl.text = ""
    }
    
    @IBAction func logoutBtnPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            ModelEvents.UserLoggedOutDataNotification.post()
        }
        catch {
            print("cannot log out")
        }
    }
    

}

