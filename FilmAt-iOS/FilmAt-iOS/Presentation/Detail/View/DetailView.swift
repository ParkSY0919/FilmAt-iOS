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
    
    override func setHierarchy() {
        self.addSubview(collectionView)
    }
    
    override func setLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func setStyle() {
        collectionView.do {
            $0.register(BackDropCollectionViewCell.self, forCellWithReuseIdentifier: BackDropCollectionViewCell.cellIdentifier)
            $0.register(SynopsisCollectionViewCell.self, forCellWithReuseIdentifier: SynopsisCollectionViewCell.cellIdentifier)
            
            $0.register(DetailCollectionHeaderView.self, forSupplementaryViewOfKind: DetailCollectionHeaderView.elementKinds, withReuseIdentifier: DetailCollectionHeaderView.identifier)
            
            $0.register(DetailCollectionFooterView.self, forSupplementaryViewOfKind: DetailCollectionFooterView.elementKinds, withReuseIdentifier: DetailCollectionFooterView.identifier)
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
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
            
        default:
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1.0))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .none
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(35))
            
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                     elementKind: DetailCollectionHeaderView.elementKinds,
                                                                     alignment: .top)
            
            section.boundarySupplementaryItems = [header]
            
            return section
            
        }
    }
    
}
