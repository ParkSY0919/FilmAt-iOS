//
//  CinemaViewController.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/27/25.
//

import UIKit

final class CinemaViewController: BaseViewController {
    
    private let viewModel: CinemaViewModel
    
    private let cinemaView = CinemaView()
    
    init(viewModel: CinemaViewModel) {
        self.viewModel = viewModel
        
        super.init(navTitle: "FilmAt", navRightBtnType: .search)
    }
    
    override func loadView() {
        view = cinemaView
        viewModel.getTodayMovieData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setUserDefaultsData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegate()
        setAddTarget()
        bindViewModel()
    }

    override func searchBtnTapped() {
        print(#function)
        
        let cinemaRecentSearchList = viewModel.output.recentSearchList.value
        let likeMovieListDic = viewModel.likeMovieListDic
        let searchViewModel = SearchViewModel(cinemaRecentSearchList: cinemaRecentSearchList, likeMovieListDic: likeMovieListDic)
        
        let vc = SearchViewController(viewModel: searchViewModel)
        viewTransition(viewController: vc, transitionStyle: .push)
        
        //추후 LikeButtonManager로 대체
        searchViewModel.likedMovieListChange = { likeMovieListDic in
            print("searchViewModel.likedMovieListChange = { likeMovieListDic in")
            self.viewModel.likeMovieListDic = likeMovieListDic
            self.viewModel.output.configureProfileBox.value = ()
        }
    }

}

private extension CinemaViewController {
    
    func setUserDefaultsData() {
        viewModel.input.prepareUserDefaultsData.value = ()
    }
    
    func setDelegate() {
        cinemaView.recentSearchCollectionView.delegate = self
        cinemaView.recentSearchCollectionView.dataSource = self
        
        cinemaView.todayMovieCollectionView.delegate = self
        cinemaView.todayMovieCollectionView.dataSource = self
    }
    
    func setAddTarget() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileBoxTapped))
        cinemaView.profileBox.addGestureRecognizer(tapGesture)
        
        let resetTapGesture = UITapGestureRecognizer(target: self, action: #selector(recentSearchResetBtnTapped))
        cinemaView.recentSearchResetButton.addGestureRecognizer(resetTapGesture)
    }
    
    func bindViewModel() {
        viewModel.output.configureProfileBox.lazyBind { [weak self] in
            self?.cinemaView.profileBox.changeProfileBoxData()
        }
        
        viewModel.output.recentSearchList.lazyBind { [weak self] data in
            DispatchQueue.main.async {
                self?.cinemaView.setRecentSearchListState(isEmpty: data.isEmpty)
                self?.cinemaView.recentSearchCollectionView.reloadData()
            }
        }
        
        viewModel.output.todayMovieList.lazyBind { [weak self] list in
            if !list.isEmpty {
                DispatchQueue.main.async {
                    self?.cinemaView.todayMovieCollectionView.reloadData()
                }
            }
        }
        
        viewModel.output.isTodayMoviewAPICallError.lazyBind { [weak self] isError in
            guard let self, let isError else {return}
            switch isError == "false" {
            case true:
                DispatchQueue.main.async {
                    self.cinemaView.todayMovieCollectionView.reloadData()
                }
            case false:
                let alert = UIAlertManager.showAlert(title: "에러", message: isError)
                self.viewTransition(viewController: alert, transitionStyle: .present)
            }
        }
        
        viewModel.output.setSearchViewModel.lazyBind { [weak self] searchVM in
            guard let self, let searchVM else {return}
            let searchViewModel = searchVM
            searchViewModel.getSearchData(searchText: viewModel.recentSeachText, page: 1)
            
            let vc = SearchViewController(viewModel: searchViewModel)
            self.viewTransition(viewController: vc, transitionStyle: .push)
        }
        
        viewModel.output.setDetailViewModel.lazyBind { [weak self] detailVM in
            guard let self, let detailVM else {return}
            let detailViewModel = detailVM
            detailViewModel.likeMovieListDic = viewModel.likeMovieListDic
            detailViewModel.fetchDetailData(movieID: viewModel.detailViewMoviewID) {
                DispatchQueue.main.async {
                    let vc = DetailViewController(viewModel: detailViewModel)
                    self.viewTransition(viewController: vc, transitionStyle: .push)
                }
            }
            
            detailViewModel.likedMovieListChange = { likeMovieListDic in
                self.viewModel.likeMovieListDic = likeMovieListDic
                self.viewModel.output.isTodayMoviewAPICallError.value = "false"
            }
        }
    }
    
    func returnCinemaCollectionType(collectionView: UICollectionView) -> CinemaCollectionViewType {
        if collectionView == cinemaView.recentSearchCollectionView {
            return .recentSearch
        } else {
            return .todayMovie
        }
    }
    
    @objc
    func profileBoxTapped() {
        print(#function)
        let profileNicknameViewModel = ProfileNicknameViewModel()
        let vc = ProfileNicknameViewController(viewModel: profileNicknameViewModel, isPushType: false)
        vc.onChange = { [weak self] in
            //프로필 박스 새로고침
            self?.viewModel.input.prepareProfileBox.value = ()
        }
        viewTransition(viewController: vc, transitionStyle: .presentWithNav)
    }
    
    @objc
    func recentSearchResetBtnTapped() {
        print(#function)
        //reset은 index 범주에서 벗어난 -1 대입
        viewModel.input.changeRecentSearchList.value = -1
    }
    
    @objc
    func xMarkBtnTapped(_ sender: UIButton) {
        print(#function, "sender.tag : \(sender.tag)")
        //reset이 아닌 경우 index 값 대입
        viewModel.input.changeRecentSearchList.value = sender.tag
    }
    
}

extension CinemaViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch returnCinemaCollectionType(collectionView: collectionView) {
        case .recentSearch:
            viewModel.input.prepareSearchViewModel.value = indexPath.item
        case .todayMovie:
            viewModel.input.prepareDetailViewModel.value = indexPath.item
        }
    }
    
}

