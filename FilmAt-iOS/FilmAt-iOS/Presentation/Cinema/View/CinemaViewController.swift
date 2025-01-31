//
//  CinemaViewController.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/27/25.
//

import UIKit

final class CinemaViewController: BaseViewController {
    
    private let dummyArr = ["스파이더만", "현빈", "록시땅", "액션가면", "케케몬"]
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
        
        viewModel.recentSearchList.value = UserDefaultsManager.shared.recentSearchList
        viewModel.likeMovieListDic = UserDefaultsManager.shared.likeMovieListDic
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegate()
        setAddTarget()
        bindViewModel()
    }

    override func searchBtnTapped() {
        print(#function)
        
        let searchViewModel = SearchViewModel()
        searchViewModel.likeMovieListDic = viewModel.likeMovieListDic
        searchViewModel.cinemaRecentSearchList = viewModel.recentSearchList.value
        let vc = SearchViewController(viewModel: searchViewModel)
        viewTransition(viewController: vc, transitionStyle: .push)
    }

}

private extension CinemaViewController {
    
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
        let vc = ProfileNicknameViewController(viewModel: ProfileNicknameViewModel(), isPushType: false)
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
    
    @objc
    func likeBtnComponentTapped(_ sender: UIButton) {
        print(#function)
        let movieID = String(sender.tag)
        switch sender.isSelected {
        case true:
            viewModel.likeMovieListDic[movieID] = nil
            UserDefaultsManager.shared.likeMovieListDic = viewModel.likeMovieListDic
            sender.isSelected = false
        case false:
            viewModel.likeMovieListDic[movieID] = true
            UserDefaultsManager.shared.likeMovieListDic = viewModel.likeMovieListDic
            sender.isSelected = true
        }
    }
    
}

extension CinemaViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch returnCinemaCollectionType(collectionView: collectionView) {
        case .recentSearch:
            let recentSeachText = (viewModel.recentSearchList.value ?? [])[indexPath.item]
            
            let searchViewModel = SearchViewModel()
            searchViewModel.likeMovieListDic = viewModel.likeMovieListDic
            viewModel.getSearchData(recentSearchText: recentSeachText) { result in
                searchViewModel.searchResultList = result
                searchViewModel.currentSearchText = recentSeachText
                searchViewModel.searchAPIResult.value = true
                
                DispatchQueue.main.async {
                    let vc = SearchViewController(viewModel: searchViewModel)
                    self.viewTransition(viewController: vc, transitionStyle: .push)
                }
            }
        case .todayMovie:
            let selectedTodayMovie = viewModel.todayMovieList[indexPath.item]
            guard let date = selectedTodayMovie.releaseDate,
                  let genreIDs = selectedTodayMovie.genreIDS else { return }
            
            let releaseDate = DateFormatterManager.shard.setDateString(strDate: date, format: "yy.MM.dd")
            let genreIDsStrArr = GenreType.returnGenreName(from: genreIDs) ?? ["실패"]
            let voteAverage = selectedTodayMovie.voteAverage ?? Double(0.0)
            let overView = selectedTodayMovie.overview
            
            let detailViewModel = DetailViewModel(moviewTitle: selectedTodayMovie.title, sectionCount: DetailViewSectionType.allCases.count, detailMovieInfoModel: DetailMovieInfoModel(releaseDate: releaseDate, voteAverage: voteAverage, genreIDs: genreIDsStrArr, overview: overView))
            detailViewModel.getImageData(movieID: selectedTodayMovie.id)
            
            detailViewModel.endDataLoading = {
                DispatchQueue.main.async {
                    let vc = DetailViewController(viewModel: detailViewModel)
                    self.viewTransition(viewController: vc, transitionStyle: .push)
                }
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
            
            let likeMovieList = viewModel.likeMovieListDic 
            print("likeMovieList : \(likeMovieList)")
            for i in likeMovieList {
                if i.key == String(item.id) && i.value {
                    cell.likeBtnComponent.likeButton.isSelected = true
                }
            }
            cell.likeBtnComponent.likeButton.tag = item.id
            cell.likeBtnComponent.likeButton.addTarget(self, action: #selector(likeBtnComponentTapped), for: .touchUpInside)
            
            
            
            let imageURL = item.posterPath
            let title = item.title
            let subtitle = item.overview
            cell.setTodayMovieCellUI(imageURL: imageURL, title: title, subtitle: subtitle)
            
            return cell
        }
    }
    
}
