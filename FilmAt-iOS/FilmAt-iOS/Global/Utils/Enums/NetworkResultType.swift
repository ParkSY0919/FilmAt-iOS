//
//  NetworkResultType.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/25/25.
//

import UIKit

enum NetworkResultType {
    case success
    case badRequest //400
    case unauthorized //401
    case forbidden //403
    case notFound //404
    case serverError //500...
    case anotherError //400...
}
