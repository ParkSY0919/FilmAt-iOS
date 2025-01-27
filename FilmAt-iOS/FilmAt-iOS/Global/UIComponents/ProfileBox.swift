//
//  ProfileBox.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/27/25.
//

import UIKit

import SnapKit
import Then

final class ProfileBox: BaseView {
    
    private let profileImageView = UIImageView()
    private let nicknameLabel = UILabel()
    private let joinDateLabel = UILabel()
    private let chevronImageView = UIImageView()
    private let archiveContainer = UIView()
    private let archiveLabel = UILabel()
    
    
    override func setHierarchy() {
        self.addSubviews(profileImageView,
                         nicknameLabel,
                         joinDateLabel,
                         chevronImageView,
                         archiveContainer)
        
        archiveContainer.addSubview(archiveLabel)
    }
    
    override func setLayout() {
        profileImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(15)
            $0.size.equalTo(55)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.top).offset(10)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(10)
        }
        
        joinDateLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(2)
            $0.leading.equalTo(nicknameLabel.snp.leading)
        }
        
        chevronImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(15)
            $0.centerY.equalTo(profileImageView.snp.centerY)
            $0.size.equalTo(22)
        }
        
        archiveContainer.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(10)
            $0.horizontalEdges.bottom.equalToSuperview().inset(15)
        }
        
        archiveLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    override func setStyle() {
        self.do {
            $0.backgroundColor = UIColor(resource: .profileBoxBackground)
            $0.layer.cornerRadius = 20
        }
        
        profileImageView.do {
            let image = UserDefaultsManager.shared.profileImage
            $0.setImageView(image: image, cornerRadius: 55/2)
            $0.layer.borderWidth = 4.5
            $0.layer.borderColor = UIColor(resource: .point).cgColor
            $0.alpha = 1.0
        }
        
        let nickname = UserDefaultsManager.shared.nickname
        nicknameLabel.setLabelUI(nickname, font: .filmAtFont(.title_bold_16), textColor: .title)
        
        let joinDate = UserDefaultsManager.shared.joinDate
        joinDateLabel.setLabelUI("\(joinDate) 가입", font: .filmAtFont(.body_medium_12), textColor: .gray2)
        
        chevronImageView.do {
            $0.setImageView(image: UIImage(systemName: "chevron.right") ?? UIImage(), cornerRadius: 0)
            $0.layer.borderWidth = 0
            $0.tintColor = .gray1
        }
        
        archiveContainer.do {
            $0.backgroundColor = UIColor(resource: .point).withAlphaComponent(0.6)
            $0.layer.cornerRadius = 10
        }
        
        let saveMovieCount = UserDefaultsManager.shared.saveMovieCount
        archiveLabel.setLabelUI("\(saveMovieCount)개의 무비박스 보관중",
                                font: .filmAtFont(.body_medium_14),
                                textColor: .title,
                                alignment: .center)
    }
    
}
