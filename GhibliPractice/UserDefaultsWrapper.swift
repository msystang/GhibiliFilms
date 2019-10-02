//
//  UserDefaultsWrapper.swift
//  GhibliPractice
//
//  Created by C4Q on 10/2/19.
//  Copyright © 2019 Iram Fattah. All rights reserved.
//

import Foundation
class UserDefaultsWrapper {
    private init() {}
    static let shared = UserDefaultsWrapper()
    
    private let emailKey = "Email"
    private let passwordKey = "Password"
    
    func storeEmailAndPassword(email: String, password: String) {
        UserDefaults.standard.set(email, forKey: emailKey)
        UserDefaults.standard.set(password, forKey: passwordKey)
    }
    
    func getEmailAndPassword() -> (email:String?, pass:String?) {
        return (email: UserDefaults.standard.value(forKey: emailKey) as? String, pass: UserDefaults.standard.value(forKey: passwordKey) as? String)
    }
    
}
