//
//  FilterViewController.swift
//  MyPhoto
//
//  Created by Булат Габдуллин on 29.08.2023.
//

import Foundation
import UIKit

class FilterViewController: UIViewController {
    
    // MARK: - Views
    
    private lazy var filterLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
}

// MARK: - Private Methods

private extension FilterViewController {
    
    func ConfigureUI() {
        
    }
    
    func makeConstraints() {
        
    }
    
}
