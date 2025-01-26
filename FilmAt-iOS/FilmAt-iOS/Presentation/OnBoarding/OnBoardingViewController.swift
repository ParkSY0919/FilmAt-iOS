//
//  OnBoardingViewController.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/25/25.
//

import UIKit

final class OnBoardingViewController: BaseViewController {
    
    private let onBoardingView = OnBoardingView()
    
    override func loadView() {
        view = onBoardingView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAddTarget()
    }
    
}

private extension OnBoardingViewController {
    
    func setAddTarget() {
        onBoardingView.startButton.doneButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func startButtonTapped() {
        print(#function)
        viewTransition(viewController: OnBoardingViewController()/*추후 프로필 설정화면으로 교체*/, transitionStyle: .push)
    }
    
}
