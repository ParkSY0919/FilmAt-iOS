//
//  SearchViewModel.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/28/25.
//

import Foundation

final class SearchViewModel {
    
    var beforeSearchText = ""
    var currentSearchText = ""
    
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
    
    func getSearchData(searchText: String) {
        let request = SearchRequestModel(query: searchText)
        NetworkManager.shared.getTMDBAPI(apiHandler: .getSearchAPI(request: request), responseModel: SearchResponseModel.self) { result, networkResultType in
            switch networkResultType {
            case .success:
                self.searchResultList = result.results
                self.searchAPIResult.value = true
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
