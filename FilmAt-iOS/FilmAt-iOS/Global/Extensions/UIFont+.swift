//
//  UIFont+.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/25/25.
//

import UIKit

enum FontName {
    case title_heavy_16
    case title_bold_16, body_bold_12
    case body_medium_14, body_bold_14
    case body_medium_12
    case body_regular_16
     
    var fontWeight: UIFont.Weight {
        switch self {
        case .title_heavy_16:
            return .heavy
        case .body_bold_12, .body_bold_14, .title_bold_16:
            return .bold
        case .body_medium_12, .body_medium_14:
            return .medium
        case .body_regular_16:
            return .regular
        }
    }
    
    var size: CGFloat {
        switch self {
        case .title_heavy_16, .title_bold_16, .body_regular_16:
            return 16
        case .body_medium_14, .body_bold_14:
            return 14
        case .body_bold_12, .body_medium_12:
            return 12
        }
    }
    
}

extension UIFont {
    
    static func filmAtFont(_ style: FontName) -> UIFont {
        return UIFont.systemFont(ofSize: style.size, weight: style.fontWeight)
    }
    
    static func italicSystemFont(ofSize size: CGFloat, weight: UIFont.Weight = .regular)-> UIFont {
        let font = UIFont.systemFont(ofSize: size, weight: weight)
        switch weight {
        case .ultraLight, .light, .thin, .regular:
            return font.withTraits(.traitItalic, ofSize: size)
        case .medium, .semibold, .bold, .heavy, .black:
            return font.withTraits(.traitBold, .traitItalic, ofSize: size)
        default:
            return UIFont.italicSystemFont(ofSize: size)
        }
     }
    
     func withTraits(_ traits: UIFontDescriptor.SymbolicTraits..., ofSize size: CGFloat) -> UIFont {
        let descriptor = self.fontDescriptor
            .withSymbolicTraits(UIFontDescriptor.SymbolicTraits(traits))
        return UIFont(descriptor: descriptor!, size: size)
     }
    
}
