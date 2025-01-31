//
//  ImageResponseModel.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/26/25.
//

import Foundation

// MARK: - ImageResponseModel
struct ImageResponseModel: Codable {
    let backdrops: [Backdrop]
    let id: Int
    let posters: [Backdrop]
}

// MARK: - Backdrop
struct Backdrop: Codable {
    let filePath: String?

    enum CodingKeys: String, CodingKey {
        case filePath = "file_path"
    }
}
