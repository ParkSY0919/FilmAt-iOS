//
//  ProfileImageCollectionViewCell.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/27/25.
//

import UIKit

import SnapKit
import Then

final class ProfileImageCollectionViewCell: BaseCollectionViewCell {

    let profileImageView = UIImageView()
    
    override func setHierarchy() {
        contentView.addSubview(profileImageView)
    }
    
    override func setLayout() {
        profileImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setStyle() {
        profileImageView.do {
            $0.backgroundColor = .clear
        }
    }
    
    func setProfileCellUI(image: UIImage, isSame: Bool) {
        profileImageView.do {
            let height = self.bounds.height
            $0.setImageView(image: image, cornerRadius: height/2)
        }
        if isSame {
            profileImageView.layer.borderWidth = 3
            profileImageView.layer.borderColor = UIColor(resource: .point).cgColor
            profileImageView.alpha = 1.0
        } else {
            profileImageView.layer.borderWidth = 1
            profileImageView.layer.borderColor = UIColor.lightGray.cgColor
            profileImageView.alpha = 0.5
        }
    }
    
}