extension CinemaViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch returnCinemaCollectionType(collectionView: collectionView) {
        case .recentSearch:
            return viewModel.output.recentSearchList.value.count
        case .todayMovie:
            return viewModel.output.todayMovieList.value.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch returnCinemaCollectionType(collectionView: collectionView) {
        case .recentSearch:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentSearchCollectionViewCell.cellIdentifier, for: indexPath) as! RecentSearchCollectionViewCell
            
            cell.xMarkbutton.addTarget(self, action: #selector(xMarkBtnTapped), for: .touchUpInside)
            cell.xMarkbutton.tag = indexPath.item
            let recentSeachList = viewModel.output.recentSearchList.value
            
            cell.setCellUI(titleText: recentSeachList[indexPath.item])
            
            return cell
        case .todayMovie:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayMovieCollectionViewCell.cellIdentifier, for: indexPath) as! TodayMovieCollectionViewCell
            
            let item = viewModel.output.todayMovieList.value[indexPath.item]
            cell.likeBtnComponent.configureLikeBtn(isLiked: viewModel.likeMovieListDic[String(item.id)] ?? false)
            
            cell.likeBtnComponent.onTapLikeButton = { [weak self] isSelected in
                guard let self = self else { return }
                if isSelected {
                    self.viewModel.likeMovieListDic[String(item.id)] = true
                } else {
                    self.viewModel.likeMovieListDic[String(item.id)] = nil
                }
                UserDefaultsManager.shared.likeMovieListDic = self.viewModel.likeMovieListDic
                UserDefaultsManager.shared.saveMovieCount = self.viewModel.likeMovieListDic.count
                cinemaView.profileBox.changeProfileBoxData()
            }
            
            let imageURL = item.posterPath
            let title = item.title
            let subtitle = item.overview
            cell.setTodayMovieCellUI(imageURL: imageURL, title: title, subtitle: subtitle)
            
            return cell
        }
    }
    
}
