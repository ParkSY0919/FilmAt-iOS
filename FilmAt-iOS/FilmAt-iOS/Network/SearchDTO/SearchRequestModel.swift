//
//  SearchRequestModel.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/26/25.
//

import Foundation

// MARK: - SearchRequestModel
struct SearchRequestModel: Encodable {
    let query: String
    let language: String = "ko-KR"
}
