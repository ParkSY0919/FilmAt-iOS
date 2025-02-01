//
//  SearchViewModel.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/28/25.
//

import UIKit

final class SearchViewModel {
    
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
    var searchAPIResult: ObservablePattern<Bool> = ObservablePattern(nil)
    var onAlert: ((UIAlertController) -> Void)?
    
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
        LoadingIndicatorManager.showLoading()
        let request = SearchRequestModel(query: searchText, page: page)
        NetworkManager.shared.getTMDBAPI(apiHandler: .getSearchAPI(request: request), responseModel: SearchResponseModel.self) { result, networkResultType in
            switch networkResultType {
            case .success:
                //id: 1401402 예외처리
                self.searchResultList.append(contentsOf: result.results.filter { $0.id != 1401402 })
                if isFromCinema == true {
                    self.currentSearchText = searchText
                    self.isSuccessResponse?()
                } else {
                    self.beforeSearchText = searchText
                }
                self.searchAPIResult.value = true
                //호출 오버 방지
                if result.totalResults - (self.page * 20) < 0 {
                    self.isEnd = true
                }
            default :
                let alert = UIAlertManager.showAlert(title: networkResultType.message, message: "확인 이후 다시 시도해주세요.")
                self.onAlert?(alert)
            }
        } failHandler: { str in
            let alert = UIAlertManager.showAlert(title: str, message: "확인 이후 다시 시도해주세요.")
            self.onAlert?(alert)
        }
        DispatchQueue.main.async {
            LoadingIndicatorManager.hideLoading()
        }
    }
    
}
