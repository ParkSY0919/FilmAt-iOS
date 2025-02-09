//
//  MBTIButton.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 2/9/25.
//

import UIKit

import SnapKit
import Then

final class MBTIButton: BaseView {
    
    var onSelectionChanged: ((String) -> Void)?
    
    private let overBtnTitle: String
    private let underBtnTitle: String
    
    private let stackView = UIStackView()
    private let overBtn = UIButton()
    private let underBtn = UIButton()
    
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
        
        [overBtn, underBtn].forEach { (i: UIButton) in
            setMBTIBtnStyle(btn: i)
        }
    }
    
    private func setMBTIBtnStyle(btn: UIButton) {
        let buttonStateHandler: UIButton.ConfigurationUpdateHandler = { button in
            switch button.state {
            case .normal:
                button.layer.backgroundColor = UIColor.white.cgColor
                button.configuration?.baseForegroundColor = UIColor(resource: .notValidDoneBtn)
            case .selected:
                button.layer.backgroundColor = UIColor(resource: .validDoneBtn).cgColor
                button.configuration?.baseForegroundColor = UIColor(resource: .title)
            default:
                return
            }
        }
        
        var config = UIButton.Configuration.plain()
        config.title = (btn == overBtn) ? overBtnTitle : underBtnTitle

        btn.configuration = config
        btn.configurationUpdateHandler = buttonStateHandler

        btn.do {
            $0.layer.cornerRadius = 65/2
            $0.layer.borderWidth = 2
            $0.layer.borderColor = UIColor(resource: .notValidDoneBtn).cgColor
            $0.layer.masksToBounds = true
            $0.addTarget(self,
                         action: #selector(mbtiBtnTapped),
                         for: .touchUpInside)
        }
    }
    
    @objc
    func mbtiBtnTapped(_ sender: UIButton) {
        print(#function)
        let isOverBtn = (sender == overBtn)
        overBtn.isSelected = isOverBtn
        underBtn.isSelected = !isOverBtn
        let currentTitle = sender.configuration?.title ?? ""
        onSelectionChanged?(currentTitle)
    }
    
}
