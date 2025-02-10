//
//  ProfileNicknameViewModel.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/27/25.
//

import Foundation

final class ProfileNicknameViewModel: ViewModelProtocol {
    
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        var nicknameText: ObservablePattern<String> = ObservablePattern(nil)
        var mbti: ObservablePattern<[String]> = ObservablePattern(Array(repeating: "", count: 4))
    }
    
    struct Output {
        var isValidNickname: ObservablePattern<StateLabelType> = ObservablePattern(StateLabelType.success)
        var isDoneValid: ObservablePattern<Bool> = ObservablePattern(false)
    }

    var mbti = [String]()
    var currentImageName: String = ""
    var outputMbtiisValid = false
    
    init() {
        input = Input()
        output = Output()
        
        transform()
    }
    
    internal func transform() {
        input.mbti.lazyBind { [weak self] mbti in
            guard let self, let mbti else {return}
            self.mbti = mbti
            self.outputMbtiisValid = (!self.mbti.contains("")) ? true : false
            self.isDoneState()
        }
    }
    
    
    func validateNickname(_ nickname: String) {
        if nickname.count < 2 || nickname.count > 9 {
            output.isValidNickname.value = StateLabelType.textCountError
            return isDoneState()
        }
        if nickname.range(of: "[@#$%]", options: .regularExpression) != nil {
            output.isValidNickname.value = StateLabelType.specialCharacterError
            return isDoneState()
        }
        if nickname.range(of: "[0-9]", options: .regularExpression) != nil {
            output.isValidNickname.value = StateLabelType.numberError
            return isDoneState()
        }
        output.isValidNickname.value = StateLabelType.success
        return isDoneState()
    }
    
    private func isDoneState() {
        output.isDoneValid.value = (output.isValidNickname.value == .success && outputMbtiisValid == true) ? true : false
    }
    
}
