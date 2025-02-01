//
//  NetworkManager.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/26/25.
//

import Foundation

import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    private func returnErrorType(_ statusCode: Int) -> NetworkResultType {
        switch statusCode {
        case (200..<299):
            return .success
        case 400:
            return .badRequest
        case 401:
            return .unauthorized
        case 403:
            return .forbidden
        case 404:
            return .notFound
        case (500...):
            return .serverError
        default:
            return .anotherError
        }
    }
    
    func getTMDBAPI<T: Decodable>(apiHandler: TMDBTargetType,
                                  responseModel: T.Type,
                                  completionHandler: @escaping (T, NetworkResultType) -> Void,
                                  failHandler: @escaping (String) -> Void) {
        AF.request(apiHandler)
            .responseDecodable(of: T.self) { response in
                debugPrint(response)
                switch response.result {
                case .success(let result):
                    print("✅ API 요청 성공")
                    let networkResultType = self.returnErrorType(response.response?.statusCode ?? 0)
                    completionHandler(result, networkResultType)
                case .failure(let error):
                    print("❌ API 요청 실패\n", error)
                    let t = FailureErrorType.handleNetworkError(error)
                    failHandler(t.message)
                }
            }
    }

    
}



