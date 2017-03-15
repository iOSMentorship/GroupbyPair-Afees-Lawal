//
//  UserCollectionViewCell.swift
//  group-us
//
//  Created by SimpuMind on 3/15/17.
//  Copyright © 2017 SimpuMind. All rights reserved.
//

import UIKit

class UserCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    var name: String?{
        didSet{
            usernameLabel.text = name
        }
    }
    
}
