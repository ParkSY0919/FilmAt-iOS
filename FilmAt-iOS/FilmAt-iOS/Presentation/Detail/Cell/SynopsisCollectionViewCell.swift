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
    
    let contentLabel = UILabel()
    
    override func setHierarchy() {
        contentView.addSubview(contentLabel)
    }
    
    override func setLayout() {
        contentLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.verticalEdges.equalToSuperview()
        }
    }
    
    override func setStyle() {
        self.backgroundColor = .background
        
        contentLabel.setLabelUI("contentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabelcontentLabel", font: .filmAtFont(.body_medium_14), textColor: .title, numberOfLines: 3)
        contentLabel.lineBreakMode = .byCharWrapping
    }
    
    func configureCell(contentText: String?, numberOfLines: Int) {
        contentLabel.text = contentText == "" ? "제공되는 줄거리가 없습니다." : contentText
        contentLabel.numberOfLines = numberOfLines
    }
    
}
