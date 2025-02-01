//
//  LoadImageType.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/31/25.
//

import Foundation

enum LoadImageType {
    case thumb
    case backdrop
    case cast
    case poster
    case original
    
    var pathUrl: String {
        switch self {
        case .thumb:
            return "https://image.tmdb.org/t/p/w342"
        case .backdrop:
            return "https://image.tmdb.org/t/p/w780"
        case .cast:
            return "https://image.tmdb.org/t/p/w92"
        case .poster:
            return "https://image.tmdb.org/t/p/w185"
        case .original:
            return "https://image.tmdb.org/t/p/original"
        }
    }
}
