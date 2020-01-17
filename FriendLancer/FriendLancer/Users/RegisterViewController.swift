//
//  RegisterViewController.swift
//  FriendLancer
//
//  Created by yaniv hachmon on 15/01/2020.
//  Copyright © 2020 Nitzan & Inbar. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var professionTextField: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var caneclBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.isHidden = true

        // Do any additional setup after loading the view.
    }
    
    @IBAction func SaveBtnPressed(_ sender: Any) {
        spinner.isHidden = false
        caneclBtn.isEnabled = false
        if (emailTextField.text != "" && passwordTextField.text != "" && professionTextField.text != "" && NameTextField.text != "") {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authResult, error in
                        //there was a error
                       if let error = error {
                           print("error adding user: \(error)")
                            let alert = UIAlertController(title: "Error", message: "Can't add user!", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                  switch action.style{
                                  case .default:
                                        print("default")
                                        self.dismiss(animated: true, completion: nil)

                                  case .cancel:
                                        print("cancel")
                                        self.dismiss(animated: true, completion: nil)

                                  case .destructive:
                                        print("destructive")
                                        self.dismiss(animated: true, completion: nil)


                            }}))
                        self.spinner.isHidden = true
                        self.present(alert, animated: true, completion: nil)
                       }
                        //there wasn't an error, adding user
                       else {
                        print("adding user with email: \(self.emailTextField.text!)")
                        
                        Model.instance.add(user: User(email: self.emailTextField.text!.lowercased(), name: self.NameTextField.text!, profession: self.professionTextField.text!))
                        
                        let alert = UIAlertController(title: "Welcome!", message: "Added User!", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                              switch action.style{
                              case .default:
                                    print("default")
                                    self.dismiss(animated: true, completion: nil)

                              case .cancel:
                                    print("cancel")
                                    self.dismiss(animated: true, completion: nil)

                              case .destructive:
                                    print("destructive")
                                    self.dismiss(animated: true, completion: nil)


                        }}))
                        self.spinner.isHidden = true
                        self.present(alert, animated: true, completion: nil)
                       }
                   }
        }
        //can't add user because email/password don't exist
        else {
            let alert = UIAlertController(title: "Error", message: "Email/Password/Name/Profession are empty!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                  switch action.style{
                  case .default:
                        print("default")
                        self.dismiss(animated: true, completion: nil)
                        
                  case .cancel:
                        print("cancel")
                        self.dismiss(animated: true, completion: nil)
                    
                  case .destructive:
                        print("destructive")
                        self.dismiss(animated: true, completion: nil)


            }}))
            self.spinner.isHidden = true
            self.caneclBtn.isEnabled = true
            self.present(alert, animated: true, completion: nil)
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
