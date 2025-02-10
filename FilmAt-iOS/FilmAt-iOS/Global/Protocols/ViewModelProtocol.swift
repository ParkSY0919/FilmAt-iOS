//
//  ViewModelProtocol.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 2/11/25.
//

import Foundation

protocol ViewModelProtocol {
    associatedtype Input
    associatedtype Output
    
    func transform()
}
