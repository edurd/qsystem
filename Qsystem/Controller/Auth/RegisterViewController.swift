//
//  RegisterViewController.swift
//  Qsystem
//
//  Created by Eduardo Hoyos Loli on 7/6/19.
//  Copyright © 2019 Eduardo Hoyos Loli. All rights reserved.
//

import UIKit
import SVProgressHUD
import FirebaseAuth

class RegisterViewController: UITableViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func registerAction(_ sender: Any) {
        guard let username = emailTextField.text, !username.isEmpty else {
            AlertHelper.notificationAlert(title: "Error", message: "Ingrese un usuario válido", viewController: self)
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            AlertHelper.notificationAlert(title: "Error", message: "Ingrese una contraseña válida", viewController: self)
            return
        }
        SVProgressHUD.setForegroundColor(UIColor.blue)
        SVProgressHUD.show()
        Auth.auth().createUser(withEmail: username, password: password) { authResult, error in
            SVProgressHUD.dismiss()
            if let error = error {
                AlertHelper.notificationAlert(title: "Error", message: "Error: \(error.localizedDescription)", viewController: self)
                return
            }
            
            let alertController = UIAlertController(title: "Éxito", message: "Usuario creado, ahora proceda a loguearse", preferredStyle: UIAlertController.Style.alert)
            let successAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                UIAlertAction in
                self.navigationController?.popViewController(animated: true)
            }
            
            alertController.addAction(successAction)
            
            self.present(alertController, animated: true, completion:nil)
        }
    }
}
