//
//  MainPageCell.swift
//  MyPhoto
//
//  Created by Булат Габдуллин on 25.08.2023.
//

import SnapKit

class MainPageCell: UITableViewCell {
    
    // MARK: - Properties
    
    let cacheManager = CasheManager.shared
    
    let imageManager = ImageManager.shared
    
    // MARK: - Views
    
    private lazy var imageId: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var imageName : UILabel = {
        let label = UILabel()
        label.numberOfLines = Constants.numberOfLines
        label.textAlignment = .natural
        
        return label
    }()
    
    private lazy var picture: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private lazy var spiner: UIActivityIndicatorView = {
        let spiner = UIActivityIndicatorView()
        spiner.style = .medium
        
        return spiner
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Public Methods

extension MainPageCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        picture.image = nil
    }
    
    func configure(with model: ImageModel) {
        imageId.text = "\(model.id)"
        imageName.text = model.title
        
        guard let url = URL(string: model.thumbnailURL) else { return }
        picture.loadImage(url: url)
    }
    
}

// MARK: - Private Methods

private extension MainPageCell {
    
    func configureUI() {
        addSubviews()
        makeConstraints()
        
    }
    
    func addSubviews() {
        contentView.addSubview(picture)
        contentView.addSubview(imageId)
        contentView.addSubview(imageName)
        contentView.addSubview(spiner)
    }
    
    func makeConstraints() {
        picture.snp.makeConstraints {
            $0.width.height.equalTo(Constants.pictureSize)
            $0.top.leading.bottom.equalTo(self.contentView).inset(Constants.standartConstant)
        }
        
        imageId.snp.makeConstraints {
            $0.top.equalTo(Constants.standartConstant)
            $0.leading.equalTo(picture.snp.trailing).offset(Constants.standardSpasing)
            $0.height.equalTo(Constants.standardSpasing)
            $0.trailing.equalTo(contentView.snp.trailing)
        }
        
        imageName.snp.makeConstraints {
            $0.top.equalTo(imageId.snp.bottom).offset(Constants.standartConstant)
            $0.leading.equalTo(picture.snp.trailing).offset(Constants.standardSpasing)
            $0.trailing.equalTo(self.contentView).inset(Constants.standartConstant)
            $0.bottom.equalTo(self.contentView).inset(Constants.standartConstant)
        }
        
        spiner.snp.makeConstraints {
            $0.center.equalTo(picture.snp.center)
        }
        
    }
    
}

// MARK: - Constants

private extension MainPageCell {
    enum Constants {
        static let numberOfLines: Int = 0
        static let pictureSize: Int = 75
        static let standartConstant: Int = 5
        static let standardSpasing: Int = 20
    }
}

