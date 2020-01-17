//
//  LoginViewController.swift
//  FriendLancer
//
//  Created by yaniv hachmon on 15/01/2020.
//  Copyright © 2020 Nitzan & Inbar. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var cancelBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.isHidden = true
    }
    
    @IBAction func LoginBtnPressed(_ sender: Any) {
        spinner.isHidden = false
        cancelBtn.isEnabled = false
        if (emailTextField.text != "" && passwordTextField.text != "") {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { [weak self] authResult, error in
                    guard let strongSelf = self else { return }
                if let error = error {
                    print("can't sign in!")
                    let alert = UIAlertController(title: "Alert", message: "Can't login, Email or Password are incorrect", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                          switch action.style{
                          case .default:
                                print("default")

                          case .cancel:
                                print("cancel")

                          case .destructive:
                                print("destructive")
                    }}))
                    self!.spinner.isHidden = true
                    self!.cancelBtn.isEnabled = true
                    self!.present(alert, animated: true, completion: nil)
                }
                else {
                    ModelEvents.UserLoggedInDataNotification.post()
                    let alert = UIAlertController(title: "Alert", message: "Logged In!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                          switch action.style{
                          case .default:
                                print("default")
                                self!.dismiss(animated: true, completion: nil)

                          case .cancel:
                                print("cancel")
                                self!.dismiss(animated: true, completion: nil)

                          case .destructive:
                                print("destructive")
                                self!.dismiss(animated: true, completion: nil)
                    }}))
                    self!.spinner.isHidden = true
                    self!.present(alert, animated: true, completion: nil)
                }
              // ...
            }
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
