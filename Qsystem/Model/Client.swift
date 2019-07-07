//
//  Client.swift
//  Qsystem
//
//  Created by Eduardo Hoyos Loli on 7/7/19.
//  Copyright © 2019 Eduardo Hoyos Loli. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Client {
    var ref : DatabaseReference?
    var key : String
    var name : String
    var lastname : String
    var age : Int
    var birthdate : String
    
    init(name: String, lastname : String, age : Int, birthdate : String, key : String = "") {
        self.ref = nil
        self.name = name
        self.lastname = lastname
        self.age = age
        self.birthdate = birthdate
        self.key = key
    }
    
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let name = value["name"] as? String,
            let lastname = value["lastname"] as? String,
            let age = value["age"] as? Int,
            let birthdate = value["birthdate"] as? String else {
                return nil
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.name = name
        self.lastname = lastname
        self.age = age
        self.birthdate = birthdate
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "lastname": lastname,
            "age": age,
            "birthdate" : birthdate,
            "key" : key
        ]
    }
}
