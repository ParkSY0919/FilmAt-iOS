//
//  ProfileImageViewModel.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/27/25.
//

import UIKit

final class ProfileImageViewModel {
    
    init(currentImage: UIImage?) {
        self.currentImage.value = currentImage
    }
    
    var currentImageName: String = ""
    var currentImage: ObservablePattern<UIImage> = ObservablePattern(nil)
    
}
