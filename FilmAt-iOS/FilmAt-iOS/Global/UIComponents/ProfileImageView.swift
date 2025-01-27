//
//  ProfileImageView.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/27/25.
//

import UIKit

import SnapKit
import Then

final class ProfileImageView: BaseView {
    
    var profileImage: UIImage
    private let profileContainer = UIView()
    let profileImageView = UIImageView()
    private let cameraImageView = UIImageView()
    
    init(profileImage: UIImage) {
        self.profileImage = profileImage
        
        super.init(frame: .zero)
    }
    
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
        
        profileImageView.do {
            $0.setImageView(image: self.profileImage, cornerRadius: 120/2)
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
    }
}
