//
//  ProfileImagePersistence.swift
//  GhibliPractice
//
//  Created by C4Q on 10/2/19.
//  Copyright © 2019 Iram Fattah. All rights reserved.
//

import Foundation

struct ProfileImagePersistence {
    private init() {}
    
    static let manager = ProfileImagePersistence()
    
    private let persistenceHelper = PersistenceHelper<ProfileImageInfo>(fileName: "profileImage.plist")
    
    func saveProfileImage(info: ProfileImageInfo) throws {
        try persistenceHelper.saveSingleObject(newElement: info)
    }
    
    
    func getProfileImage() throws -> ProfileImageInfo {
        return try persistenceHelper.getSingleObject() ?? ProfileImageInfo(imageData: Data())
    }
}
