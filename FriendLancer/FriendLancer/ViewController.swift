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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            
        }
        setView()
    }

    func setView() {
        // Do any additional setup after loading the view.
        ImageHome.image = UIImage(named: "HomeImage")
        enjoyImage.image = UIImage(named: "EnjoyImage")
        
        if Auth.auth().currentUser != nil {
            //user is logged in
            LogInBTN.isHidden = true
            RegisterBTN.isHidden = true
            logoutBtn.isHidden = false
            let email = Auth.auth().currentUser?.email
            Model.instance.getUserByEmail(callback: { (myUser:User?) in
                if(myUser != nil) {
                    self.welcomeLbl.text = "Welcome, " + String(myUser!.name)
                }
            }, email: email!)
        } else {
            //no user is logged in
            LogInBTN.isHidden = false
            RegisterBTN.isHidden = false
            logoutBtn.isHidden = true
        }
    }
    
    @IBAction func logoutBtnPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        }
        catch {
            print("cannot log out")
        }
    }
    

}

