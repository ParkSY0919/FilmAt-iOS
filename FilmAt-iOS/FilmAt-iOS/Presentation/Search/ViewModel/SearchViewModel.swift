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
    var beforeSearchText = ""
    var currentSearchText = ""
    var page = 1
    var isEnd = false
    var likeMovieListDic = [String: Bool]()
    var isSuccessResponse: (() -> Void)?
    
    var searchResultList: [SearchResult] = []
    var isSearchAPICallSuccessful: ObservablePattern<String> = ObservablePattern("")
    
    internal func transform() {
        
    }
    
}

extension SearchViewModel {
    
    func checkDuplicateSearchText() -> Bool {
        if beforeSearchText == currentSearchText {
            return true
        } else {
            return false
        }
    }
    
    func resetSearchListWithPage() {
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
