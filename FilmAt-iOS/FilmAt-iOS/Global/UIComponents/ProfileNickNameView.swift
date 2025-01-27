//
//  ProfileNickNameView.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/27/25.
//

import UIKit

import SnapKit
import Then

final class ProfileNickNameView: BaseView {
    
    let profileContainer = UIView()
    private let profileImageView = UIImageView()
    private let cameraImageView = UIImageView()
    
    override func setHierarchy() {
        self.addSubviews(profileContainer)
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
    }
    
    override func setStyle() {
        setRandomProfileImage()
        
        cameraImageView.do {
            $0.setImageView(image: UIImage(systemName: "camera.fill") ?? UIImage(), cornerRadius: 35/2)
            $0.backgroundColor = UIColor(resource: .point)
            $0.layer.borderWidth = 0
            $0.tintColor = .white
            $0.contentMode = .center
        }
    }
    
    private func setRandomProfileImage() {
        var imageArr: [UIImage] = []
        for i in 0...11 {
            imageArr.append(UIImage(named: "profile_\(i)") ?? UIImage())
        }
        
        let randomProfileImage = imageArr.randomElement() ?? UIImage()
        
        profileImageView.do {
            $0.setImageView(image: randomProfileImage, cornerRadius: 120/2)
            $0.layer.borderColor = UIColor(resource: .point).cgColor
            $0.layer.borderWidth = 3
        }
    }
    
}

