//
//  UIImageExtension.swift
//  MyPhoto
//
//  Created by Булат Габдуллин on 01.09.2023.
//

import UIKit

extension UIImageView {
    
    func loadImage(url: String) {
        guard let newURL = URL(string: url) else { return }
        loadImage(url: newURL)
    }
    
    func loadImage(url: URL) {
        if let image = CasheManager.shared.getImageFromCashe(url: url.absoluteString)
        {
            self.image = image
        } else {
            ImageManager.shared.fetchImage(url: url, imageView: self)
        }
    }
}
