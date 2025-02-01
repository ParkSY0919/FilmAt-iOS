//
//  ProfileNicknameViewModel.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/27/25.
//

import Foundation

final class ProfileNicknameViewModel {
    
    var nicknameText: ObservablePattern<String> = ObservablePattern(nil)
    var isValidNickname: ObservablePattern<StateLabelType> = ObservablePattern(nil)
    var currentImageIndex: Int?
    
    func validateNickname(_ nickname: String) {
        if nickname.count < 2 || nickname.count > 9 {
            return isValidNickname.value = StateLabelType.textCountError
        }
        if nickname.range(of: "[@#$%]", options: .regularExpression) != nil {
            return isValidNickname.value = StateLabelType.specialCharacterError
        }
        if nickname.range(of: "[0-9]", options: .regularExpression) != nil {
            return isValidNickname.value = StateLabelType.numberError
        }
        return isValidNickname.value = StateLabelType.success
    }
    
}
