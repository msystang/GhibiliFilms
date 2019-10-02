//
//  FilmsPersistence.swift
//  GhibliPractice
//
//  Created by C4Q on 10/1/19.
//  Copyright © 2019 Iram Fattah. All rights reserved.
//

import Foundation
struct FilmsPersistenceManager {
    private init() {}
    static let manager = FilmsPersistenceManager()
    
    
       private let persistenceHelper = PersistenceHelper<Film>(fileName: "films.plist")
    
    
    func saveFilm(film: Film) throws {
        try persistenceHelper.save(newElement: film)
        
    }
    
    func getFilms() throws -> [Film] {
        return try persistenceHelper.getObjects()
    }
    
   
    
    
}
