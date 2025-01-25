//
//  SceneDelegate.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/24/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow.init(windowScene: scene)
        
        let isNotFirstLoading = UserDefaultsManager.shared.isNotFirstLoading
        print("isNotFirstLoading : \(isNotFirstLoading)")
        switch isNotFirstLoading {
        case true:
            window?.rootViewController = TabBarController()
        case false:
            window?.rootViewController = OnBoardingViewController()
        }
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

