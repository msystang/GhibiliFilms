//
//  ProfileImagePersistence.swift
//  GhibliPractice
//
//  Created by Sunni Tang on 10/3/19.
//  Copyright © 2019 Iram Fattah. All rights reserved.
//

import Foundation

struct ProfileImagePersistenceHelper {
    private init() {}
    
    static let manager = ProfileImagePersistenceHelper()
    
    private let persistenceHelper = PersistenceHelper<ProfileImageInfo>(fileName: "profileImage.plist")
    
    func saveProfileImage(info: ProfileImageInfo) throws {
        try persistenceHelper.saveSingleObject(newElement: info)
    }
    
    func getProfileImage() throws -> ProfileImageInfo? {
        return try persistenceHelper.getSingleObject()
    }
    
}
