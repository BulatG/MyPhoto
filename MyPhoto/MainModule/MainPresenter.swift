//
//  MainPresenter.swift
//  MyPhoto
//
//  Created by Булат Габдуллин on 25.08.2023.
//

import Foundation

protocol ImageView: NSObjectProtocol {
    func setImages(_ images: Model)
    func startLoading()
    func finishLoading()
}

class MainPresenter {
    
    // MARK: - Proterties
    
    var task: URLSessionDataTask?
    
    weak fileprivate var imageView : ImageView?
    
    // MARK: - Public methods
    
    func attachView(_ view: ImageView){
        imageView = view
    }
    
    func dowonloadData() {
        self.imageView?.startLoading()
        NetworkManager.shared.fetchData { [weak self] model in
            print(model)
            self?.imageView?.finishLoading()
            self?.imageView?.setImages(model)
        }
    }
    
    func tableSorting(images: inout Model) {
        images.sort { $0.title < $1.title}
    }
    
}
