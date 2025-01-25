//
//  TMDBTargetType.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/25/25.
//

import Foundation

import Alamofire

enum TMDBTargetType {
    
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
        switch self {
        }
    }
    
    var path: String {
        switch self {
        }
    }
    
    
    var parameters: RequestParams? {
        switch self {
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        }
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
