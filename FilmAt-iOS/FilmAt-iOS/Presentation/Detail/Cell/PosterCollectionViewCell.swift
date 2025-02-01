//
//  PosterCollectionViewCell.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 2/1/25.
//

import UIKit

import SnapKit
import Then

final class PosterCollectionViewCell: BaseCollectionViewCell {
    
    let imageView = UIImageView()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }
    
    override func setHierarchy() {
        contentView.addSubview(imageView)
    }
    
    override func setLayout() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setStyle() {
        self.backgroundColor = UIColor(resource: .background)
    }
    
    func configurePosterCell(imageUrlPath: String?) {
        imageView.setImageKfDownSampling(with: imageUrlPath,
                                         loadImageType: .poster,
                                         cornerRadius: 0)
    }
    
}
