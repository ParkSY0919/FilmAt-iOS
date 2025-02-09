//
//  StateLabelType.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/27/25.
//

import UIKit

enum StateLabelType {
    case success
    case textCountError
    case specialCharacterError
    case numberError
    case none
    
    var text: String {
        switch self {
        case .success:
            return "사용할 수 있는 닉네임이에요"
        case .textCountError:
            return "2글자 이상, 10글자 미만으로 설정해주세요"
        case .specialCharacterError:
            return "닉네임에 @, #, $, % 는 포함할 수 없어요"
        case .numberError:
            return "닉네임에 숫자는 포함할 수 없어요"
        case .none:
            return " "
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .success:
            return UIColor(resource: .validDoneBtn)
        default:
            return UIColor(resource: .notValidStateLabel)
        }
    }
}

