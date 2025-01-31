//
//  DetailViewModel.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/30/25.
//

import Foundation

final class DetailViewModel {
    
    let moviewTitle: String
    let sectionCount: Int
    let detailMovieInfoModel: DetailMovieInfoModel
    
    let sectionTypes = DetailViewSectionType.allCases
    let sectionHeaderTitles = ["", "Synopsis", "Cast", "Poster"]
    var synopsisNumberOfLines = 3
    var endDataLoading: (() -> Void)?
    var imageResponseData: ImageResponseModel?
    
    init(moviewTitle: String, sectionCount: Int, detailMovieInfoModel: DetailMovieInfoModel) {
        self.moviewTitle = moviewTitle
        self.sectionCount = sectionCount
        self.detailMovieInfoModel = detailMovieInfoModel
    }
    
    var isMoreState: ObservablePattern<Bool> = ObservablePattern(true)
    var isTextTruncated: ObservablePattern<Bool> = ObservablePattern(nil)
    
}

extension DetailViewModel {
    
    func getImageData(movieID: Int) {
        NetworkManager.shared.getTMDBAPI(apiHandler: .getImageAPI(movieID: movieID), responseModel: ImageResponseModel.self) { result, resultType in
            switch resultType {
            case .success:
                self.imageResponseData = result
                self.endDataLoading?()
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
