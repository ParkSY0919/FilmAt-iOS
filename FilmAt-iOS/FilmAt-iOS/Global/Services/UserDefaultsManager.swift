//
//  UserDefaultsManager.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/25/25.
//

import Foundation

final class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    private init() {}
    
    var isNotFirstLoading: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isNotFirstLoading")
        }
        set {
            return UserDefaults.standard.set(newValue, forKey: "isNotFirstLoading")
        }
    }
    
}
