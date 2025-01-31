//
//  TrendingResponseModel.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/26/25.
//

import Foundation

// MARK: - TrendingResponseModel
struct TrendingResponseModel: Codable {
    let page: Int
    let results: [TrendingResult]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - TrendingResult
struct TrendingResult: Codable {
    let backdropPath, posterPath: String?
    let id: Int
    let title, originalTitle, overview: String
    let mediaType: MediaType
    let adult: Bool
    let originalLanguage: String
    let genreIDS: [Int]?
    let popularity: Double?
    let releaseDate: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id, title
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case adult
        case originalLanguage = "original_language"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
}

