//
//  DoneButtonState.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/27/25.
//

import UIKit

enum DoneButtonState {
    case unsatisfied
    case satisfied
    
    var borderColor: CGColor {
        switch self {
        case .unsatisfied:
            return UIColor.gray1.cgColor
        case .satisfied:
            return UIColor.point.cgColor
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .unsatisfied:
            return UIColor(resource: .notValidDoneBtn)
        case .satisfied:
            return UIColor(resource: .validDoneBtn)
        }
    }
    
    var titleColor: UIColor {
        switch self {
        case .unsatisfied:
            return UIColor(resource: .gray2)
        case .satisfied:
            return UIColor(resource: .point)
        }
    }
}
