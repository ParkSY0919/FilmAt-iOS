//
//  BaseTargetType.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/25/25.
//

import Foundation

import Alamofire

protocol BaseTargetType: TargetType {
    
    var utilPath: String { get }
    
    var method: Alamofire.HTTPMethod { get }
    
}

extension BaseTargetType {
    
    var baseURL: URL {
        guard let urlString = Bundle.main.object(forInfoDictionaryKey: Config.Keys.Plist.baseURL) as? String,
              let url = URL(string: urlString) else {
            fatalError("🚨BASE_URL을 찾을 수 없습니다🚨")
        }
        return url
    }
    
    var headers: [String : String]? {
        let headers = ["Content-Type" : "application/json"]
        return headers
    }
    
}
