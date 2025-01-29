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
        
        setDelegate()
        setStyle()
        setTabBarAppearence()
    }
    
    private func setDelegate() {
        self.delegate = self
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

extension TabBarController: UITabBarControllerDelegate {
    
    //탭바 아이템 선택으로인한 화면전환 시 깜빡임 방지
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let fromView = selectedViewController?.view, let toView = viewController.view, fromView != toView {
            UIView.transition(from: fromView, to: toView, duration: 0.0, options: [], completion: nil)
        }
        return true
    }
    
}

