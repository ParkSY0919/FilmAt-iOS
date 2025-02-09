//
//  MBTIView.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 2/7/25.
//

import UIKit

import SnapKit
import Then

final class MBTIView: BaseView {
    
    weak var delegate: ProfileNicknameViewControllerDelegate?
    
    private let mbtiStackView = UIStackView()
    private let mbti1stView = MBTIButton(overBtnTitle: "E", underBtnTitle: "I")
    private let mbti2ndView = MBTIButton(overBtnTitle: "S", underBtnTitle: "N")
    private let mbti3rdView = MBTIButton(overBtnTitle: "T", underBtnTitle: "F")
    private let mbti4thView = MBTIButton(overBtnTitle: "P", underBtnTitle: "J")
    
    init() {
        super.init(frame: .zero)
        bringCurrentMBTI()
    }
    
    override func setHierarchy() {
        self.addSubview(mbtiStackView)
        
        mbtiStackView.addArrangedSubviews(mbti1stView,
                                          mbti2ndView,
                                          mbti3rdView,
                                          mbti4thView)
    }
    
    override func setLayout() {
        mbtiStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setStyle() {
        mbtiStackView.do {
            $0.axis = .horizontal
            $0.spacing = 10
            $0.alignment = .trailing
            $0.distribution = .equalSpacing
        }
    }
    
    func bringCurrentMBTI() {
        let arr = [mbti1stView, mbti2ndView, mbti3rdView, mbti4thView]
        for i in 0..<arr.count {
            arr[i].onSelectionChanged = { [weak self] currentTitle in
                self?.delegate?.bringCurrentMBTI(index: i, currentMBTI: currentTitle)
            }
        }
    }
    
}

