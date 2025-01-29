//
//  SettingViewController.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/29/25.
//

import UIKit

final class SettingViewController: BaseViewController {
    
    let settingView = SettingView()
    
    init() {
        super.init(navTitle: "설정")
    }
    
    override func loadView() {
        view = settingView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setAddTarget()
    }

}

private extension SettingViewController {
    
    func setAddTarget() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileBoxTapped))
        settingView.profileBox.addGestureRecognizer(tapGesture)
        
    }
    
    @objc
    func profileBoxTapped() {
        print(#function)
        let vc = ProfileNicknameViewController(viewModel: ProfileNicknameViewModel(), isPushType: false)
        vc.onChange = { [weak self] in
            self?.settingView.profileBox.changeProfileBoxData()
        }
        viewTransition(viewController: vc, transitionStyle: .presentWithNav)
    }
    
}
