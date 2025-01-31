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
            UserDefaults.standard.set(newValue, forKey: "isNotFirstLoading")
            saveChanges()
        }
    }
    
    var nickname: String {
        get {
            return UserDefaults.standard.string(forKey: "nickname") ?? "no data"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "nickname")
            saveChanges()
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
            if let pngData = newValue.pngData() {
                UserDefaults.standard.set(pngData, forKey: "profileImage")
                saveChanges()
            }
        }
    }
    
    var joinDate: String {
        get {
            return UserDefaults.standard.string(forKey: "joinDate") ?? "no data"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "joinDate")
            saveChanges()
        }
    }
    
    var saveMovieCount: Int {
        get {
            return UserDefaults.standard.integer(forKey: "saveMovieCount")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "saveMovieCount")
            saveChanges()
        }
    }
    
    var recentSearchList: [String] {
        get {
            var list = [String]()
            if let recentSearchList = UserDefaults.standard.array(forKey: "recentSearchList") as? [String] {
                list = recentSearchList
            }
            return list
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "recentSearchList")
            saveChanges()
        }
    }
    
    private func saveChanges() {
        UserDefaults.standard.setPersistentDomain(UserDefaults.standard.persistentDomain(forName: Bundle.main.bundleIdentifier!) ?? [:], forName: Bundle.main.bundleIdentifier!)
    }
    
    private func returnImageData(UIImage value: UIImage) -> Data {
        return value.jpegData(compressionQuality: 0.8) ?? Data()
    }
    
}
