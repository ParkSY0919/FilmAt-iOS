//
//  SettingView.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/29/25.
//

import UIKit

import SnapKit
import Then

final class SettingView: BaseView {
    
    let profileBox = ProfileBox()
    
    override func setHierarchy() {
        self.addSubviews(profileBox)
    }
    
    override func setLayout() {
        profileBox.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(15)
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.height.equalTo(135)
        }
    }
    
    override func setStyle() {
    }
    
}
