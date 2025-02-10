//
//  ProfileImageViewModel.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/27/25.
//

import UIKit

final class ProfileImageViewModel: ViewModelProtocol {
    
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        let loadCurrentImageIndex: ObservablePattern<Int> = ObservablePattern(nil)
    }
    
    struct Output {
        let setCurrentImage: ObservablePattern<UIImage> = ObservablePattern(nil)
    }
    
    init(currentImage: UIImage?) {
        input = Input()
        output = Output()
        self.output.setCurrentImage.value = currentImage
        
        transform()
    }
    
    var currentImageName: String = ""
    let profileImageArr = [
        UIImage(resource: .profile0),
        UIImage(resource: .profile1),
        UIImage(resource: .profile2),
        UIImage(resource: .profile3),
        UIImage(resource: .profile4),
        UIImage(resource: .profile5),
        UIImage(resource: .profile6),
        UIImage(resource: .profile7),
        UIImage(resource: .profile8),
        UIImage(resource: .profile9),
        UIImage(resource: .profile10),
        UIImage(resource: .profile11)
    ]
    
    internal func transform() {
        input.loadCurrentImageIndex.lazyBind { [weak self] index in
            guard let self, let index else {return}
            output.setCurrentImage.value = profileImageArr[index]
            currentImageName = "profile_\(index)"
        }
    }
    
}
