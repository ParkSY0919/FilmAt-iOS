//
//  SettingTableViewCell.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/29/25.
//

import UIKit

import SnapKit
import Then

final class SettingTableViewCell: BaseTableViewCell {
    
    private let rowTitleLabel = UILabel()
    
    override func setHierarchy() {
        contentView.addSubview(rowTitleLabel)
    }
    
    override func setLayout() {
        rowTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.centerY.equalToSuperview()
        }
    }
    
    override func setStyle() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor(resource: .background)
        
        rowTitleLabel.setLabelUI("rowTitleLabel",
                                 font: .filmAtFont(.body_regular_16),
                                 textColor: UIColor(resource: .gray2))
    }
    
    func configureCellUI(rowTitle: String) {
        rowTitleLabel.text = rowTitle
    }
    
}
