//
//  CinemaView.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/27/25.
//

import UIKit

import SnapKit
import Then

final class CinemaView: BaseView {
    
    let profileBox = ProfileBox()
    
    private let recentSearchLabel = UILabel()
    let recentSearchResetButton = UILabel()
    private let emptyContainer = UIView()
    private let emptyLabel = UILabel()
    lazy var recentSearchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let todayMovieLabel = UILabel()
    lazy var todayMovieCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
 
    override func setHierarchy() {
        self.addSubviews(profileBox,
                         recentSearchLabel,
                         recentSearchResetButton,
                         emptyContainer,
                         recentSearchCollectionView,
                         todayMovieLabel,
                         todayMovieCollectionView)
        
        emptyContainer.addSubview(emptyLabel)
    }
    
    override func setLayout() {
        profileBox.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(15)
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.height.equalTo(135)
        }
        
        recentSearchLabel.snp.makeConstraints {
            $0.top.equalTo(profileBox.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(15)
        }
        
        recentSearchResetButton.snp.makeConstraints {
            $0.top.equalTo(recentSearchLabel.snp.top)
            $0.trailing.equalToSuperview().inset(15)
        }
        
        recentSearchCollectionView.snp.makeConstraints {
            $0.top.equalTo(recentSearchLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        emptyContainer.snp.makeConstraints {
            $0.top.equalTo(recentSearchCollectionView.snp.top)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(recentSearchCollectionView.snp.height)
        }
        
        emptyLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        todayMovieLabel.snp.makeConstraints {
            $0.top.equalTo(recentSearchCollectionView.snp.bottom).offset(20)
            $0.leading.equalTo(recentSearchLabel.snp.leading)
        }
        
        todayMovieCollectionView.snp.makeConstraints {
            $0.top.equalTo(todayMovieLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(10)
        }
    }
    
    override func setStyle() {
        recentSearchLabel.setLabelUI("최근검색어",
                                     font: .filmAtFont(.title_heavy_16),
                                     textColor: .title)
        
        recentSearchResetButton.do {
            $0.isHidden = true
            $0.isUserInteractionEnabled = true
            $0.setLabelUI("전체 삭제",
                          font: .filmAtFont(.body_medium_14),
                          textColor: UIColor(resource: .point),
                          alignment: .right)
        }
        
        recentSearchCollectionView.do {
            $0.isHidden = true
            $0.backgroundColor = UIColor(resource: .background)
            $0.collectionViewLayout = setRecentSearchCollectionViewLayout()
            $0.register(RecentSearchCollectionViewCell.self, forCellWithReuseIdentifier: RecentSearchCollectionViewCell.cellIdentifier)
        }
        
        emptyContainer.do {
            $0.isHidden = true
        }
        
        emptyLabel.setLabelUI("최근 검색어 내역이 없습니다.",
                              font: .filmAtFont(.body_bold_12),
                              textColor: .gray1)
        
        todayMovieLabel.setLabelUI("오늘의 영화",
                                     font: .filmAtFont(.title_heavy_16),
                                     textColor: .title)
        
        todayMovieCollectionView.do {
            $0.backgroundColor = UIColor(resource: .background)
            $0.collectionViewLayout = setTodayMovieCollectionViewLayout()
            $0.register(TodayMovieCollectionViewCell.self, forCellWithReuseIdentifier: TodayMovieCollectionViewCell.cellIdentifier)
        }
    }
    
    func setRecentSearchListState(isEmpty: Bool) {
        recentSearchResetButton.isHidden = isEmpty
        recentSearchCollectionView.isHidden = isEmpty
        emptyContainer.isHidden = !isEmpty
    }
    
}

private extension CinemaView {
    
    func setRecentSearchCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.estimatedItemSize = CGSize(width: 100, height: 30)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        return layout
    }
    
    func setTodayMovieCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        layout.itemSize = CGSize(width: ScreenUtils.width/1.8, height: 370)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        return layout
    }
    
}
