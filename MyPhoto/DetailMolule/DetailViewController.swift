//
//  DetailViewController.swift
//  MyPhoto
//
//  Created by Булат Габдуллин on 28.08.2023.
//

import SnapKit

class DetailViewController: UIViewController {
    
    // MARK: - Prorerties
        
    var imageManager = ImageManager.shared
    
    // MARK: - Views
    
    private lazy var bigImage: UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .large
        spinner.center = view.center
        return spinner
    }()
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        self.view.backgroundColor = .white
    }
    
}

// MARK: - Public Methods

extension DetailViewController {
    func configure(with model: ImageModel) {
        bigImage.loadImage(url: model.url)
    }
}

// MARK: - Private Methods

private extension DetailViewController {
    
    func configureUI() {
        addSubviews()
        makeConstraints()
    }
    
    func addSubviews() {
        view.addSubview(bigImage)
        view.addSubview(spinner)
    }
    
    func makeConstraints() {
        bigImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(bigImage.snp.height)
            $0.width.equalToSuperview().multipliedBy(Constants.multiplier)
        }
        
        spinner.snp.makeConstraints {
            $0.bottom.equalTo(bigImage.snp.top)
            $0.centerX.equalToSuperview()
        }
    }
    
}

// MARK: - Constants

private extension DetailViewController {
    
    enum Constants {
        static let multiplier: Double = 0.9
    }
    
}
