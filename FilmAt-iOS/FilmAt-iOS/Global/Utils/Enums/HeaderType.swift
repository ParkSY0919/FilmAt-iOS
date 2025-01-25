//
//  HeaderType.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/25/25.
//

import Foundation

enum HeaderType {
    
    static func headerWithAcceptToken(token: String) -> [String: String] {
        return ["accept": "application/json",
                "Content-Type" : "application/json",
                "Authorization" : "Bearer " + token]
    }
    
}
