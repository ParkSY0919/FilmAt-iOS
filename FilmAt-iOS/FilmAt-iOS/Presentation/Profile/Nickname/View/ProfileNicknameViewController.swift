//
//  ProfileNicknameViewController.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/27/25.
//

import UIKit

final class ProfileNicknameViewController: BaseViewController {
    
    private let viewModel: ProfileNicknameViewModel
    
    private let profileNicknameView = ProfileNicknameView()
    
    init(viewModel: ProfileNicknameViewModel) {
        self.viewModel = viewModel
        
        super.init(navTitle: "프로필 설정", navLeftBtnType: .pop, navRightBtnType: .none)
    }
    
    override func loadView() {
        view = profileNicknameView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegate()
        setAddTarget()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        profileNicknameView.nicknameTextField.becomeFirstResponder()
    }

}

private extension ProfileNicknameViewController {
    
    func setDelegate() {
        profileNicknameView.nicknameTextField.delegate = self
    }
    
    func setAddTarget() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileContainerTapped))
        profileNicknameView.profileContainer.addGestureRecognizer(tapGesture)
        
        profileNicknameView.nicknameTextField.addTarget(self,
                                                        action: #selector(textFieldDidChange),
                                                        for: .editingChanged)
        
        profileNicknameView.doneButtonComponent.doneButton.addTarget(self,
                                                                     action: #selector(doneButtonComponentTapped),
                                                                     for: .touchUpInside)
    }
    
    func bindViewModel() {
        self.viewModel.nicknameText.bind { [weak self] text in
            guard let text else { return }
            self?.viewModel.validateNickname(text)
        }
        
        self.viewModel.isValidNickname.bind { [weak self] state in
            guard let state else { return }
            self?.profileNicknameView.changeProfileNicknameState(stateLabelType: state)
        }
    }
    
    @objc
    func profileContainerTapped() {
        print(#function, "profile Image 설정화면으로 고우!")
        let image = profileNicknameView.profileImageView.image ?? UIImage()
        let vc = ProfileImageViewController(viewModel: ProfileImageViewModel(currentImage: image))
        vc.onChange = { image in
            DispatchQueue.main.async {
                self.profileNicknameView.profileImageView.image = image
            }
        }
        viewTransition(viewController: vc, transitionStyle: .push)
    }
    
    @objc
    func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        viewModel.nicknameText.value = text
    }
    
    @objc
    func doneButtonComponentTapped() {
        print(#function, "메인화면으로 고우!")
        guard let text = profileNicknameView.nicknameTextField.text else { return }
        UserDefaultsManager.shared.nickname = text
        
        let image = profileNicknameView.profileImageView.image
        UserDefaultsManager.shared.profileImage = image ?? UIImage()
        
        UserDefaultsManager.shared.isNotFirstLoading = true
        
        viewTransition(viewController: TabBarController(), transitionStyle: .pushWithRootVC)
    }
    
}

extension ProfileNicknameViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        profileNicknameView.nicknameTextField.resignFirstResponder()
        return true
    }
    
}
