//
//  TabBarController.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/25/25.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad ()
        
        setTabBarControllerStyle()
        setTabBarAppearence ()
    }
    
    private func setTabBarControllerStyle() {
        let cinemaVC = UINavigationController(rootViewController: CinemaViewController(viewModel: CinemaViewModel()))
        cinemaVC.tabBarItem = UITabBarItem(title: "CINEMA",
                                          image: UIImage(systemName: "popcorn"),
                                          selectedImage: UIImage(systemName: "popcorn"))
        
        let upcomingVC = UINavigationController(rootViewController: BaseViewController())
        upcomingVC.tabBarItem = UITabBarItem(title: "UPCOMING",
                                           image: UIImage(systemName: "film.stack"),
                                           selectedImage: UIImage(systemName: "film.stack"))
        
        let settingVC = UINavigationController(rootViewController: SettingViewController(viewModel: SettingViewModel()))
        settingVC.tabBarItem = UITabBarItem(title: "PROFILE",
                                            image: UIImage(systemName: "person.crop.circle"),
                                            selectedImage: UIImage(systemName: "person.crop.circle"))
        
        
        
        setViewControllers([cinemaVC, upcomingVC, settingVC], animated: true)
        
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
