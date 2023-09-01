//
//  DetailPresenter .swift
//  MyPhoto
//
//  Created by Булат Габдуллин on 29.08.2023.
//

import Foundation

protocol DetailImageView: NSObjectProtocol {
    func setImage(_ images: Model)
    func startLoading()
    func finishLoading()
}

class DetailPresenter {
    
    // MARK: - Proterties
    
    let cacheManager = CasheManager.shared
    
    let imageManager = ImageManager.shared
        
    weak fileprivate var imageView : DetailImageView?
    
    // MARK: - Public methods
    
    func attachView(_ view: DetailImageView){
        imageView = view
    }    
    
}
