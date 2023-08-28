//
//  ViewController.swift
//  MyPhoto
//
//  Created by Булат Габдуллин on 25.08.2023.
//

import SnapKit

class ViewController: UIViewController {    
    
    // MARK: - Properties
    
    private var tableManager = TableManager()
    
    var imageModel: Model = []
    
    var presenter: MainPresenter?
    
    // MARK: - Lifecycle
    
    init(presenter: MainPresenter) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = tableView as UIView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white        
        
        NetworkManager.shared.fetchData { model in
            DispatchQueue.main.async {
                self.imageModel = model
                self.tableManager.configureCells(model: self.imageModel)
                self.tableView.reloadData()
            }
        }
                
    }
    
    // MARK: - Public Methods

    
    // MARK: - Views
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = tableManager
        tableView.dataSource = tableManager
        tableView.register(MainPageCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        
        return tableView
    }()
    
}

//MARK: - Constants

private extension ViewController {
    enum Constants {
        static let cellIdentifier: String = "MainPageCell"
    }
}
