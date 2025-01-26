//
//  UILabel+.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/25/25.
//
import UIKit

extension UILabel {
    
    // 모서리둥글게
    func roundedLabel(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
    }
    
    // 특정 텍스트의 색상을 변경해주고, 문단 간격 설정해주는 메소드
    func setAttributedText(fullText: String, pointText: String, pointColor: UIColor, lineHeight: CGFloat) {
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: pointText)
        if range.location != NSNotFound {
            attributedString.addAttribute(.foregroundColor, value: pointColor, range: range)
        }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineHeight
        paragraphStyle.alignment = self.textAlignment
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        self.attributedText = attributedString
    }
    
    // 기본 라벨 속성 설정 메소드
    func setLabelUI(_ text: String,
                    font: UIFont,
                    textColor: UIColor = UIColor(resource: .title),
                    alignment: NSTextAlignment = .left,
                    numberOfLines: Int = 1) {
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = alignment
        self.numberOfLines = numberOfLines
    }
    
}

