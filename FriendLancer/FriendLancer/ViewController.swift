//
//  ViewController.swift
//  FriendLancer
//
//  Created by Studio on 03/01/2020.
//  Copyright © 2020 Nitzan & Inbar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var LogInBTN: UIButton!
    
    @IBOutlet weak var RegisterBTN: UIButton!
    
    @IBOutlet weak var ImageHome: UIImageView!
    
    @IBOutlet weak var enjoyImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ImageHome.image = UIImage(named: "HomeImage")
        enjoyImage.image = UIImage(named: "EnjoyImage")
    }


}

