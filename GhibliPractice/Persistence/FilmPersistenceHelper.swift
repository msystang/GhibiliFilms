//
//  FilmPersistenceHelper.swift
//  GhibliPractice
//
//  Created by Sunni Tang on 10/3/19.
//  Copyright © 2019 Iram Fattah. All rights reserved.
//

import Foundation

struct FilmPersistenceHelper {
    private init() {}
    
    static let manager = FilmPersistenceHelper()
    
    private let persistenceHelper = PersistenceHelper<Film>(fileName: "films.plist")
    
    func saveFilm(film: Film) throws {
        try persistenceHelper.save(newElement: film)
    }
    
    func getFilms() throws -> [Film] {
        return try persistenceHelper.getObjects()
    }
    
}
