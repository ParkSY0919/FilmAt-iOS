//
//  DetailViewModel.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/30/25.
//

import UIKit

final class DetailViewModel: ViewModelProtocol {
    
    let sectionTypes = DetailViewSectionType.allCases
    let sectionHeaderTitles = ["", "Synopsis", "Cast", "Poster"]
    var likeMovieListDic = [String: Bool]()
    var synopsisNumberOfLines = 3
    var likedMovieListChange: (([String: Bool]) -> Void)?
    
    var castData: [Cast]?
    var imageData: ImageResponseModel?
    var isMoreState: ObservablePattern<Bool> = ObservablePattern(true)
    var isTextTruncated: Bool?
    var isFirstLoad = true
    
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        let prepareZoomBackDropImage: Observable<Int> = Observable(-1)
        let prepareZoomPosterImage: Observable<Int> = Observable(-1)
        let checkTextTruncated: Observable<Bool> = Observable(false)
    }
    struct Output {
        let setZoomImage: Observable<UIImageView> = Observable(UIImageView())
    }
    
    let moviewTitle: String
    let sectionCount: Int
    let detailMovieInfoModel: DetailMovieInfoModel
    
    init(moviewTitle: String, sectionCount: Int, detailMovieInfoModel: DetailMovieInfoModel) {
        self.moviewTitle = moviewTitle
        self.sectionCount = sectionCount
        self.detailMovieInfoModel = detailMovieInfoModel
        
        self.input = Input()
        self.output = Output()
        
        transform()
    }
    
    internal func transform() {
        input.prepareZoomBackDropImage.lazyBind { [weak self] index in
            guard let self else {return}
            let item = imageData?.backdrops[index]
            let imageView = UIImageView()
            imageView.setImageKfDownSampling(with: item?.filePath, loadImageType: .original, cornerRadius: 0)
            
            output.setZoomImage.value = imageView
        }
        
        input.prepareZoomPosterImage.lazyBind { [weak self] index in
            guard let self else {return}
            let item = imageData?.posters[index]
            let imageView = UIImageView()
            imageView.setImageKfDownSampling(with: item?.filePath, loadImageType: .original, cornerRadius: 0)
            
            output.setZoomImage.value = imageView
        }
        
        input.checkTextTruncated.lazyBind { [weak self] isTruncated in
            guard let self else {return}
            if isFirstLoad {
                isTextTruncated = isTruncated
                isFirstLoad = false
            }
        }
    }
    
}

extension DetailViewModel {
    
    func fetchDetailData(movieID: Int, completion: @escaping () -> Void) {
        let group = DispatchGroup()
        
        group.enter()
        getImageData(movieID: movieID) {
            group.leave()
        }
        
        group.enter()
        getCreditData(movieID: movieID) {
            group.leave()
        }
        
        group.notify(queue: .main) {
            completion()
        }
    }
    
    private func getImageData(movieID: Int, completion: @escaping () -> Void) {
        NetworkManager.shared.getTMDBAPIRefactor(apiHandler: .getImageAPI(movieID: movieID), responseModel: ImageResponseModel.self) { response in
            switch response {
            case .success(let success):
                self.imageData = success
                completion()
            case .failure(let failure):
                print("에러 발생")
                let error = failure.errorDescription
                print(error ?? "")
            }
        }
    }
    
    private func getCreditData(movieID: Int, completion: @escaping () -> Void) {
        NetworkManager.shared.getTMDBAPIRefactor(apiHandler: .getCreditAPI(movieID: movieID), responseModel: CreditResponseModel.self) { response in
            switch response {
            case .success(let success):
                self.castData = success.cast
                completion()
            case .failure(let failure):
                print("에러 발생")
                let error = failure.errorDescription
                print(error ?? "")
            }
        }
    }
    
}
