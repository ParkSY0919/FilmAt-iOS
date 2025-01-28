//
//  UITextField+.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/27/25.
//

import UIKit

extension UITextField {
    
    //검색 결과 있을 시 돋보기 tint color 변경 기능 추후 구현
    func setLeftPadding(amount: CGFloat, image: UIImage? = nil, inset: CGFloat = 0) {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: amount + inset, height: self.frame.size.height))
        
        switch image == nil {
        case true:
            let paddingView = UIView(frame: CGRect(x: inset, y: 0, width: amount, height: self.frame.size.height))
            containerView.addSubview(paddingView)
        case false:
            let imageView = UIImageView(frame: CGRect(x: inset, y: 0, width: amount, height: self.frame.size.height))
            imageView.image = image
            imageView.tintColor = .gray1
            imageView.contentMode = .center
            
            containerView.addSubview(imageView)
        }
        
        self.leftView = containerView
        self.leftViewMode = .always
    }
    
    //TextField placeholder 커스텀
    func setPlaceholder(placeholder: String, fontColor: UIColor?, font: UIFont) {
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: fontColor!, .font: font])
    }
    
}


