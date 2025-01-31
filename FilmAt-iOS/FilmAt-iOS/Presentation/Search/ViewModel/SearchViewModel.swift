//
//  SearchViewModel.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/28/25.
//

import Foundation

final class SearchViewModel {
    
    var cinemaRecentSearchList: [String]?
    var onChange: ((String) -> Void)?
    var beforeSearchText = ""
    var currentSearchText = ""
    var page = 1
    var isEnd = false
    
    var searchResultList: [SearchResult] = []
    var searchAPIResult: ObservablePattern<Bool> = ObservablePattern(nil)
    
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
    
    func getSearchData(searchText: String, page: Int) {
        let request = SearchRequestModel(query: searchText, page: page)
        NetworkManager.shared.getTMDBAPI(apiHandler: .getSearchAPI(request: request), responseModel: SearchResponseModel.self) { result, networkResultType in
            switch networkResultType {
            case .success:
                //id: 1401402 예외처리
                self.searchResultList.append(contentsOf: result.results.filter { $0.id != 1401402 })
                self.beforeSearchText = searchText
                self.searchAPIResult.value = true
                
                //호출 오버 방지
                if result.totalResults - (self.page * 20) < 0 {
                    self.isEnd = true
                }
            case .badRequest:
                print("badRequest")
            case .unauthorized:
                print("unauthorized")
            case .forbidden:
                print("forbidden")
            case .notFound:
                print("notFound")
            case .serverError:
                print("serverError")
            case .anotherError:
                print("anotherError")
            }
        }
    }
    
}
