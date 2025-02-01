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
    var recentSearchList: ObservablePattern<[String]> = ObservablePattern([])
    var likeMovieListDic = [String: Bool]()
    var page = 1
    
    var todayMovieList: [TrendingResult] = []
    var todayMovieAPIResult: ObservablePattern<Bool> = ObservablePattern(nil)
    var onAlert: ((UIAlertController) -> Void)?
}

extension CinemaViewModel {
    
    func getTodayMovieData() {
        LoadingIndicatorManager.showLoading()
        let request = TrendingRequestModel()
        NetworkManager.shared.getTMDBAPI(apiHandler: .getTrendingAPI(request: request), responseModel: TrendingResponseModel.self) { result, networkErrorType in
            print("result: \(request)")
            
            switch networkErrorType {
            case .success:
                self.todayMovieList = result.results
                self.todayMovieAPIResult.value = true
                
            default :
                let alert = UIAlertManager.showAlert(title: networkErrorType.message, message: "확인 이후 다시 시도해주세요.")
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
