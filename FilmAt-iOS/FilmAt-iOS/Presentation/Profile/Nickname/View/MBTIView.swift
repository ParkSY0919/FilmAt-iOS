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
    
    var overBtnTitle: String = "키"
    let underBtnTitle: String
    
    let stackView = UIStackView()
    let overBtn = UIButton()
    let underBtn = UIButton()
    
    
    init(overBtnTitle: String, underBtnTitle: String) {
        self.overBtnTitle = overBtnTitle
        self.underBtnTitle = underBtnTitle
        
        super.init(frame: .zero)
    }
    
    override func setHierarchy() {
        self.addSubview(stackView)
        stackView.addArrangedSubviews(overBtn, underBtn)
    }
    
    override func setLayout() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        [overBtn, underBtn].forEach { i in
            i.snp.makeConstraints {
                $0.size.equalTo(65)
            }
        }
        
    }
    
    override func setStyle() {
        stackView.do {
            $0.axis = .vertical
            $0.distribution = .equalSpacing
            $0.spacing = 10
        }
        
        
        
        let buttonStateHandler: UIButton.ConfigurationUpdateHandler = { button in
            var updatedConfig = button.configuration // 현재 설정 가져오기
            switch button.state {
            case .normal:
                updatedConfig?.baseBackgroundColor = UIColor.white
                updatedConfig?.baseForegroundColor = UIColor(resource: .notValidDoneBtn)
            case .selected:
                updatedConfig?.baseBackgroundColor = UIColor(resource: .validDoneBtn)
                updatedConfig?.baseForegroundColor = UIColor(resource: .title)
            default:
                return
            }
            button.configuration = updatedConfig // 수정된 설정 적용
        }

        
        
        [overBtn, underBtn].forEach { (i: UIButton) in
            i.do {
                $0.layer.cornerRadius = 65/2
                $0.layer.borderWidth = 2
                $0.layer.borderColor = UIColor(resource: .notValidDoneBtn).cgColor
                var config = UIButton.Configuration.plain()
                config.title = (i == overBtn) ? overBtnTitle : underBtnTitle
                config.baseBackgroundColor = .white
                config.baseForegroundColor = UIColor(resource: .notValidDoneBtn)
                $0.configuration = config
                $0.configurationUpdateHandler = buttonStateHandler
                $0.addTarget(self, action: #selector(settt), for: .touchUpInside)
            }
        }
    }
    
    @objc
    func settt(_ sender: UIButton) {
        sender.isSelected = true
    }
    
}

