//
//  FilmAPIClient.swift
//  GhibliPractice
//
//  Created by C4Q on 10/2/19.
//  Copyright © 2019 Iram Fattah. All rights reserved.
//

import Foundation
class FilmAPIClient {
    private init () {}
    
    static let shared = FilmAPIClient()
    
    func getFilms(completionHandler: @escaping (Result<[Film], AppError>) -> ()) {
        let urlStr = "https://ghibliapi.herokuapp.com/films"
        
        guard let url = URL(string: urlStr) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result {
            case .failure(let error) :
                completionHandler(.failure(error))
            case .success(let data):
                do {
                let films = try JSONDecoder().decode([Film].self, from: data)
                completionHandler(.success(films))
                } catch {
                    print(error)
                    completionHandler(.failure(.other(rawError: error)))
                }
            }
        }
        
        
    }
}
