//
//  NetworkMaanager.swift
//  MyPhoto
//
//  Created by Булат Габдуллин on 25.08.2023.
//

import Foundation



class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchData(completion: @escaping (Model) -> Void) {
        if let url = URL(string: "https://jsonplaceholder.typicode.com/photos") {
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Ошибка: \(error)")
                }
                
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        print("начало парсинга")
                        let items = try decoder.decode(Model.self, from: data)
                        completion(items)
                    } catch {
                        print("Ошибка парсинга JSON: \(error)")
                    }
                }
            }
            task.resume()
        }
        
    }
}
