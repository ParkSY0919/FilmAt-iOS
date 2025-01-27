//
//  UserDefaultsManager.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/25/25.
//

import UIKit

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
    
    var nickname: String {
        get {
            return UserDefaults.standard.string(forKey: "nickname") ?? "no data"
        }
        set {
            return UserDefaults.standard.set(newValue, forKey: "nickname")
        }
    }
    
    //추후 저장하는 image 데이터가 커지면 터짐
    var profileImage: UIImage {
        get {
            guard let imageData = UserDefaults.standard.data(forKey: "profileImage"),
                  let image = UIImage(data: imageData)
            else {
                return UIImage()
            }
            return image
        }
        set {
            return UserDefaults.standard.set(returnImageData(UIImage: newValue), forKey: "profileImage")
        }
    }
    
    var joinDate: String {
        get {
            return UserDefaults.standard.string(forKey: "joinDate") ?? "no data"
        }
        set {
            return UserDefaults.standard.set(newValue, forKey: "joinDate")
        }
    }
    
    private func returnImageData(UIImage value: UIImage) -> Data {
        return value.jpegData(compressionQuality: 0.8) ?? Data()
    }
    
}
