//
//  DetailViewModel.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/30/25.
//

import UIKit

final class DetailViewModel {
    
    let moviewTitle: String
    let sectionCount: Int
    let detailMovieInfoModel: DetailMovieInfoModel
    
    let sectionTypes = DetailViewSectionType.allCases
    let sectionHeaderTitles = ["", "Synopsis", "Cast", "Poster"]
    var likeMovieListDic = [String: Bool]()
    
    var synopsisNumberOfLines = 3
    var endDataLoading: (() -> Void)?
    var likedMovieListChange: (([String: Bool]) -> Void)?
    var onAlert: ((UIAlertController) -> Void)?
    
    var imageResponseData: ImageResponseModel?
    var castData: [Cast]?
    
    init(moviewTitle: String, sectionCount: Int, detailMovieInfoModel: DetailMovieInfoModel) {
        self.moviewTitle = moviewTitle
        self.sectionCount = sectionCount
        self.detailMovieInfoModel = detailMovieInfoModel
    }
    
    var isMoreState: ObservablePattern<Bool> = ObservablePattern(true)
    
    var isTextTruncated: Bool?
    var isFirstLoad = true
    
}

extension DetailViewModel {
    
    //왜 무한 인디케이터에서 못 나올까
    
    func getImageData(movieID: Int) {
        LoadingIndicatorManager.showLoading()
        NetworkManager.shared.getTMDBAPI(apiHandler: .getImageAPI(movieID: movieID), responseModel: ImageResponseModel.self) { result, resultType in
            switch resultType {
            case .success:
                self.imageResponseData = result
                self.getCreditData(movieID: movieID)
            default :
                let alert = UIAlertManager.showAlert(title: resultType.message, message: "확인 이후 다시 시도해주세요.")
                self.onAlert?(alert)
            }
        } failHandler: { str in
            let alert = UIAlertManager.showAlert(title: str, message: "확인 이후 다시 시도해주세요.")
            self.onAlert?(alert)
            DispatchQueue.main.async {
                LoadingIndicatorManager.hideLoading()
            }
        }
    }
    
    func getCreditData(movieID: Int) {
        NetworkManager.shared.getTMDBAPI(apiHandler: .getCreditAPI(movieID: movieID), responseModel: CreditResponseModel.self) { result, resultType in
            switch resultType {
            case .success:
                self.castData = result.cast
                self.endDataLoading?()
            default :
                let alert = UIAlertManager.showAlert(title: resultType.message, message: "확인 이후 다시 시도해주세요.")
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



// 네트워크 끊긴 상태에서, cinemaVC에서 디테일 클릭 시 왜 무한 인디케이터일까
