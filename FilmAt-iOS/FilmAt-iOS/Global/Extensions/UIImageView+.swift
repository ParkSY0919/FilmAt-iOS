//
//  UIImageView+.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/25/25.
//

import UIKit

import Kingfisher

extension UIImageView {
    
    func setImageView(image: UIImage, cornerRadius: CGFloat) {
        self.image = image
        self.contentMode = .scaleAspectFit
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = 0.1
        self.layer.borderColor = .none
    }
    
    //Downsampling 기능 활용하여 메모리 누수 방지
    func setImageKfDownSampling(with urlString: String, cornerRadius: Int) {
        let processor = DownsamplingImageProcessor(size: self.bounds.size)
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: URL(string: urlString),
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ]
        )
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
        self.layer.cornerRadius = CGFloat(cornerRadius)
    }
    
}
