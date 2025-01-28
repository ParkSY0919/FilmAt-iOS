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

    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegate()
        setAddTarget()
        bindViewModel()
    }

    override func searchBtnTapped() {
        print(#function)
        
        let vc = SearchViewController(viewModel: SearchViewModel())
        vc.onChange = { [weak self] searchText in
            var list = self?.viewModel.recentSearchList.value?.reversed() ?? []
            list.append(searchText)
            self?.viewModel.recentSearchList.value = list.reversed()
        }
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
    }
    
    @objc
    func xMarkBtnTapped(_ sender: UIButton) {
        print(#function, "sender.tag : \(sender.tag)")
        viewModel.recentSearchList.value?.remove(at: sender.tag)
    }
    
    @objc
    func likeBtnComponentTapped(_ sender: UIButton) {
        print(#function)
        switch sender.isSelected {
        case true:
            sender.isSelected = false
        case false:
            sender.isSelected = true
        }
    }
    
}

extension CinemaViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch returnCinemaCollectionType(collectionView: collectionView) {
        case .recentSearch:
            let recentSeachList = viewModel.recentSearchList.value ?? []
            print(recentSeachList[indexPath.item])
            
            //추후 search화면으로 변경
//            viewTransition(viewController: OnBoardingViewController(), transitionStyle: .push)
        case .todayMovie:
            let selectedTodayMovie = viewModel.todayMovieList[indexPath.item]
            
            //추후 detail화면으로 변경
            viewTransition(viewController: OnBoardingViewController(), transitionStyle: .push)
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
            
            cell.likeBtnComponent.likeButton.addTarget(self, action: #selector(likeBtnComponentTapped), for: .touchUpInside)
            
            let item = viewModel.todayMovieList[indexPath.item]
            
            let imageURL = item.posterPath
            let title = item.title
            let subtitle = item.overview
            cell.setTodayMovieCellUI(imageURL: imageURL, title: title, subtitle: subtitle)
            
            return cell
        }
    }
    
}
