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
    
    let emptyContainer = UIView()
    let emptyLabel = UILabel()
    let searchTableView = UITableView()
    
    override func setHierarchy() {
        self.addSubviews(searchTextField, emptyContainer, searchTableView)
        
        emptyContainer.addSubview(emptyLabel)
    }
    
    override func setLayout() {
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.height.equalTo(40)
        }
        
        emptyContainer.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        searchTableView.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        emptyLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(200)
            $0.centerX.equalToSuperview()
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
        
        emptyContainer.do {
            $0.isHidden = true
            $0.backgroundColor = UIColor(resource: .background)
        }
        
        emptyLabel.do {
            $0.isHidden = true
            $0.setLabelUI("원하는 검색결과를 찾지 못했습니다.",
                          font: .filmAtFont(.body_medium_14),
                          textColor: UIColor(resource: .gray1))
        }
        
        searchTableView.do {
            $0.isHidden = true
            $0.backgroundColor = UIColor(resource: .background)
            $0.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.cellIdentifier)
            $0.rowHeight = 120
            $0.separatorInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        }
    }
    
    func setHiddenUI(isEmpty: Bool) {
        emptyContainer.isHidden = !isEmpty
        emptyLabel.isHidden = !isEmpty
        searchTableView.isHidden = isEmpty
    }
    
}

