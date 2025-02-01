//
//  FailureErrorType.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 2/1/25.
//

import Foundation

enum FailureErrorType {
    case notConnectedToInternet
    case timedOut
    case cannotFindHost
    case cannotConnectToHost
    case secureConnectionFailed
    case badServerResponse
    case unknown

    var message: String {
        switch self {
        case .notConnectedToInternet:
            return "❌ 인터넷이 연결되지 않았습니다. Wi-Fi 또는 셀룰러 데이터를 확인하세요."
        case .timedOut:
            return "⏳ 요청 시간이 초과되었습니다. 다시 시도하세요."
        case .cannotFindHost:
            return "🔍 서버를 찾을 수 없습니다. URL을 확인하세요."
        case .cannotConnectToHost:
            return "🚫 서버에 연결할 수 없습니다. 서버가 다운되었거나 방화벽에 의해 차단되었을 수 있습니다."
        case .secureConnectionFailed:
            return "🔒 보안 연결에 실패했습니다. SSL 인증서를 확인하세요."
        case .badServerResponse:
            return "⚠️ 서버에서 잘못된 응답이 왔습니다. 나중에 다시 시도하세요."
        case .unknown:
            return "❗️ 알 수 없는 오류 발생"
        }
    }

    static func handleNetworkError(_ error: Error) -> FailureErrorType {
        let nsError = error as NSError
        switch URLError.Code(rawValue: nsError.code) {
        case .notConnectedToInternet:
            return .notConnectedToInternet
        case .timedOut:
            return .timedOut
        case .cannotFindHost:
            return .cannotFindHost
        case .cannotConnectToHost:
            return .cannotConnectToHost
        case .secureConnectionFailed:
            return .secureConnectionFailed
        case .badServerResponse:
            return .badServerResponse
        default:
            return .unknown
        }
    }
}
