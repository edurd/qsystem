//
//  ViewController.swift
//  Qsystem
//
//  Created by Eduardo Hoyos Loli on 7/6/19.
//  Copyright © 2019 Eduardo Hoyos Loli. All rights reserved.
//

import UIKit
import SVProgressHUD
import FirebaseAuth
import FacebookCore
import FacebookLogin

class LoginViewController: UITableViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var facebookButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        facebookButton.addTarget(self, action: #selector(facebookLoginAction), for: .touchUpInside)
        if let uid = UserDefaults.standard.object(forKey: "uid") {
            let stb = UIStoryboard(name: "Main", bundle: nil)
            let controller = stb.instantiateViewController(withIdentifier:"navVC")
            self.present(controller, animated: true, completion: nil)
        }
    }
    

    @IBAction func loginAction(_ sender: Any) {
        guard let email = usernameTextField.text, !email.isEmpty else {
            AlertHelper.notificationAlert(title: "Error", message: "Ingrese un email válido", viewController: self)
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            AlertHelper.notificationAlert(title: "Error", message: "Ingrese una contraseña válida", viewController: self)
            return
        }
        SVProgressHUD.setForegroundColor(UIColor.blue)
        SVProgressHUD.show()
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
            SVProgressHUD.dismiss()
            guard let strongSelf = self else { return }
            
            if let user = user {
                let uid = user.user.uid
                let email = user.user.email
                let photoURL = user.user.photoURL
                UserDefaults.standard.setValue(uid, forKey: "uid")
                UserDefaults.standard.synchronize()
                let stb = UIStoryboard(name: "Main", bundle: nil)
                let controller = stb.instantiateViewController(withIdentifier:"navVC")
                self?.present(controller, animated: true, completion: nil)
            } else {
                AlertHelper.notificationAlert(title: "Error", message: "Ocurrió un error al hacer login", viewController: self!)
            }
        }
    }
    
    @objc func facebookLoginAction() {
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [ .publicProfile ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("Login cancelado.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in!")
                let uid = accessToken.userId
                UserDefaults.standard.setValue(uid, forKey: "uid")
                UserDefaults.standard.synchronize()
                let stb = UIStoryboard(name: "Main", bundle: nil)
                let controller = stb.instantiateViewController(withIdentifier:"navVC")
                self.present(controller, animated: true, completion: nil)
            }
        }
    }
    
}

