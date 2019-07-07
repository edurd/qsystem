//
//  ClientDetailViewController.swift
//  Qsystem
//
//  Created by Eduardo Hoyos Loli on 7/7/19.
//  Copyright © 2019 Eduardo Hoyos Loli. All rights reserved.
//

import UIKit

class ClientDetailViewController: UITableViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastnameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var birthdateLabel: UILabel!
    var client : Client?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Cliente"
        if let client = client {
            nameLabel.text = client.name
            lastnameLabel.text = client.lastname
            ageLabel.text = "\(client.age)"
            birthdateLabel.text = client.birthdate
        }
        
    }
}
