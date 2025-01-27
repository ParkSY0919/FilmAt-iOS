//
//  RecentSearchCollectionViewCell.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/27/25.
//

import UIKit

import SnapKit
import Then

final class RecentSearchCollectionViewCell: BaseCollectionViewCell {
    
    private let searchLabel = UILabel()
    private let xImageView = UIImageView()
    
    override func setHierarchy() {
        contentView.addSubviews(searchLabel, xImageView)
    }
    
    override func setLayout() {
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        searchLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(15)
            $0.trailing.equalTo(xImageView.snp.leading).offset(-10)
        }
        
        xImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(15)
            $0.width.equalTo(15)
            $0.height.equalTo(20)
        }
    }
    
    override func setStyle() {
        contentView.do {
            $0.backgroundColor = UIColor(resource: .recentSearchBackground)
            $0.layer.cornerRadius = 14
        }
        
        searchLabel.setLabelUI("titleText",
                               font: .filmAtFont(.body_medium_14),
                               textColor: .black)
        
        xImageView.image = UIImage(systemName: "xmark")
        xImageView.tintColor = .black
    }
    
    func setCellUI(titleText: String) {
        searchLabel.text = titleText
    }
    
}
