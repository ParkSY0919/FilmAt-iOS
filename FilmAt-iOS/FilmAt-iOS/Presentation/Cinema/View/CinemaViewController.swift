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
        
        let cinemaRecentSearchList = viewModel.recentSearchList.value ?? []
        let likeMovieListDic = viewModel.likeMovieListDic
        let searchViewModel = SearchViewModel(cinemaRecentSearchList: cinemaRecentSearchList, likeMovieListDic: likeMovieListDic)
        
        let vc = SearchViewController(viewModel: searchViewModel)
        viewTransition(viewController: vc, transitionStyle: .push)
        
        searchViewModel.likedMovieListChange = { likeMovieListDic in
            print("searchViewModel.likedMovieListChange = { likeMovieListDic in")
            self.viewModel.likeMovieListDic = likeMovieListDic
            self.viewModel.todayMovieAPIResult.value = true
        }
    }

}

private extension CinemaViewController {
    
    func setUserDefaultsData() {
        viewModel.recentSearchList.value = UserDefaultsManager.shared.recentSearchList
        viewModel.likeMovieListDic = UserDefaultsManager.shared.likeMovieListDic
        UserDefaultsManager.shared.saveMovieCount = viewModel.likeMovieListDic.count
        cinemaView.profileBox.changeProfileBoxData()
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
        viewModel.onAlert = { [weak self] alert in
            self?.present(alert, animated: true)
        }
        
        viewModel.recentSearchList.bind { [weak self] data in
            guard let data else { return }
            
            DispatchQueue.main.async {
                self?.cinemaView.setRecentSearchListState(isEmpty: data.isEmpty)
                self?.cinemaView.recentSearchCollectionView.reloadData()
            }
        }
        
        viewModel.todayMovieAPIResult.bind { [weak self] flag in
            guard let flag else { return }
            switch flag {
            case true:
                DispatchQueue.main.async {
                    self?.cinemaView.todayMovieCollectionView.reloadData()
                }
            case false:
                print("todayMovieAPIResult false")
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
            self?.cinemaView.profileBox.changeProfileBoxData()
        }
        viewTransition(viewController: vc, transitionStyle: .presentWithNav)
    }
    
    @objc
    func recentSearchResetBtnTapped() {
        print(#function)
        viewModel.recentSearchList.value?.removeAll()
        UserDefaultsManager.shared.recentSearchList = self.viewModel.recentSearchList.value ?? [""]
        //UserDefaults.standard.synchronize() //역시 이건 효과 없군.
        print("UserDefaultsManager.shared.recentSearchList : \(UserDefaultsManager.shared.recentSearchList)")
    }
    
    @objc
    func xMarkBtnTapped(_ sender: UIButton) {
        print(#function, "sender.tag : \(sender.tag)")
        viewModel.recentSearchList.value?.remove(at: sender.tag)
        UserDefaultsManager.shared.recentSearchList = self.viewModel.recentSearchList.value ?? [""]
        print("UserDefaultsManager.shared.recentSearchList : \(UserDefaultsManager.shared.recentSearchList)")
    }
    
}

extension CinemaViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch returnCinemaCollectionType(collectionView: collectionView) {
        case .recentSearch:
            let recentSeachText = (viewModel.recentSearchList.value ?? [])[indexPath.item]
            
            let cinemaRecentSearchList = viewModel.recentSearchList.value ?? []
            let likeMovieListDic = viewModel.likeMovieListDic
            let searchViewModel = SearchViewModel(cinemaRecentSearchList: cinemaRecentSearchList, likeMovieListDic: likeMovieListDic)
            
            searchViewModel.isSuccessResponse = { [weak self] in
                DispatchQueue.main.async {
                    let vc = SearchViewController(viewModel: searchViewModel)
                    self?.viewTransition(viewController: vc, transitionStyle: .push)
                }
            }
            searchViewModel.getSearchData(searchText: recentSeachText, page: 1, isFromCinema: true)
            
        case .todayMovie:
            let selectedTodayMovie = viewModel.todayMovieList[indexPath.item]
            guard let date = selectedTodayMovie.releaseDate,
                  let genreIDs = selectedTodayMovie.genreIDS else { return }
            
            let releaseDate = DateFormatterManager.shard.setDateString(strDate: date, format: "yy.MM.dd")
            let genreIDsStrArr = GenreType.returnGenreName(from: genreIDs) ?? ["실패"]
            let voteAverage = selectedTodayMovie.voteAverage ?? Double(0.0)
            let overView = selectedTodayMovie.overview
            
            let detailViewModel = DetailViewModel(moviewTitle: selectedTodayMovie.title,
                                                  sectionCount: DetailViewSectionType.allCases.count,
                                                  detailMovieInfoModel: DetailMovieInfoModel(moviewId: selectedTodayMovie.id,
                                                                                             releaseDate: releaseDate,
                                                                                             voteAverage: voteAverage,
                                                                                             genreIDs: genreIDsStrArr,
                                                                                             overview: overView))
            
            detailViewModel.likeMovieListDic = viewModel.likeMovieListDic
            detailViewModel.getImageData(movieID: selectedTodayMovie.id)
            
            detailViewModel.endDataLoading = { [weak self] in
                DispatchQueue.main.async {
                    let vc = DetailViewController(viewModel: detailViewModel)
                    self?.viewTransition(viewController: vc, transitionStyle: .push)
                }
            }
            
            detailViewModel.onAlert = { [weak self] alert in
                self?.present(alert, animated: true)
            }
            
            detailViewModel.likedMovieListChange = { likeMovieListDic in
                self.viewModel.likeMovieListDic = likeMovieListDic
                self.viewModel.todayMovieAPIResult.value = true
            }
        }
    }
    
}

extension CinemaViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch returnCinemaCollectionType(collectionView: collectionView) {
        case .recentSearch:
            guard let recentSearchList = viewModel.recentSearchList.value else { return 2 }
            return recentSearchList.count
        case .todayMovie:
            return viewModel.todayMovieList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch returnCinemaCollectionType(collectionView: collectionView) {
        case .recentSearch:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentSearchCollectionViewCell.cellIdentifier, for: indexPath) as! RecentSearchCollectionViewCell
            
            cell.xMarkbutton.addTarget(self, action: #selector(xMarkBtnTapped), for: .touchUpInside)
            cell.xMarkbutton.tag = indexPath.item
            let recentSeachList = viewModel.recentSearchList.value ?? []
            
            cell.setCellUI(titleText: recentSeachList[indexPath.item])
            
            return cell
        case .todayMovie:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayMovieCollectionViewCell.cellIdentifier, for: indexPath) as! TodayMovieCollectionViewCell
            
            let item = viewModel.todayMovieList[indexPath.item]
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
