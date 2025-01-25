//
//  UIAlertManager.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/25/25.
//


import UIKit

final class UIAlertManager {
    
    private init() {}
    
    static func showAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        return alert
    }
    
    static func showActionSheet(title: String, message: String, actionArr: [String]) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        for i in actionArr {
            alert.addAction(UIAlertAction(title: i, style: .default))
        }
        
        return alert
    }
    
}
