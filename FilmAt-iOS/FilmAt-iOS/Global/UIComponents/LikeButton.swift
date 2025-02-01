//
//  LikeButton.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/28/25.
//

import UIKit

import SnapKit
import Then

final class LikeButton: BaseView {
    
    let likeButton = UIButton()
    
    var onTapLikeButton: ((Bool) -> Void)?
    
    override func setHierarchy() {
        self.addSubview(likeButton)
    }
    
    override func setLayout() {
        likeButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setStyle() {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "heart")
        config.baseForegroundColor = UIColor(resource: .point)
        config.baseBackgroundColor = .clear
        likeButton.configuration = config
        
        let buttonStateHandler: UIButton.ConfigurationUpdateHandler = { button in
            switch button.state {
            case .normal:
                button.configuration?.image = UIImage(systemName: "heart")
            case .selected:
                button.configuration?.image = UIImage(systemName: "heart.fill")
            default:
                return
            }
        }
        likeButton.configurationUpdateHandler = buttonStateHandler
        
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
    
    func configureLikeBtn(isLiked: Bool) {
        likeButton.isSelected = isLiked
    }
    
    @objc
    private func likeButtonTapped() {
        likeButton.isSelected.toggle()
        onTapLikeButton?(likeButton.isSelected)
    }
    
}
