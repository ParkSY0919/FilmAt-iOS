//
//  FooterItemView.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/30/25.
//

import UIKit

import SnapKit
import Then

final class FooterItemView: BaseView {
    
    private let stackView = UIStackView()
    private let iconImageView = UIImageView()
    private let label = UILabel()
    
    init(image: UIImage) {
        super.init(frame: .zero)
        
        iconImageView.setImageView(image: image, cornerRadius: 0)
    }
    
    override func setHierarchy() {
        self.addSubview(stackView)
        
        stackView.addArrangedSubviews(iconImageView, label)
    }
    
    override func setLayout() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints {
            $0.size.equalTo(16)
        }
    }
    
    override func setStyle() {
        stackView.do {
            $0.axis = .horizontal
            $0.spacing = 8
            $0.alignment = .center
        }
        
        iconImageView.do {
            $0.tintColor = .gray1
            $0.layer.borderWidth = 0
        }
        
        label.setLabelUI("label",
                         font: .filmAtFont(.body_medium_12),
                         textColor: .gray1)
    }
    
    func configure(text: String) {
        label.text = text
    }
    
}
