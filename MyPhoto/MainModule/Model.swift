//
//  Model.swift
//  MyPhoto
//
//  Created by Булат Габдуллин on 25.08.2023.
//

import Foundation

struct ImageModel: Codable {
    let albumID, id: Int
    let title: String
    let url, thumbnailURL: String

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}

typealias Model = [ImageModel]
