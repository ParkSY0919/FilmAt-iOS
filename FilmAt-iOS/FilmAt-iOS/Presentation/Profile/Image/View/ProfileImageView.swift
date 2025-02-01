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
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    init(profileImage: UIImage) {
        self.profileImage = profileImage
        
        super.init(frame: .zero)
    }
    
    override func setHierarchy() {
        self.addSubviews(profileContainer, collectionView)
        
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
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(profileContainer.snp.bottom).offset(30)
            $0.horizontalEdges.equalToSuperview().inset(15)
            $0.height.equalTo(300)
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
        
        collectionView.do {
            $0.register(ProfileImageCollectionViewCell.self, forCellWithReuseIdentifier: ProfileImageCollectionViewCell.cellIdentifier)
            $0.collectionViewLayout = setCollectionViewLayout()
            $0.backgroundColor = .clear
        }
    }
    
    private func setCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let width = (ScreenUtils.width - 60)/4
        layout.itemSize = CGSize(width: width, height: width)
        
        return layout
    }
    
}
