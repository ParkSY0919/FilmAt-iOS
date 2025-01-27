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
    
    init(title: String, doneBtnState: DoneButtonState) {
        self.title = title
        self.doneBtnState = doneBtnState
        
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
            $0.setTitle(title, for: .normal)
            $0.setTitleColor(doneBtnState.titleColor, for: .normal)
        }
    }
    
    func changeDoneBtnState() {
        doneButton.do {
            $0.layer.borderColor = doneBtnState.borderColor
            $0.setTitleColor(doneBtnState.titleColor, for: .normal)
        }
    }
    
}
