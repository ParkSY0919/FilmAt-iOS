//
//  UIImageView+.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/25/25.
//

import UIKit

import Kingfisher
import SnapKit

extension UIImageView {
    
    func setImageView(image: UIImage, cornerRadius: CGFloat) {
        self.clipsToBounds = true
        self.image = image
        self.contentMode = .scaleAspectFit
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = 1.5
        self.layer.borderColor = .none
    }
    
    //Downsampling 기능 활용하여 메모리 누수 방지
    func setImageKfDownSampling(with urlString: String?, loadImageType: LoadImageType, cornerRadius: Int) {
        var url = ""
        switch urlString == "" || urlString == nil {
        case true:
            self.setEmptyImageView()
        case false:
            guard let urlString else { return }
            switch loadImageType {
            case .thumb:
                url = "https://image.tmdb.org/t/p/w300" + urlString
            case .backdrop:
                url = "https://image.tmdb.org/t/p/w780" + urlString
            case .cast:
                url = "https://image.tmdb.org/t/p/w92" + urlString
            case .poster:
                url = "https://image.tmdb.org/t/p/w185" + urlString
            case .original:
                url = "https://image.tmdb.org/t/p/original" + urlString
            }
            let processor = DownsamplingImageProcessor(size: self.bounds.size)
            self.kf.indicatorType = .activity
            self.kf.setImage(
                with: URL(string: url),
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
    
    func setEmptyImageView(imageStr: String? = "xmark.bin") {
        self.image = UIImage(systemName: imageStr ?? "xmark.bin")
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFit
        self.tintColor = UIColor(resource: .gray1)
    }
    
}
