//
//  TMDBTargetType.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/25/25.
//

import Foundation

import Alamofire

enum TMDBTargetType {
    case getTrendingAPI(request: TrendingRequestModel)
    case getSearchAPI(request: SearchRequestModel)
    case getImageAPI(movieID: String)
    case getCreditAPI(movieID: String)
}

extension TMDBTargetType: TargetType {
    
    var baseURL: URL {
        guard let urlString = Bundle.main.object(forInfoDictionaryKey: Config.Keys.Plist.baseURL) as? String,
              let url = URL(string: urlString) else {
            fatalError("🚨BASE_URL을 찾을 수 없습니다🚨")
        }
        return url
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var utilPath: String {
        switch self {
        case .getTrendingAPI:
            return "/trending/movie/"
        case .getSearchAPI:
            return "/search/movie"
        case .getImageAPI, .getCreditAPI:
            return "/movie/"
        }
    }
    
    var path: String {
        switch self {
        case .getTrendingAPI:
            return "day"
        case .getSearchAPI:
            return ""
        case .getImageAPI(movieID: let movieID):
            return "\(movieID)/images"
        case .getCreditAPI(movieID: let movieID):
            return "\(movieID)/credits"
        }
    }
    
    var parameters: RequestParams? {
        switch self {
        case .getTrendingAPI(let request):
            return .query(request)
        case .getSearchAPI(let request):
            return .query(request)
        case .getImageAPI, .getCreditAPI:
            return .none
        }
    }
    
    var encoding: Alamofire.ParameterEncoding {
        return URLEncoding.default
    }
    
    var header: Alamofire.HTTPHeaders {
        guard let accessToken = Bundle.main.object(forInfoDictionaryKey: Config.Keys.Plist.accessToken) as? String
        else {
            fatalError("🚨BASE_URL을 찾을 수 없습니다🚨")
        }
        
        let header: HTTPHeaders = [
                .init(name: "Content-Type", value: "application/json"),
                .init(name: "Accept", value: "application/json"),
                .init(name: "Authorization", value: "Bearer " + accessToken)
            ]
        return header
    }
    
}
