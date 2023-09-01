//
//  TableViewManager.swift
//  MyPhoto
//
//  Created by Булат Габдуллин on 25.08.2023.
//

import UIKit

protocol ManageTableProtocol: UITableViewDelegate, UITableViewDataSource {
    
}

class TableManager:NSObject, ManageTableProtocol {
        
// MARK: - Properties
    
    var imageModel: Model = []
    
}


// MARK: - Public Methods

extension TableManager {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.indentifier, for: indexPath) as? MainPageCell else { return UITableViewCell() }

        cell.configure(with: imageModel[indexPath.row])

        return cell
    }
}


