//
//  ProfileNicknameViewController.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/27/25.
//

import UIKit

final class ProfileNicknameViewController: BaseViewController {
    
    private let profileNicknameView = ProfileNicknameView()
    
    init() {
        super.init(navTitle: "프로필 설정", navLeftBtnType: .pop, navRightBtnType: .none)
    }
    
    override func loadView() {
        view = profileNicknameView
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setAddTarget()
    }
    
    
    private func setAddTarget() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileContainerTapped))
        profileNicknameView.profileContainer.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func profileContainerTapped() {
        print(#function)
    }

}
