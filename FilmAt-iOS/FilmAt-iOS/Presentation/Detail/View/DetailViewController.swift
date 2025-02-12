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
    }
    
    override func tipBtnTapped() {
        print(#function)
        let alert = UIAlertManager.showAlert(title: StringLiterals.Detail.tipAlertTitle, message: StringLiterals.Detail.tipAlertMessage)
        viewTransition(viewController: alert, transitionStyle: .present)
    }
    
}

private extension DetailViewController {
    
    func setDelegate() {
        detailView.collectionView.delegate = self
        detailView.collectionView.dataSource = self
    }
    
    func bindViewModel() {
        //추후 LikeButtonManager로 대체
        self.likeBtnComponent?.likeButton.isSelected
            = viewModel.likeMovieListDic[String(viewModel.detailMovieInfoModel.moviewId)] ?? false
        
        viewModel.isMoreState.bind { [weak self] flag in
            guard let flag else { return }
            DispatchQueue.main.async {
                self?.viewModel.synopsisNumberOfLines = flag ? 3 : 0
                
                // collectionView Section load시 깜빡거림 없애면서 애니메이션 어떻게 줘야할까
                //performWithoutAnimation이걸 쓰지않았을 때에는 스무스한게 아닌 깜빡 거렸음.
                UIView.performWithoutAnimation {
                    self?.detailView.collectionView.reloadSections(IndexSet(integer: 1))
                }
            }
        }
        
        //추후 LikeButtonManager로 대체
        self.likeBtnComponent?.onTapLikeButton = { [weak self] isSelected in
            guard let self = self else { return }
            if isSelected {
                self.viewModel.likeMovieListDic[String(viewModel.detailMovieInfoModel.moviewId)] = true
            } else {
                self.viewModel.likeMovieListDic[String(viewModel.detailMovieInfoModel.moviewId)] = nil
            }
            UserDefaultsManager.shared.likeMovieListDic = self.viewModel.likeMovieListDic
            viewModel.likedMovieListChange?(self.viewModel.likeMovieListDic)
        }
        
        viewModel.output.setZoomImage.lazyBind { [weak self] imageView in
            guard let self else {return}
            let zoomVC = UtilZoomViewController(imageView: imageView)
            viewTransition(viewController: zoomVC, transitionStyle: .present)
        }
    }
    
}

extension DetailViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch viewModel.sectionTypes[indexPath.section] {
        case .backDrop:
            viewModel.input.prepareZoomBackDropImage.value = indexPath.item
        case .poster:
            viewModel.input.prepareZoomPosterImage.value = indexPath.item
        case .synopsis, .cast:
            print("이 친구들은 기능이 없습니다!")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard viewModel.sectionTypes.first == .backDrop,
              indexPath.section == 0,
              let backdropCell = cell as? BackDropCollectionViewCell else { return }
        
        // 페이지 컨트롤 업데이트
        backdropCell.pageControl.currentPage = indexPath.item
        print("현재 페이지: \(indexPath.item)")
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
            
            let date = viewModel.detailMovieInfoModel.releaseDate
            let rating = String(viewModel.detailMovieInfoModel.voteAverage)
            var genres = viewModel.detailMovieInfoModel.genreIDs
            genres = genres.filter { $0 == genres[0] || $0 == genres[1] }
            let genresStr = genres.joined(separator: ", ")
            
            footer.configureFooterView(date: date, rating: rating, genres: genresStr)
            
            return footer
        default:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                               withReuseIdentifier: DetailCollectionHeaderView.identifier,
                                                                               for: indexPath) as? DetailCollectionHeaderView
            else { return UICollectionReusableView() }
            
            header.viewModel = self.viewModel
            
            var isMoreHidden: Bool = (indexPath.section != 1)
            if indexPath.section == 1 {
                isMoreHidden = !(viewModel.isTextTruncated ?? false)
            }
            
            header.configureHeaderView(headerTitle: viewModel.sectionHeaderTitles[indexPath.section], isMoreHidden: isMoreHidden)
            
            return header
        }
    }
    
}

extension DetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch viewModel.sectionTypes[section] {
        case .backDrop:
            guard let backDropCnt = viewModel.imageData?.backdrops.count else { return 0 }
            return min(max(backDropCnt, 1), 5)
        case .synopsis:
            return 1
        case .cast:
            guard let castCnt = viewModel.castData?.count else {return 0}
            return castCnt
        case .poster:
            guard let posterCnt = viewModel.imageData?.posters.count else {return 0}
            return max(1, posterCnt)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.sectionTypes[indexPath.section] {
        case .backDrop:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BackDropCollectionViewCell.cellIdentifier, for: indexPath) as! BackDropCollectionViewCell
            guard let backDropCnt = viewModel.imageData?.backdrops.count else {return UICollectionViewCell()}
            
            switch backDropCnt == 0 {
            case true:
                cell.configureBackDropCell(imageUrlPath: "", backDropImageCnt: backDropCnt)
                return cell
            case false:
                let item = viewModel.imageData?.backdrops[indexPath.item]
                cell.configureBackDropCell(imageUrlPath: item?.filePath ?? "", backDropImageCnt: min(max(backDropCnt, 1), 5))
                return cell
            }
        case .synopsis:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SynopsisCollectionViewCell.cellIdentifier, for: indexPath) as! SynopsisCollectionViewCell
            cell.configureCell(contentText: viewModel.detailMovieInfoModel.overview, numberOfLines: viewModel.synopsisNumberOfLines)
            
            //async를 사용하여 위 cell이 3줄 넘는 내용인지 판별
            DispatchQueue.main.async {
                print(Thread.isMainThread, "Thread.isMainThread")
                print("텍스트 잘림 여부:", cell.contentLabel.isTruncated)
                
                self.viewModel.input.checkTextTruncated.value = cell.contentLabel.isTruncated
            }
            
            return cell
            
        case .cast:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.cellIdentifier, for: indexPath) as! CastCollectionViewCell
            
            let item = viewModel.castData?[indexPath.item]
            guard let name = item?.name,
                  let character = item?.character else { return UICollectionViewCell() }
            cell.configureCaseCell(imageUrlPath: item?.profilePath, name: name, engName: character)
            return cell
            
        case .poster:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.cellIdentifier, for: indexPath) as! PosterCollectionViewCell
            guard let posterCnt = viewModel.imageData?.posters.count else {return UICollectionViewCell()}
            switch posterCnt == 0 {
            case true:
                cell.imageView.setEmptyImageView()
                cell.isUserInteractionEnabled = false
                return cell
            case false:
                let item = viewModel.imageData?.posters[indexPath.item]
                cell.configurePosterCell(imageUrlPath: item?.filePath)
                return cell
            }
            
        }
    }
    
}
