//
//  UserDefaultsWrapper.swift
//  GhibliPractice
//
//  Created by Sunni Tang on 10/3/19.
//  Copyright © 2019 Iram Fattah. All rights reserved.
//

import Foundation

struct UserDefaultsWrapper {
    private init() {}
    
    static let manager = UserDefaultsWrapper()
    
    private let emailKey = "email"
    private let passwordKey = "password"
    
    func storeLoginInfo(email: String, password: String) {
        UserDefaults.standard.set(email, forKey: emailKey)
        UserDefaults.standard.set(password, forKey: passwordKey)
    }
    
    func getLoginInfo() -> (email: String?, password: String?) {
        let storedEmail = UserDefaults.standard.value(forKey: emailKey) as? String
        let storedPassword = UserDefaults.standard.value(forKey: passwordKey) as? String
        return (email: storedEmail, password: storedPassword)
    }
    
}
