//
//  CinemaViewModel.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/28/25.
//

import UIKit

final class CinemaViewModel {
    
    var recentSearchList: ObservablePattern<[String]> = ObservablePattern([])
    
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
    
}
