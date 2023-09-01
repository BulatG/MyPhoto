//
//  CasheManager.swift
//  MyPhoto
//
//  Created by Булат Габдуллин on 31.08.2023.
//

import UIKit

class CasheManager {
    
    static let shared = CasheManager()
    
    let imageCache = NSCache<NSString, UIImage>()
    
    init() {
        imageCache.totalCostLimit = 1_000_000_000
    }
    
    func getImageFromCashe(url: String) -> UIImage? {
        imageCache.object(forKey: url as NSString)
    }
    
    func casheImage(image: UIImage, url: String) {
        self.imageCache.setObject(image, forKey: url as NSString)
    }
    
}

