//
//  ProfileNicknameViewController.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/27/25.
//

import UIKit

final class ProfileNicknameViewController: BaseViewController {
    
    var onChange: (()->Void)?
    private let isPushType: Bool
    private let viewModel: ProfileNicknameViewModel
    
    private let profileNicknameView = ProfileNicknameView()
    
    init(viewModel: ProfileNicknameViewModel, isPushType: Bool) {
        print(#function)
        self.viewModel = viewModel
        self.isPushType = isPushType
        
        if isPushType {
            super.init(navTitle: "프로필 설정", navLeftBtnType: .pop, navRightBtnType: .none)
        } else {
            super.init(navTitle: "프로필 편집", navLeftBtnType: .dismiss, navRightBtnType: .save)
        }
    }
    
    override func loadView() {
        view = profileNicknameView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegate()
        setAddTarget()
        bindViewModel()
        setHandlingUserDefaultsData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let text = profileNicknameView.nicknameTextField.text
        else { return }
        
        if text.isEmpty {
            profileNicknameView.nicknameTextField.becomeFirstResponder()
        }
    }
    
    override func saveBtnTapped() {
        print(#function)
        
        saveUserDefaults(isPushType: false)
        onChange?()
        super.saveBtnTapped()
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
    
    func setHandlingUserDefaultsData() {
        switch isPushType {
        case true:
            profileNicknameView.doneButtonComponent.isHidden = false
        case false:
            profileNicknameView.doneButtonComponent.isHidden = true
            
            let nickname = UserDefaultsManager.shared.nickname
            let profileImage = UserDefaultsManager.shared.profileImage
            
            profileNicknameView.nicknameTextField.text = nickname
            profileNicknameView.profileImageView.image = profileImage
        }
    }
    
    func saveUserDefaults(isPushType: Bool) {
        switch isPushType {
        case true:
            guard let text = profileNicknameView.nicknameTextField.text else { return }
            let image = profileNicknameView.profileImageView.image
            let joinDate = DateFormatterManager.shard.setDateStringFromDate(date: Date(), format: "yy.MM.dd")
            
            DispatchQueue.global().async {
                UserDefaultsManager.shared.nickname = text
                UserDefaultsManager.shared.profileImage = image ?? UIImage()
                UserDefaultsManager.shared.isNotFirstLoading = true
                UserDefaultsManager.shared.joinDate = joinDate
            }
        case false:
            guard let text = profileNicknameView.nicknameTextField.text else { return }
            let image = profileNicknameView.profileImageView.image
            DispatchQueue.global().async {
                UserDefaultsManager.shared.nickname = text
                UserDefaultsManager.shared.profileImage = image ?? UIImage()
            }
            
        }
    }
    
}

//MARK: - @objc func
private extension ProfileNicknameViewController {
    
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
        saveUserDefaults(isPushType: true)
        
        viewTransition(viewController: TabBarController(), transitionStyle: .resetRootVCwithoutNav)
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
