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
        let isTextFieldReturn: Observable<Void> = Observable(())
    }
    
    struct Output {
        
    }
    
    init() {
        input = Input()
        output = Output()
        
        transform()
    }
    
    var cinemaRecentSearchList: [String]?
    var likedMovieListChange: (([String: Bool]) -> Void)?
    var onChange: ((String) -> Void)?
    
    private var beforeSearchText = ""
    var currentSearchText = ""
    var page = 1
    var isEnd = false
    var likeMovieListDic = [String: Bool]()
    var isSuccessResponse: (() -> Void)?
    
    var searchResultList: [SearchResult] = []
    var isSearchAPICallSuccessful: ObservablePattern<String> = ObservablePattern("")
    
    internal func transform() {
        input.isTextFieldReturn.lazyBind { [weak self] _ in
            guard let self else {return}
            self.checkDuplicateSearchText()
        }
    }
    
}

extension SearchViewModel {
    
    private func checkDuplicateSearchText() {
        if beforeSearchText != currentSearchText {
            guard let researchList = cinemaRecentSearchList else { return }
            
            //최근 검색어 관리 로직
            if let index = researchList.firstIndex(of: currentSearchText) {
                //현재 검색어가 list에 있을 때
                cinemaRecentSearchList?.remove(at: index)
            }
            var list = cinemaRecentSearchList?.reversed() ?? []
            list.append(currentSearchText)
            UserDefaultsManager.shared.recentSearchList = list.reversed()
            self.cinemaRecentSearchList = list.reversed()
            
            resetSearchListWithPage()
            getSearchData(searchText: currentSearchText, page: page)
        }
    }
    
    private func resetSearchListWithPage() {
        self.searchResultList.removeAll()
        self.page = 1
    }
    
    func getSearchData(searchText: String, page: Int, isFromCinema: Bool? = false) {
        let request = SearchRequestModel(query: searchText, page: page)
        
        NetworkManager.shared.getTMDBAPIRefactor(apiHandler: .getSearchAPI(request: request), responseModel: SearchResponseModel.self) { response in
            switch response {
            case .success(let success):
                print("!!!success: \(success)")
                self.searchResultList.append(contentsOf: success.results.filter { $0.id != 1401402 })
                if isFromCinema == true {
                    self.currentSearchText = searchText
                    self.isSuccessResponse?()
                } else {
                    self.beforeSearchText = searchText
                }
                self.isSearchAPICallSuccessful.value = "true"
                //호출 오버 방지
                if success.totalResults - (self.page * 20) < 0 {
                    self.isEnd = true
                }
            case .failure(let failure):
                print("!!!failure: \(failure)")
                self.isSearchAPICallSuccessful.value = failure.localizedDescription
            }
        }
    }
    
}
