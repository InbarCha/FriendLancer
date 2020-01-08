//
//  ForumPostCell.swift
//  FriendLancer
//
//  Created by Studio on 06/01/2020.
//  Copyright © 2020 Nitzan & Inbar. All rights reserved.
//

import UIKit

class ForumPostCell: UITableViewCell {
    
    @IBOutlet weak var actualSubjectLbk: UILabel!
    @IBOutlet weak var actualMeetingPlaceLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib();
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated);
    }
    
}
