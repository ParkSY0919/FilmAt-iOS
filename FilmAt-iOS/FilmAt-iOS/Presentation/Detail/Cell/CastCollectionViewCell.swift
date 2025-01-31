//
//  CastCollectionViewCell.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 2/1/25.
//

import UIKit

import SnapKit
import Then

final class CastCollectionViewCell: BaseCollectionViewCell {
    
    let imageView = UIImageView()
    let nameLabel = UILabel()
    let engNameLabel = UILabel()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        nameLabel.text = nil
        engNameLabel.text = nil
    }
    
    override func setHierarchy() {
        contentView.addSubviews(imageView,
                                nameLabel,
                                engNameLabel)
    }
    
    override func setLayout() {
        imageView.snp.makeConstraints {
            $0.leading.verticalEdges.equalToSuperview()
            $0.width.equalTo(imageView.snp.height)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.top).offset(10)
            $0.leading.equalTo(imageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        engNameLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(6)
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.trailing.equalToSuperview().inset(10)
        }
    }
    
    override func setStyle() {
        nameLabel.setLabelUI("nameLabel",
                             font: .filmAtFont(.body_bold_14),
                             textColor: UIColor(resource: .title))
        engNameLabel.setLabelUI("engNameLabel",
                                font: .filmAtFont(.body_medium_12),
                                textColor: UIColor(resource: .gray1))
    }
    
    func configureCaseCell(imageUrlPath: String?, name: String, engName: String) {
        if imageUrlPath == nil {
            imageView.setEmptyImageView(imageStr: "person.circle")
        } else {
            imageView.setImageKfDownSampling(with: imageUrlPath, loadImageType: .thumb, cornerRadius: 25)
        }
        nameLabel.text = name
        engNameLabel.text = engName
    }
    
}
