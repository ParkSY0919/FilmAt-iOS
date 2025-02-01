//
//  NetworkResultType.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/25/25.
//

import UIKit

enum NetworkResultType {
    case success
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case serverError
    case anotherError
    
    var message: String {
        switch self {
        case .success:
            return "성공"
        case .badRequest:
            return "잘못된 요청"
        case .unauthorized:
            return "인증되지 않음"
        case .forbidden:
            return "금지됨"
        case .notFound:
            return "찾을 수 없음"
        case .serverError:
            return "서버 오류"
        case .anotherError:
            return "기타 오류"
        }
    }
}
