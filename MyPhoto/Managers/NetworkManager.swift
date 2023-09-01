//
//  NetworkMaanager.swift
//  MyPhoto
//
//  Created by Булат Габдуллин on 25.08.2023.
//

import Foundation

class NetworkManager {
    
    // MARK: - Properties
        
    static let shared = NetworkManager()
    
    // MARK: - Public methods
    
    func fetchData(completion: @escaping (Model) -> Void) {
        if let url = URL(string: Constants.url) {
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("\(Constants.error): \(error)")
                }
                
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        
                        let items = try decoder.decode(Model.self, from: data)
                        DispatchQueue.main.async {
                            completion(items)
                        }
                    } catch {
                        print("\(Constants.parsingError) \(error)")
                    }
                }
            }
            task.resume()
        }
        
    }
    
}

// MARK:- Constants

private extension NetworkManager {
    enum Constants {
        static let url: String = "https://jsonplaceholder.typicode.com/photos"
        static let parsingError: String = "Ошибка парсинга JSON:"
        static let error: String = "Ошибка"
    }
}
