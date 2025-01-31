//
//  DetailCollectionHeaderView.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/30/25.
//

import UIKit

import SnapKit
import Then

final class DetailCollectionHeaderView: UICollectionReusableView {
    
    var viewModel: DetailViewModel?
    
    static let elementKinds: String = "DetailCollectionHeaderView"
    
    static let identifier = "DetailCollectionHeaderView"
    
    private let headerTitleLabel = UILabel()
    let moreButton = UIButton(type: .custom)

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setLayout()
        setStyle()
    }
    
    private func setHierarchy() {
        self.addSubviews(headerTitleLabel, moreButton)
    }
    
    private func setLayout() {
        headerTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-4)
        }
        
        moreButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(headerTitleLabel.snp.bottom).offset(6)
        }
    }
    
    private func setStyle() {
        headerTitleLabel.setLabelUI("headerTitleLabel", font: .filmAtFont(.title_heavy_16), textColor: .title)
        
        moreButton.do {
            let btnTitle = (viewModel?.isMoreState.value ?? true) ? "More" : "Hide"
            moreButton.setTitle(btnTitle, for: .normal)
            $0.setTitleColor(UIColor(resource: .point), for: .normal)
            $0.titleLabel?.font = .filmAtFont(.body_medium_14)
            $0.titleLabel?.textAlignment = .right
            $0.addTarget(self, action: #selector(moreBtnTapped), for: .touchUpInside)
        }
    }
    
    func configureHeaderView(headerTitle: String, isMoreHidden: Bool) {
        headerTitleLabel.text = headerTitle
        moreButton.isHidden = isMoreHidden
    }
    
    @objc
    func moreBtnTapped(_ sender: UIButton) {
        viewModel?.isMoreState.value?.toggle()
        let btnTitle = (viewModel?.isMoreState.value ?? true) ? "More" : "Hide"
        moreButton.setTitle(btnTitle, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



