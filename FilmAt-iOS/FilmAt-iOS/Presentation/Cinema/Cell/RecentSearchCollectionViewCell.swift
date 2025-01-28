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
    let xMarkbutton = UIButton()
    
    override func setHierarchy() {
        contentView.addSubviews(searchLabel, xMarkbutton)
    }
    
    override func setLayout() {
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        searchLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(15)
            $0.trailing.equalTo(xMarkbutton.snp.leading).offset(-10)
        }
        
        xMarkbutton.snp.makeConstraints {
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
        
        xMarkbutton.do {
            $0.setImage(UIImage(systemName: "xmark"), for: .normal)
            $0.tintColor = .black
        }
    }
    
    func setCellUI(titleText: String) {
        searchLabel.text = titleText
    }
    
}
