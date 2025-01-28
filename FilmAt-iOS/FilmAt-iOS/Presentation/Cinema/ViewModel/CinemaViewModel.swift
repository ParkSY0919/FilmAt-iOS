//
//  CinemaViewModel.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/28/25.
//

import UIKit

final class CinemaViewModel {
    
    //reversed된 형태로 저장하자.
    //추후 append 필요할 시, reversed로 바꾸고, append하고 다시 reversed 적용하면됨.
    var recentSearchList: ObservablePattern<[String]> = ObservablePattern(["아잉먼", "ㅇㅁㄴㅇ", "123124"])
    
    var todayMovieList: [TrendingResult] = []
    var todayMovieAPIResult: ObservablePattern<Bool> = ObservablePattern(nil)
    
}

extension CinemaViewModel {
    
    func getTodayMovieData() {
        let request = TrendingRequestModel()
        NetworkManager.shared.getTMDBAPI(apiHandler: .getTrendingAPI(request: request), responseModel: TrendingResponseModel.self) { result, networkErrorType in
            print("result: \(request)")
            
            switch networkErrorType {
            case .success:
                self.todayMovieList = result.results
                self.todayMovieAPIResult.value = true
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
    
    func getSearchData(recentSearchText: String, complition: @escaping ([SearchResult]) -> Void) {
        let request = SearchRequestModel(query: recentSearchText)
        NetworkManager.shared.getTMDBAPI(apiHandler: .getSearchAPI(request: request), responseModel: SearchResponseModel.self) { result, resultType in
            switch resultType {
            case .success:
                complition(result.results)
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
