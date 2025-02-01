//
//  BaseViewController.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/25/25.
//

import UIKit

import SnapKit
import Then

class BaseViewController: UIViewController {
    
    var navTitle: String?
    var navLeftBtnType: NavigationLeftBtnType
    var navRightBtnType: NavigationRightBtnType
    var likeBtnComponent: LikeButton?
    
    init(navTitle: String? = nil , navLeftBtnType: NavigationLeftBtnType = .none, navRightBtnType: NavigationRightBtnType = .none) {
        self.navTitle = navTitle
        self.navLeftBtnType = navLeftBtnType
        self.navRightBtnType = navRightBtnType
        print("BaseViewController init 실행")
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !NWPathMonitorManager.shared.isMonitoring {
            NWPathMonitorManager.shared.startNetworkTracking()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseVCNavSetting()
        setHierarchy()
        setLayout()
        setStyle()
    }
    
    private func baseVCNavSetting() {
        navigationController?.navigationBar.tintColor = UIColor(resource: .point)
        view.backgroundColor = UIColor(resource: .background)
        
        switch navTitle==nil {
        case true:
            print("navTitle is nil")
        case false:
            print("navTitle is not nil")
            navigationItem.title = navTitle
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        }
        
        switch navLeftBtnType {
        case .pop:
            let navLeftItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .done, target: self, action: #selector(popBtnTapped))
            navigationItem.leftBarButtonItem = navLeftItem
        case .dismiss:
            let navLeftItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .done, target: self, action: #selector(dismissBtnTapped))
            navigationItem.leftBarButtonItem = navLeftItem
        case .none:
            print("navLeft Btn None")
        }
        
        switch navRightBtnType {
        case .search:
            let navRightItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .done, target: self, action: #selector(searchBtnTapped))
            navigationItem.rightBarButtonItem = navRightItem
        case .like:
            let likeBtn = LikeButton()
            self.likeBtnComponent = likeBtn
            
            let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 44))
            likeBtn.frame = containerView.bounds
            
            containerView.addSubview(likeBtn)
            containerView.isUserInteractionEnabled = true

            let navRightItem = UIBarButtonItem(customView: containerView)
            let tipBtnItem = UIBarButtonItem(image: UIImage(systemName: "wand.and.rays"), style: .done, target: self, action: #selector(tipBtnTapped))
            navigationItem.setRightBarButtonItems([navRightItem, tipBtnItem], animated: true)
        case .save:
            let navRightItem = UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(saveBtnTapped))
            navigationItem.rightBarButtonItem = navRightItem
        case .none:
            print("navRight Btn None")
        }
    }
    
    func setHierarchy() {}
    
    func setLayout() {}
    
    func setStyle() {}
    
    func setChildrenViewLayout<T: BaseView>(view: T) {
        view.setLayout()
    }
    
    func viewTransition<T: UIViewController>(viewController: T, transitionStyle: ViewTransitionType) {
        switch transitionStyle {
        case .push:
            self.navigationController?.pushViewController(viewController, animated: true)
        case .resetRootVCwithNav:
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else { return }
            
            let newRootVC = UINavigationController(rootViewController: viewController)
            
            UIView.transition(with: window,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: { window.rootViewController = newRootVC },
                              completion: nil)
            window.makeKeyAndVisible()
        case .resetRootVCwithoutNav:
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else { return }
            
            let newRootVC = viewController
            
            UIView.transition(with: window,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: { window.rootViewController = newRootVC },
                              completion: nil)
            window.makeKeyAndVisible()
        case .present:
            return self.present(viewController, animated: true)
        case .presentWithNav:
            let nav = UINavigationController(rootViewController: viewController)
            nav.sheetPresentationController?.prefersGrabberVisible = true
            return self.present(nav, animated: true)
        case .presentFullScreenWithNav:
            let nav = UINavigationController(rootViewController: viewController)
            nav.modalPresentationStyle = .fullScreen
            return self.present(nav, animated: true)
        }
    }
    
    @objc
    func popBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func dismissBtnTapped() {
        self.dismiss(animated: true)
    }
    
    @objc
    func searchBtnTapped() {
        print(#function)
    }
    
    @objc
    func tipBtnTapped() {
        print(#function)
    }
    
    @objc
    func saveBtnTapped() {
        print(#function)
        self.dismiss(animated: true)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
