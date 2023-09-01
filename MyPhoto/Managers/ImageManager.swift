//
//  ImageManager.swift
//  MyPhoto
//
//  Created by Булат Габдуллин on 30.08.2023.
//

import Foundation
import UIKit

private class WeakObject<T: AnyObject> {
    weak var value: T?
    
    init(value: T) {
        self.value = value
    }
}

class ImageManager {
    
    private let queue = DispatchQueue(label: Constants.queueLabel, qos: .userInitiated)
    
    let lock = NSLock()
    
    private var imageUrlStorage: [(URL): [WeakObject<UIImageView>]] = [:]
    
    private var urlsInProgress: Set<URL> = []
    
    static let shared = ImageManager()
    
    func fetchImage(url: URL, imageView: UIImageView) {
        queue.async {
            self.lock.lock()
            if self.imageUrlStorage[url] == nil {
                self.imageUrlStorage[url] = []
            }
            guard !self.urlsInProgress.contains(url) else {
                if let index = self.imageUrlStorage[url]?.firstIndex(where: { $0.value === imageView }) {
                    self.imageUrlStorage[url]?[index] = .init(value: imageView)
                } else {
                    self.imageUrlStorage[url]?.append(.init(value: imageView))
                }
                return
            }
            self.urlsInProgress.forEach() { url in
                self.imageUrlStorage[url]!.removeAll(where: { $0.value === imageView })
            }
            self.urlsInProgress.insert(url)
            
            self.imageUrlStorage[url]?.append(.init(value: imageView))
            self.lock.unlock()
            let session = URLSession.shared
            let task = session.dataTask(with: url) { (data, response, error) in
                if let imageData = data, let image = UIImage(data: imageData) {
                    self.lock.lock()
                    CasheManager.shared.casheImage(image: image, url: url.absoluteString)
                    self.urlsInProgress.remove(url)
                    self.lock.unlock()
                    DispatchQueue.main.async {
                        self.lock.lock()
                        self.imageUrlStorage[url]?.forEach {
                            $0.value?.image = image
                        }
                        self.imageUrlStorage[url] = nil
                        self.lock.unlock()
                    }
                    
                } 
            }
            task.resume()
        }
    }
    
}

extension ImageManager {
    enum Constants {
        static let queueLabel: String = "queue"
    }
}
