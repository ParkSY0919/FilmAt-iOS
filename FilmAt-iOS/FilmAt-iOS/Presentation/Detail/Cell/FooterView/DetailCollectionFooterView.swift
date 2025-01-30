//
//  DetailCollectionFooterView.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/30/25.
//

import UIKit

import SnapKit
import Then

final class DetailCollectionFooterView: UICollectionReusableView {
    
    static let elementKinds: String = "DetailCollectionFooterView"
    
    static let identifier = "DetailCollectionFooterView"
    
    private let stackView = UIStackView()
    private let lineLabel = UILabel()
    private let lineLabel2 = UILabel()
    private let dateView = FooterItemView(image: UIImage(systemName: "calendar") ?? UIImage())
    private let ratingView = FooterItemView(image: UIImage(systemName: "star.fill") ?? UIImage())
    private let genreView = FooterItemView(image: UIImage(systemName: "film") ?? UIImage())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setLayout()
        setStyle()
    }
    
    private func setHierarchy() {
        addSubview(stackView)
        
        stackView.addArrangedSubviews(dateView,
                                      lineLabel,
                                      ratingView,
                                      lineLabel2,
                                      genreView)
        
    }
    
    private func setLayout() {
        stackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(50)
        }
    }
    
    private func setStyle() {
        self.backgroundColor = UIColor(resource: .background)
        
        stackView.do {
            $0.axis = .horizontal
            $0.spacing = 10
            $0.distribution = .equalSpacing
            $0.alignment = .center
            
        }
        
        [lineLabel, lineLabel2].forEach { i in
            i.setLabelUI("|",
                         font: .filmAtFont(.body_medium_12),
                         textColor: .gray1)
        }
    }
    
    func configureFooterView(date: String, rating: String, genres: String) {
        dateView.configure(text: date)
        ratingView.configure(text: rating)
        genreView.configure(text: genres)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


