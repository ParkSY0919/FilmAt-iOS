//
//  Config.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/25/25.
//

import Foundation

enum Config {
    
    enum Keys {
        
        enum Plist {
            
            static let baseURL = "BASE_URL"
            
            static let accessToken = "ACCESS_TOKEN"
            
        }
        
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist cannot found !!!")
        }
        return dict
    }()
    
}


extension Config {
    
    static let baseURL: String = {
        guard let key = Config.infoDictionary[Keys.Plist.baseURL] as? String else {
            fatalError("BASE_URL is not set in plist for this configuration")
        }
        return key
    }()
    
    static let accessToken: String = {
        guard let key = Config.infoDictionary[Keys.Plist.accessToken] as? String else {
            fatalError("BASE_URL is not set in plist for this configuration")
        }
        return key
    }()
    
}

