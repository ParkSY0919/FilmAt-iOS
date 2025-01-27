//
//  OnBoardingView.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/26/25.
//

import UIKit

import SnapKit
import Then

final class OnBoardingView: BaseView {
    
    private let mainImageView = UIImageView()
    private let viewTitleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    let startButton = DoneButton(title: "시작하기", doneBtnState: .satisfied)
    
    
    override func setHierarchy() {
        self.addSubviews(mainImageView, viewTitleLabel, subtitleLabel, startButton)
    }
    
    override func setLayout() {
        mainImageView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(30)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-250)
        }
        
        viewTitleLabel.snp.makeConstraints {
            $0.top.equalTo(mainImageView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(viewTitleLabel.snp.bottom).offset(25)
            $0.horizontalEdges.equalToSuperview().inset(40)
            $0.centerX.equalToSuperview()
        }
        
        startButton.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.height.equalTo(45)
        }
    }
    
    override func setStyle() {
        mainImageView.do {
            $0.contentMode = .scaleAspectFill
            $0.image = UIImage(resource: .onboarding)
        }
        
        viewTitleLabel.setLabelUI("Onboarding", font: .italicSystemFont(ofSize: 35, weight: .semibold))
        
        subtitleLabel.setLabelUI("당신만의 영화 세상,\nFilmAt을 시작해보세요.", font: .filmAtFont(.body_regular_16), alignment: .center, numberOfLines: 0)
    }
    
}
