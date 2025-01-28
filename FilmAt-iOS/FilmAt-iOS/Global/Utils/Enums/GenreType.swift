//
//  GenreType.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/28/25.
//

import Foundation

enum GenreType: Int {
    case action = 28
    case animation = 16
    case crime = 80
    case drama = 18
    case fantasy = 14
    case horror = 27
    case mystery = 9648
    case sf = 878
    case thriller = 53
    case western = 37
    case adventure = 12
    case comedy = 35
    case documentary = 99
    case family = 10751
    case history = 36
    case music = 10402
    case romance = 10749
    case tvMovie = 10770
    case war = 10752
    
    var name: String {
        switch self {
        case .action:
            return "액션"
        case .animation:
            return "애니메이션"
        case .crime: 
            return "범죄"
        case .drama:
            return "드라마"
        case .fantasy:
            return "판타지"
        case .horror:
            return "공포"
        case .mystery:
            return "미스터리"
        case .sf:
            return "SF"
        case .thriller:
            return "스릴러"
        case .western:
            return "서부"
        case .adventure:
            return "모험"
        case .comedy:
            return "코미디"
        case .documentary:
            return "다큐멘터리"
        case .family:
            return "가족"
        case .history:
            return "역사"
        case .music:
            return "음악"
        case .romance:
            return "로맨스"
        case .tvMovie:
            return "TV 영화"
        case .war:
            return "전쟁"
        }
    }
}
