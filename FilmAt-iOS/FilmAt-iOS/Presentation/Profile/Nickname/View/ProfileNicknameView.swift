//
//  ProfileNickNameView.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/27/25.
//

import UIKit

import SnapKit
import Then

final class ProfileNicknameView: BaseView {
    
    let profileContainer = UIView()
    let profileImageView = UIImageView()
    private let cameraImageView = UIImageView()
    
    private let underLine = UIView()
    let nicknameTextField = UITextField()
    private let stateLabel = UILabel()
    
    private let mbtiTtielLabel = UILabel()
    let mbtiView = MBTIView()
    
    let doneButtonComponent = DoneButton(title: "완료",
                                         doneBtnState: .unsatisfied,
                                         isProfileBtn: true)
    
    override func setHierarchy() {
        self.addSubviews(profileContainer,
                         underLine,
                         nicknameTextField,
                         stateLabel,
                         mbtiTtielLabel,
                         mbtiView,
                         doneButtonComponent)
        
        profileContainer.addSubviews(profileImageView, cameraImageView)
        
        
    }
    
    override func setLayout() {
        profileContainer.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(40)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(120)
        }
        
        profileImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        cameraImageView.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview()
            $0.size.equalTo(35)
        }
        
        underLine.snp.makeConstraints {
            $0.top.equalTo(profileContainer.snp.bottom).offset(80)
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.height.equalTo(0.5)
        }
        
        nicknameTextField.snp.makeConstraints {
            $0.bottom.equalTo(underLine.snp.top).offset(-10)
            $0.horizontalEdges.equalTo(underLine).inset(15)
        }
        
        stateLabel.snp.makeConstraints {
            $0.top.equalTo(underLine.snp.bottom).offset(10)
            $0.leading.equalTo(nicknameTextField.snp.leading)
        }
        
        mbtiTtielLabel.snp.makeConstraints {
            $0.top.equalTo(stateLabel.snp.bottom).offset(40)
            $0.leading.equalToSuperview().inset(10)
        }
        
        //stackView를 품은 view라서 height을 설정해주지 않아도 bottom이 계산됨.
        mbtiView.snp.makeConstraints {
            $0.top.equalTo(mbtiTtielLabel.snp.top)
            $0.leading.equalTo(mbtiTtielLabel.snp.trailing).offset(40)
        }
        
        doneButtonComponent.snp.makeConstraints {
            $0.bottom.equalTo(keyboardLayoutGuide.snp.top).offset(-10)
            $0.horizontalEdges.equalTo(underLine)
            $0.height.equalTo(45)
        }
    }
    
    override func setStyle() {
        profileImageView.do {
            $0.setImageView(image: UIImage(), cornerRadius: 120/2)
            $0.layer.borderColor = UIColor(resource: .point).cgColor
            $0.layer.borderWidth = 3
        }
        
        cameraImageView.do {
            $0.setImageView(image: UIImage(systemName: "camera.fill") ?? UIImage(), cornerRadius: 35/2)
            $0.backgroundColor = UIColor(resource: .point)
            $0.layer.borderWidth = 0
            $0.tintColor = .white
            $0.contentMode = .center
        }
        
        underLine.backgroundColor = .white
        
        nicknameTextField.do {
            $0.textColor = UIColor(resource: .title)
            $0.setPlaceholder(placeholder: "닉네임을 입력해주세요", fontColor: .gray1, font: .filmAtFont(.body_regular_16))
        }
        
        stateLabel.do {
            $0.setLabelUI("stateLabel",
                          font: .filmAtFont(.body_regular_16),
                          textColor: UIColor(resource: .point))
            $0.isHidden = true
        }
        
        mbtiTtielLabel.setLabelUI("MBTI", font: .filmAtFont(.title_heavy_16))
        
        doneButtonComponent.isUserInteractionEnabled = false
    }
    
    func isDoneBtnValid(state: Bool) {
        doneButtonComponent.doneBtnState = state ? .satisfied : .unsatisfied
        doneButtonComponent.isUserInteractionEnabled = state
        doneButtonComponent.changeDoneBtnState()
    }
    
    func changeProfileNicknameState(stateLabelType: StateLabelType) {
        stateLabel.do {
            $0.text = stateLabelType.text
            $0.textColor = stateLabelType.textColor
            $0.isHidden = false
        }
    }
    
}
