//
//  TabBarController.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/25/25.
//

import UIKit

final class TabBarController: UITabBarController {
    
    private let cinemaVC = UINavigationController(rootViewController: CinemaViewController(viewModel: CinemaViewModel()))
    private let upcomingVC = UINavigationController(rootViewController: BaseViewController())
    private let settingVC = UINavigationController(rootViewController: SettingViewController(viewModel: SettingViewModel()))
    
    override func viewDidLoad() {
        super.viewDidLoad ()
        
        setStyle()
        setTabBarAppearence()
    }
    
    private func setStyle() {
        cinemaVC.do {
            $0.tabBarItem = UITabBarItem(title: "CINEMA",
                                         image: UIImage(systemName: "popcorn"),
                                         selectedImage: UIImage(systemName: "popcorn"))
        }
        
        upcomingVC.do {
            $0.tabBarItem = UITabBarItem(title: "UPCOMING",
                                         image: UIImage(systemName: "film.stack"),
                                         selectedImage: UIImage(systemName: "film.stack"))
        }
        
        settingVC.do {
            $0.tabBarItem = UITabBarItem(title: "PROFILE",
                                         image: UIImage(systemName: "person.crop.circle"),
                                         selectedImage: UIImage(systemName: "person.crop.circle"))
        }
        
        setViewControllers([cinemaVC, upcomingVC, settingVC], animated: false)
        
        self.selectedIndex = 0
    }
    
    private func setTabBarAppearence () {
        let appearence = UITabBarAppearance ()
        appearence.configureWithTransparentBackground()
        appearence.backgroundColor = UIColor(resource: .background)
        tabBar.standardAppearance = appearence
        tabBar.scrollEdgeAppearance = appearence
        tabBar.tintColor = UIColor(resource: .point)
    }
    
}

