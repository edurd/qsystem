//
//  ClientTableViewCell.swift
//  Qsystem
//
//  Created by Eduardo Hoyos Loli on 7/7/19.
//  Copyright © 2019 Eduardo Hoyos Loli. All rights reserved.
//

import UIKit

class ClientTableViewCell: UITableViewCell {
    
    @IBOutlet weak var namesLabel: UILabel!
    @IBOutlet weak var birthDateLabel: UILabel!
    
    var client : Client? {
        didSet {
            if let client = client {
                namesLabel.text = client.name
                birthDateLabel.text = client.birthdate
            }
        }
    }
    
    override func awakeFromNib() {
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
    }
}
