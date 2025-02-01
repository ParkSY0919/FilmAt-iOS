//
//  ProfileImageViewModel.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/27/25.
//

import UIKit

final class ProfileImageViewModel {
    
    init(currentImage: UIImage, imageStr: String) {
        self.currentImage.value = currentImage
        self.imageStr = imageStr
    }
    
    var imageStr: String
    var currentImage: ObservablePattern<UIImage> = ObservablePattern(nil)
    var currentImageIndex: Int?
    var isPush: Bool?
    
}
