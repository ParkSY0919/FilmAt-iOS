//
//  CinemaViewModel.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/28/25.
//

import UIKit

final class CinemaViewModel: ViewModelProtocol {
    
    var detailViewMoviewID = 0
    var recentSeachText = ""
    var likeMovieListDic = [String: Bool]()
    
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        let prepareUserDefaultsData: Observable<Void> = Observable(())
        let prepareProfileBox: Observable<Void> = Observable(())
        let changeRecentSearchList: Observable<Int> = Observable(0)
        let prepareSearchViewModel: Observable<Int> = Observable(0)
        let prepareDetailViewModel: Observable<Int> = Observable(0)
    }
    struct Output {
        let configureProfileBox: Observable<Void> = Observable(())
        let recentSearchList: Observable<[String]> = Observable([])
        let todayMovieList: Observable<[TrendingResult]> = Observable([])
        let isTodayMoviewAPICallError: Observable<String?> = Observable("")
        let setSearchViewModel: Observable<SearchViewModel?> = Observable(nil)
        let setDetailViewModel: Observable<DetailViewModel?> = Observable(nil)
    }
    
    init() {
        self.input = Input()
        self.output = Output()
        
        transform()
    }
    
    internal func transform() {
        input.prepareUserDefaultsData.lazyBind { [weak self] _ in
            guard let self else {return}
            output.recentSearchList.value = UserDefaultsManager.shared.recentSearchList
            likeMovieListDic = UserDefaultsManager.shared.likeMovieListDic
            UserDefaultsManager.shared.saveMovieCount = likeMovieListDic.count
            output.configureProfileBox.value = ()
        }
        
        input.prepareProfileBox.lazyBind { [weak self] _ in
            guard let self else {return}
            output.configureProfileBox.value = ()
        }
        
        input.changeRecentSearchList.lazyBind { [weak self] index in
            guard let self else {return}
            if index == -1 {
                output.recentSearchList.value.removeAll()
            } else {
                output.recentSearchList.value.remove(at: index)
            }
            UserDefaultsManager.shared.recentSearchList = output.recentSearchList.value
        }
        
        input.prepareSearchViewModel.lazyBind { [weak self] index in
            guard let self else {return}
            recentSeachText = output.recentSearchList.value[index]
            let cinemaRecentSearchList = output.recentSearchList.value
            
            let searchViewModel = SearchViewModel(cinemaRecentSearchList: cinemaRecentSearchList,
                                                  likeMovieListDic: likeMovieListDic,
                                                  isThroughRecentBtn: true)
            
            output.setSearchViewModel.value = searchViewModel
        }
        
        input.prepareDetailViewModel.lazyBind { [weak self] index in
            guard let self else {return}
            
            let selectedTodayMovie = output.todayMovieList.value[index]
            detailViewMoviewID = selectedTodayMovie.id
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
            
            output.setDetailViewModel.value = detailViewModel
        }
    }
    
}

extension CinemaViewModel {
    
    func getTodayMovieData() {
        let request = TrendingRequestModel()
        NetworkManager.shared.getTMDBAPIRefactor(apiHandler: .getTrendingAPI(request: request), responseModel: TrendingResponseModel.self) { response in
            switch response {
            case .success(let success):
                self.output.todayMovieList.value = success.results
            case .failure(let failure):
                let error = failure.errorDescription
                self.output.isTodayMoviewAPICallError.value = error
            }
            print("result: \(request)")
            
        }
    }
    
}
