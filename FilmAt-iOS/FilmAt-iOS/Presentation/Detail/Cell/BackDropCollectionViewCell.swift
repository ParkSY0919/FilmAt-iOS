//
//  BackDropCollectionViewCell.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/30/25.
//

import UIKit

import SnapKit
import Then

final class BackDropCollectionViewCell: BaseCollectionViewCell {
    
    private let imageView = UIImageView()
    
    override func setHierarchy() {
        contentView.addSubview(imageView)
    }
    
    override func setLayout() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(0).priority(.low)
        }
    }
    
    override func setStyle() {
        imageView.setImageView(image: UIImage(systemName: "star") ?? UIImage(), cornerRadius: 0)
        imageView.do {
            $0.layer.borderWidth = 0
            $0.contentMode = .scaleAspectFill
        }
    }
    
    func configureBackDropCell(imageUrlPath: String) {
        imageView.setImageKfDownSampling(with: imageUrlPath, loadImageType: .original, cornerRadius: 0)
        imageView.do {
            $0.layer.borderWidth = 0
            $0.contentMode = .scaleAspectFill
        }
        
    }
    
}
