//
//  CinemaViewController.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/27/25.
//

import UIKit

enum CinemaCollectionViewType {
    case recentSearch
    case todayMovie
}

final class CinemaViewController: BaseViewController {
    
    private let dummyArr = ["스파이더만", "현빈", "록시땅", "액션가면", "케케몬"]
    
    private let cinemaView = CinemaView()
    
    init() {
        super.init(navTitle: "FilmAt", navRightBtnType: .search)
    }
    
    override func loadView() {
        view = cinemaView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegate()
        setAddTarget()
    }

    override func searchBtnTapped() {
        print(#function)
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
    }
    
}

extension CinemaViewController: UICollectionViewDelegate {
    
}

extension CinemaViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch returnCinemaCollectionType(collectionView: collectionView) {
        case .recentSearch:
            return dummyArr.count
        case .todayMovie:
            return dummyArr.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch returnCinemaCollectionType(collectionView: collectionView) {
        case .recentSearch:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentSearchCollectionViewCell.cellIdentifier, for: indexPath) as! RecentSearchCollectionViewCell
            cell.setCellUI(titleText: dummyArr[indexPath.item])
            
            return cell
        case .todayMovie:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayMovieCollectionViewCell.cellIdentifier, for: indexPath) as! TodayMovieCollectionViewCell
            cell.setTodayMovieCellUI()
            
            return cell
        }
    }
    
}
