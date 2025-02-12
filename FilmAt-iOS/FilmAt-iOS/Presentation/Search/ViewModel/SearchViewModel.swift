//
//  SearchViewModel.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/28/25.
//

import UIKit

final class SearchViewModel: ViewModelProtocol {
    
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        let textFieldText: Observable<String?> = Observable("")
        let isTextFieldReturn: Observable<Void> = Observable(())
        let isCallPrefetch: Observable<Void> = Observable(())
        let isFirstPage: Observable<Void> = Observable(())
        let prepareDetailViewModel: Observable<Int> = Observable(0)
    }
    
    struct Output {
        let showScrollToTop: Observable<Void> = Observable(())
        let setDetailViewModel: Observable<DetailViewModel?> = Observable(nil)
        let isSearchAPICallSuccessful: ObservablePattern<String> = ObservablePattern("")
    }
    
    //MARK: - init Property
    private var cinemaRecentSearchList: [String]
    var likeMovieListDic: [String: Bool]
    private let isThroughRecentBtn: Bool
    
    init(cinemaRecentSearchList: [String], likeMovieListDic: [String: Bool], isThroughRecentBtn: Bool = false) {
        self.cinemaRecentSearchList = cinemaRecentSearchList
        self.likeMovieListDic = likeMovieListDic
        self.isThroughRecentBtn = isThroughRecentBtn
        
        input = Input()
        output = Output()
        
        transform()
    }
    
    var searchResultList: [SearchResult] = []
    private var beforeSearchText = ""
    private var currentSearchText = ""
    private var page = 1
    private var isEnd = false
    
    var detailViewMoviewID = 0
    
    var likedMovieListChange: (([String: Bool]) -> Void)?
    var onChange: ((String) -> Void)?
    
    internal func transform() {
        input.isTextFieldReturn.lazyBind { [weak self] _ in
            guard let self else {return}
            self.recentSearchTextHandling()
            self.checkDuplicateSearchText()
        }
        
        input.textFieldText.lazyBind { [weak self] text in
            guard let self, let text else {return}
            currentSearchText = text
        }
        
        input.isFirstPage.lazyBind { [weak self] _ in
            guard let self else {return}
            if page == 1 {
                output.showScrollToTop.value = ()
            }
        }
        
        input.isCallPrefetch.lazyBind { [weak self] _ in
            guard let self else {return}
            if isEnd == false {
                page += 1
                getSearchData(searchText: currentSearchText, page: page)
            } else {
                print("현재 isEnd 아마 true: \(isEnd)")
            }
        }
        
        input.prepareDetailViewModel.lazyBind { [weak self] index in
            guard let self else {return}
            
            let row = self.searchResultList[index]
            self.detailViewMoviewID = row.id
            guard let date = row.releaseDate,
                  let genreIDs = row.genreIDS else { return }
            
            let releaseDate = DateFormatterManager.shard.setDateString(strDate: date, format: "yy.MM.dd")
            let genreIDsStrArr = GenreType.returnGenreName(from: genreIDs) ?? ["실패"]
            let voteAverage = row.voteAverage ?? Double(0.0)
            let overView = row.overview
            
            let detailViewModel = DetailViewModel(moviewTitle: row.title,
                                                  sectionCount: DetailViewSectionType.allCases.count,
                                                  detailMovieInfoModel: DetailMovieInfoModel(moviewId: row.id,
                                                                                             releaseDate: releaseDate,
                                                                                             voteAverage: voteAverage,
                                                                                             genreIDs: genreIDsStrArr,
                                                                                             overview: overView))
            
            output.setDetailViewModel.value = detailViewModel
        }
    }
    
}

extension SearchViewModel {
    
    private func recentSearchTextHandling() {
        let researchList = cinemaRecentSearchList
        
        //최근 검색어 관리 로직
        if let index = researchList.firstIndex(of: currentSearchText) {
            //현재 검색어가 list에 있을 때
            cinemaRecentSearchList.remove(at: index)
        }
        var list = Array(cinemaRecentSearchList.reversed())
        list.append(currentSearchText)
        UserDefaultsManager.shared.recentSearchList = list.reversed()
        self.cinemaRecentSearchList = list.reversed()
        
    }
    
    private func checkDuplicateSearchText() {
        if beforeSearchText != currentSearchText {
            resetSearchListWithPage()
            getSearchData(searchText: currentSearchText, page: page)
        }
    }
    
    private func resetSearchListWithPage() {
        self.searchResultList.removeAll()
        self.page = 1
    }
    
    func getSearchData(searchText: String, page: Int) {
        let request = SearchRequestModel(query: searchText, page: page)
        
        NetworkManager.shared.getTMDBAPIRefactor(apiHandler: .getSearchAPI(request: request), responseModel: SearchResponseModel.self) { response in
            switch response {
            case .success(let success):
                self.searchResultList.append(contentsOf: success.results.filter { $0.id != 1401402 })
                
                self.input.textFieldText.value = searchText
                self.output.isSearchAPICallSuccessful.value = "true"
                
                if self.isThroughRecentBtn {
                    self.beforeSearchText = searchText
                    self.recentSearchTextHandling()
                }
                //호출 오버 방지
                if success.totalResults - (self.page * 20) < 0 {
                    self.isEnd = true
                }
            case .failure(let failure):
                print("!!!failure: \(failure)")
                self.output.isSearchAPICallSuccessful.value = failure.localizedDescription
            }
        }
    }
    
}
