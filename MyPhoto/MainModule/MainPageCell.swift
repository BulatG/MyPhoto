//
//  MainPageCell.swift
//  MyPhoto
//
//  Created by Булат Габдуллин on 25.08.2023.
//

import SnapKit

class MainPageCell: UITableViewCell {
    
    // MARK: - Properties
    
    var dataTask: URLSessionDataTask?
    
    
    let imageCache = NSCache<NSString, UIImage>()
    
    static var identifier: String {
        "\(type(of: self))"
    }
    
    private lazy var imageId: UILabel = {
      let label = UILabel()
        return label
    }()
    
    private lazy var imageName : UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var picture: UIImageView = {
        let view = UIImageView()
        return view
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
        dataTask?.cancel()
    }
    
    func configure(with model: ImageModel) {
        imageId.text = "\(model.id)"
        imageName.text = model.title
        
        guard let url = URL(string: model.url) else { return }
        loadImage(with: url)
        func loadImage(with url: URL) {
            if let cachedImage = imageCache.object(forKey: model.url as NSString) {
                // Используйте кешированную картинку
                picture.image = cachedImage
            } else {
                // Если картинки нет в кеше, загрузите ее
                dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let imageData = data, let image = UIImage(data: imageData) {
                        // Сохраните загруженную картинку в кеше
                        self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                        DispatchQueue.main.async {
                            // Установите картинку на UIImageView на главном потоке
                            self.picture.image = image
                        }
                    }
                }; dataTask?.resume()
            }
        }
        
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
    }
    
    func makeConstraints() {
        picture.snp.makeConstraints {
            $0.width.height.equalTo(75)
            $0.top.leading.top.bottom.equalTo(self.contentView).inset(5)
        }
        
        imageId.snp.makeConstraints {
            $0.top.equalTo(5)
            $0.leading.equalTo(picture.snp.trailing).offset(20)
            $0.height.equalTo(20)
            $0.trailing.equalTo(contentView.snp.trailing)
        }
        
        imageName.snp.makeConstraints {
            $0.top.equalTo(imageId.snp.bottom).offset(5)
            $0.leading.equalTo(picture.snp.trailing).offset(20)
            $0.trailing.equalTo(self.contentView).inset(5)
            $0.height.equalTo(20)
        }
    }
    
}

// MARK: - Constants



