//
//  ProfileNicknameViewModel.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/27/25.
//

import Foundation

final class ProfileNicknameViewModel {

    var mbti = [String]()
    var currentImageName: String = ""
    var nicknameText: ObservablePattern<String> = ObservablePattern(nil)
    var inputMbti: ObservablePattern<[String]> = ObservablePattern(Array(repeating: "", count: 4))
    
    var isValidNickname: ObservablePattern<StateLabelType> = ObservablePattern(StateLabelType.none)
    var outputMbtiisValid = false
    
    var outputIsDoneValid: ObservablePattern<Bool> = ObservablePattern(false)
    
    init() {
        bindViewModel()
    }
    
    func bindViewModel() {
        inputMbti.lazyBind { [weak self] mbti in
            guard let self, let mbti else {return}
            self.mbti = mbti
            self.outputMbtiisValid = (!self.mbti.contains("")) ? true : false
            self.isDoneState()
        }
    }
    
    func validateNickname(_ nickname: String) {
        if nickname.count < 2 || nickname.count > 9 {
            isValidNickname.value = StateLabelType.textCountError
            return isDoneState()
        }
        if nickname.range(of: "[@#$%]", options: .regularExpression) != nil {
            isValidNickname.value = StateLabelType.specialCharacterError
            return isDoneState()
        }
        if nickname.range(of: "[0-9]", options: .regularExpression) != nil {
            isValidNickname.value = StateLabelType.numberError
            return isDoneState()
        }
        isValidNickname.value = StateLabelType.success
        return isDoneState()
    }
    
    func isDoneState() {
        outputIsDoneValid.value = (isValidNickname.value == .success && outputMbtiisValid == true) ? true : false
    }
    
}
