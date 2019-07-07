//
//  RegisterClientViewController.swift
//  Qsystem
//
//  Created by Eduardo Hoyos Loli on 7/7/19.
//  Copyright © 2019 Eduardo Hoyos Loli. All rights reserved.
//

import UIKit
import FirebaseDatabase

class RegisterClientViewController: UITableViewController {
    
    let ref = Database.database().reference(withPath: "clients")
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var birthdateTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func addClientAction(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty else {
            AlertHelper.notificationAlert(title: "Alerta", message: "Ingrese un nombre para el cliente", viewController: self)
            return
        }
        guard let lastname = lastnameTextField.text, !lastname.isEmpty else {
            AlertHelper.notificationAlert(title: "Alerta", message: "Ingrese un apellido para el cliente", viewController: self)
            return
        }
        guard let age = ageTextField.text, !age.isEmpty else {
            AlertHelper.notificationAlert(title: "Alerta", message: "Ingrese la edad para el cliente", viewController: self)
            return
        }
        guard let birthdate = birthdateTextField.text, !birthdate.isEmpty else {
            AlertHelper.notificationAlert(title: "Alerta", message: "Ingrese la fecha de nacimiento", viewController: self)
            return
        }
        let clientRef = self.ref.childByAutoId()
        let client = Client(name: name,
                            lastname: lastname,
                            age: Int(age)!,
                            birthdate: birthdate,
                            key: clientRef.key!)
        clientRef.setValue(client.toAnyObject())
        let alertController = UIAlertController(title: "Éxito", message: "Se acaba de agregar al cliente.", preferredStyle: UIAlertController.Style.alert)
        let successAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(successAction)
        
        present(alertController, animated: true, completion:nil)
        
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func editDidBegin(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
    }
    
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        dateFormatter.timeStyle = DateFormatter.Style.none
        
        birthdateTextField.text = dateFormatter.string(from: sender.date)
    }
    
    
    
}
