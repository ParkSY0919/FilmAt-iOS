//
//  SynopsisCollectionViewCell.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/30/25.
//

import UIKit

import SnapKit
import Then

final class SynopsisCollectionViewCell: BaseCollectionViewCell {
    
    private let contentLabel = UILabel()
    
    override func setHierarchy() {
        contentView.addSubview(contentLabel)
    }
    
    override func setLayout() {
        contentLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.verticalEdges.equalToSuperview()
        }
    }
    
    override func setStyle() {
        self.backgroundColor = .background
        
        contentLabel.setLabelUI("contentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabel", font: .filmAtFont(.body_medium_12), textColor: .title, numberOfLines: 3)
    }
    
    func configureCell(numberOfLines: Int) {
        contentLabel.numberOfLines = numberOfLines
    }
    
}
