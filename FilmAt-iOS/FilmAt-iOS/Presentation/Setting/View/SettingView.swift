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
    let settingTableView = UITableView()
    
    override func setHierarchy() {
        self.addSubviews(profileBox, settingTableView)
    }
    
    override func setLayout() {
        profileBox.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(15)
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.height.equalTo(135)
        }
        
        settingTableView.snp.makeConstraints {
            $0.top.equalTo(profileBox.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(210)
        }
    }
    
    override func setStyle() {
        settingTableView.do {
            $0.backgroundColor = UIColor(resource: .background)
            $0.separatorColor = UIColor(resource: .gray1)
            $0.rowHeight = 50
            $0.separatorStyle = .singleLine
            $0.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.cellIdentifier)
        }
    }
    
}
