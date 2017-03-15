//
//  UserInputCell.swift
//  group-us
//
//  Created by SimpuMind on 3/9/17.
//  Copyright © 2017 SimpuMind. All rights reserved.
//

import UIKit

class UserInputCell: UITableViewCell, UITextFieldDelegate {
    
    
    weak var delegate: UserInputCellDelegate?

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBAction func removeUser(_ sender: Any) {
        
        
    }
    
    @IBAction func didEndEditing(_ sender: UITextField) {
        delegate?.didUpdate(cell: self, string: sender.text)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
