//
//  ForumTopicsCell.swift
//  FriendLancer
//
//  Created by Studio on 03/01/2020.
//  Copyright © 2020 Nitzan & Inbar. All rights reserved.
//

import UIKit

class ForumTopicsCell: UITableViewCell {
    
    @IBOutlet weak var ForumTopicImage: UIImageView!
    @IBOutlet weak var ForumTopicLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib();
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated);
    }
    
}

