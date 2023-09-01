//
//  ViewController.swift
//  MyPhoto
//
//  Created by Булат Габдуллин on 25.08.2023.
//

import SnapKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Properties
    
    fileprivate var imageModel: Model = []
    
    var presenter = MainPresenter()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = barButtonItem
        
        print(view.center)
        
        tableView.addSubview(activityIndicator)
        
        self.presenter.attachView(self)
        self.presenter.dowonloadData()
        
    }
    
    // MARK: - Views
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.frame)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainPageCell.self, forCellReuseIdentifier: Constants.identifier)
        
        return tableView
    }()
    
    private lazy var barButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(image: .actions, style: .done, target: self, action: #selector(self.sortTable))
        
        return item
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.center = self.view.center
        
        return indicator
    }()
    
}

// MARK: - Public Methods

extension ViewController: ImageView {
    
    func startLoading() {
        self.activityIndicator.startAnimating()
    }
    
    func finishLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
        
    }
    
    func setImages(_ images: Model) {
        self.imageModel = images
        DispatchQueue.main.async {
            
            self.tableView.reloadData()
        }
    }
    
    @objc func sortTable() {
        presenter.tableSorting(images: &imageModel)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = DetailViewController()
        viewController.configure(with: imageModel[indexPath.row])
        self.navigationController?.pushViewController(viewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        imageModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.identifier, for: indexPath) as? MainPageCell else { return UITableViewCell() }
        
        cell.configure(with: imageModel[indexPath.row])
        
        return cell
    }
    
}

//MARK: - Constants

private extension ViewController {
    enum Constants {
        static let identifier: String = "MainPageCell"
    }
}
