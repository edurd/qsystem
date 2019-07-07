//
//  ClientViewController.swift
//  Qsystem
//
//  Created by Eduardo Hoyos Loli on 7/6/19.
//  Copyright © 2019 Eduardo Hoyos Loli. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ClientViewController: UITableViewController {
    
    var refArtists: DatabaseReference!
    var clients = [Client]()
    let ref = Database.database().reference(withPath: "clients")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref.observe(.value, with: { snapshot in
            var newItems: [Client] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let groceryItem = Client(snapshot: snapshot) {
                    newItems.append(groceryItem)
                }
            }
            
            self.clients = newItems.reversed()
            self.tableView.reloadData()
        })
        
    }
    
    @IBAction func addClientAction(_ sender: Any) {
        let stb = UIStoryboard(name: "Main", bundle: nil)
        let controller = stb.instantiateViewController(withIdentifier: "navControllerRegisterVC")
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        try! Auth.auth().signOut()
        UserDefaults.standard.removeObject(forKey: "uid")
        let stb = UIStoryboard(name: "Main", bundle: nil)
        let controller = stb.instantiateViewController(withIdentifier: "initVC")
        present(controller, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clients.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "clientID", for: indexPath) as! ClientTableViewCell
        cell.client = self.clients[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stb = UIStoryboard(name: "Main", bundle: nil)
        let controller = stb.instantiateViewController(withIdentifier: "clientDetailVC") as! ClientDetailViewController
        controller.client = self.clients[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
