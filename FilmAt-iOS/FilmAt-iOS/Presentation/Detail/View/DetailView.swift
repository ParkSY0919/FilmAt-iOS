//
//  DetailView.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/30/25.
//

import UIKit

import SnapKit
import Then

final class DetailView: BaseView {
    
    private let sectionTypes = DetailViewSectionType.allCases
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
    let tipButton = UIButton()
    
    override func setHierarchy() {
        self.addSubviews(collectionView, tipButton)
    }
    
    override func setLayout() {
        collectionView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalToSuperview().inset(5)
        }
    }
    
    override func setStyle() {
        collectionView.do {
            $0.register(BackDropCollectionViewCell.self, forCellWithReuseIdentifier: BackDropCollectionViewCell.cellIdentifier)
            $0.register(SynopsisCollectionViewCell.self, forCellWithReuseIdentifier: SynopsisCollectionViewCell.cellIdentifier)
            $0.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.cellIdentifier)
            $0.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: CastCollectionViewCell.cellIdentifier)
            
            $0.register(DetailCollectionHeaderView.self, forSupplementaryViewOfKind: DetailCollectionHeaderView.elementKinds, withReuseIdentifier: DetailCollectionHeaderView.identifier)
            $0.register(DetailCollectionFooterView.self, forSupplementaryViewOfKind: DetailCollectionFooterView.elementKinds, withReuseIdentifier: DetailCollectionFooterView.identifier)
            
            $0.backgroundColor = UIColor(resource: .background)
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
            $0.bounces = false
        }
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            switch self?.sectionTypes[sectionIndex] {
            case .backDrop:
                return self?.createHorizontalScrollSection(sectionType: .backDrop)
            case .synopsis:
                return self?.createHorizontalScrollSection(sectionType: .synopsis)
            case .cast:
                return self?.createHorizontalScrollSection(sectionType: .cast)
            case .poster:
                return self?.createHorizontalScrollSection(sectionType: .poster)
            case .none:
                return self?.createHorizontalScrollSection(sectionType: .backDrop)
            }
        }
    }
    
    private func createHorizontalScrollSection(sectionType: DetailViewSectionType) -> NSCollectionLayoutSection {
        switch sectionType {
        case .backDrop:
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(280))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1.0))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .paging
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            
            let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
            
            let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize,
                                                                     elementKind: DetailCollectionFooterView.elementKinds,
                                                                     alignment: .bottom)
            
            section.boundarySupplementaryItems = [footer]
            
            return section
            
        case .synopsis:
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1.0))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .none
            section.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 10, bottom: 0, trailing: 10)
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(35))
            
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                     elementKind: DetailCollectionHeaderView.elementKinds,
                                                                     alignment: .top)
            
            section.boundarySupplementaryItems = [header]
            
            return section
        case .cast:
            let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(220), heightDimension: .absolute(50))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 30)
            
            //(subitem: item) 16이후 디플. 유의 repeatingSubitem 찾아보기
            let verticalGroupSize = NSCollectionLayoutSize(widthDimension: .estimated(1.0), heightDimension: .absolute(120))
            let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize,
                                                                 repeatingSubitem: item,
                                                                 count: 2)
            verticalGroup.interItemSpacing = .fixed(10)
            
            let horizontalGroupSize = NSCollectionLayoutSize(widthDimension: .estimated(1.0), heightDimension: verticalGroupSize.heightDimension)
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: horizontalGroupSize, subitems: [verticalGroup])
            
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 10, bottom: 0, trailing: 4)
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(35))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                     elementKind: DetailCollectionHeaderView.elementKinds,
                                                                     alignment: .top)
            
            section.boundarySupplementaryItems = [header]
            
            return section
        case .poster:
            let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(140), heightDimension: .absolute(180))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 6)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(1.0), heightDimension: .estimated(1.0))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 10, bottom: 10, trailing: 4)
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(35))
            
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                     elementKind: DetailCollectionHeaderView.elementKinds,
                                                                     alignment: .top)
            
            section.boundarySupplementaryItems = [header]
            
            return section
        }
    }
    
}
