//
//  SearchView.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/28/25.
//

import UIKit

import SnapKit
import Then

final class SearchView: BaseView {
    
    let searchTextField = UITextField()
    
    override func setHierarchy() {
        self.addSubviews(searchTextField)
    }
    
    override func setLayout() {
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.height.equalTo(40)
        }
    }
    
    override func setStyle() {
        
        searchTextField.do {
            $0.backgroundColor = .searchBarBackground
            $0.font = .filmAtFont(.body_regular_16)
            $0.textColor = UIColor(resource: .title)
            $0.setPlaceholder(placeholder: " 영화를 검색해보세요.",
                              fontColor: UIColor(resource: .gray1),
                              font: .filmAtFont(.body_regular_16))
            $0.setLeftPadding(amount: 25,
                              image: UIImage(systemName: "magnifyingglass"),
                              inset: 8)
            $0.layer.cornerRadius = 10
        }
    }
    
}

