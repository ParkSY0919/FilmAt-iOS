//
//  DetailViewController.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/30/25.
//

import UIKit

final class DetailViewController: BaseViewController {
    
    private let viewModel: DetailViewModel
    
    private let detailView = DetailView()
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        
        super.init(navTitle: viewModel.moviewTitle, navLeftBtnType: .pop, navRightBtnType: .like)
    }
    
    override func loadView() {
        view = self.detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        bindViewModel()
        print("Delegate set: \(detailView.collectionView.delegate === self)")
    }
    
}

private extension DetailViewController {
    
    func setDelegate() {
        detailView.collectionView.delegate = self
        detailView.collectionView.dataSource = self
    }
    
    func bindViewModel() {
        viewModel.isMoreState.bind { [weak self] flag in
            guard let flag else { return }
            DispatchQueue.main.async {
                self?.viewModel.synopsisNumberOfLines = flag ? 3 : 0
                UIView.performWithoutAnimation {
                    self?.detailView.collectionView.reloadSections(IndexSet(integer: 1))
                }
            }
        }
    }
    
}

extension DetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            guard scrollView == detailView.collectionView else { return }
            
            let pageWidth = scrollView.bounds.width
            let currentPage = Int(scrollView.contentOffset.x / pageWidth)
            
            // 첫 번째 섹션이 백드롭인지 확인
            guard viewModel.sectionTypes.first == .backDrop else { return }
            
            // 현재 페이지의 셀 찾기
            guard let cell = detailView.collectionView.cellForItem(at: IndexPath(item: currentPage, section: 0)) as? BackDropCollectionViewCell else { return }
            
            // 페이지 컨트롤 업데이트
            cell.pageControl.currentPage = currentPage
            
            print("현재 페이지: \(currentPage)")
        }
    
}


extension DetailViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard viewModel.sectionTypes.first == .backDrop,
              indexPath.section == 0,
              let backdropCell = cell as? BackDropCollectionViewCell else { return }
        
        // 현재 페이지를 정확하게 계산
        let currentPage = indexPath.item
        
        // 페이지 컨트롤 업데이트
        backdropCell.pageControl.currentPage = currentPage
        
        print("현재 페이지: \(currentPage)")
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sectionTypes.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch viewModel.sectionTypes[indexPath.section] {
            
        case .backDrop:
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                               withReuseIdentifier: DetailCollectionFooterView.identifier,
                                                                               for: indexPath) as? DetailCollectionFooterView
            else { return UICollectionReusableView() }
            
            
//            let releaseDate = DateFormatterManager.shard.setDateString(strDate: date, format: "yy.MM.dd")
            footer.configureFooterView(date: "2888.88.88", rating: "8.0", genres: "액선, 스릴러")
            
            
            return footer
        default:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                               withReuseIdentifier: DetailCollectionHeaderView.identifier,
                                                                               for: indexPath) as? DetailCollectionHeaderView
            else { return UICollectionReusableView() }
            
            header.viewModel = self.viewModel
            
            let isMoreHidden: Bool = (indexPath.section != 1)
            header.configureHeaderView(headerTitle: viewModel.sectionHeaderTitles[indexPath.section], isMoreHidden: isMoreHidden)
            
            return header
        }
        
    }
}

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch viewModel.sectionTypes[section] {
        case .backDrop:
            guard let backDropCnt = viewModel.imageResponseData?.backdrops.count else {return 0}
            return backDropCnt == 0 ? 1 : backDropCnt
        case .synopsis:
            return 1
        case .cast:
            return 2
        case .poster:
            return 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.sectionTypes[indexPath.section] {
        case .backDrop:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BackDropCollectionViewCell.cellIdentifier, for: indexPath) as! BackDropCollectionViewCell
            
            guard let backDropCnt = viewModel.imageResponseData?.backdrops.count else {return UICollectionViewCell()}
            
            switch backDropCnt == 0 {
            case true:
                cell.configureBackDropCell(imageUrlPath: "", backDropImageCnt: backDropCnt)
                return cell
            case false:
                let item = viewModel.imageResponseData?.backdrops[indexPath.item]
                cell.configureBackDropCell(imageUrlPath: item?.filePath ?? "", backDropImageCnt: backDropCnt)
                return cell
            }
        case .synopsis:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SynopsisCollectionViewCell.cellIdentifier, for: indexPath) as! SynopsisCollectionViewCell
            cell.configureCell(numberOfLines: viewModel.synopsisNumberOfLines)
            return cell
        case .cast:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BackDropCollectionViewCell.cellIdentifier, for: indexPath) as! BackDropCollectionViewCell
            return cell
        case .poster:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BackDropCollectionViewCell.cellIdentifier, for: indexPath) as! BackDropCollectionViewCell
            return cell
        }
    }
    
    
}
