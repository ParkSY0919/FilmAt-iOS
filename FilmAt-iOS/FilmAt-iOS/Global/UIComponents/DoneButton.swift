//
//  DoneButton.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/26/25.
//

import UIKit

import SnapKit
import Then

final class DoneButton: BaseView {
    
    let doneButton = UIButton()
    private let title: String
    var doneBtnState: DoneButtonState
    var isProfileBtn: Bool
    
    init(title: String, doneBtnState: DoneButtonState, isProfileBtn: Bool = false) {
        self.title = title
        self.doneBtnState = doneBtnState
        self.isProfileBtn = isProfileBtn
        
        super.init(frame: .zero)
    }
    
    override func setHierarchy() {
        self.addSubview(doneButton)
    }
    
    override func setLayout() {
        doneButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setStyle() {
        doneButton.do {
            $0.clipsToBounds = true
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 45/2
            $0.layer.borderColor = doneBtnState.borderColor
            $0.backgroundColor = isProfileBtn ? doneBtnState.backgroundColor : .clear
            $0.setTitle(title, for: .normal)
            let titleColor = isProfileBtn ? UIColor(resource: .title) : doneBtnState.titleColor
            $0.setTitleColor(titleColor, for: .normal)
        }
    }
    
    func changeDoneBtnState() {
        doneButton.do {
            $0.layer.borderColor = doneBtnState.borderColor
            $0.backgroundColor = isProfileBtn ? doneBtnState.backgroundColor : .clear
            let titleColor = isProfileBtn ? UIColor(resource: .title) : doneBtnState.titleColor
            $0.setTitleColor(titleColor, for: .normal)
        }
    }
    
}
