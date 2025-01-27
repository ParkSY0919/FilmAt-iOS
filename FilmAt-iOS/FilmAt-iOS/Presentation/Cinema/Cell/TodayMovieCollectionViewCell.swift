//
//  TodayMovieCollectionViewCell.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/27/25.
//

import UIKit

import SnapKit
import Then

final class TodayMovieCollectionViewCell: BaseCollectionViewCell {
    
    private let posterImage = UIImageView()
    private let movieTitleLabel = UILabel()
    private let likeButton = UIButton()
    private let subtitleLabel = UILabel()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        likeButton.setImage(nil, for: .normal)
    }
    
    override func setHierarchy() {
        contentView.addSubviews(posterImage,
                                movieTitleLabel,
                                likeButton,
                                subtitleLabel)
    }
    
    override func setLayout() {
        subtitleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().inset(10)
        }
        
        movieTitleLabel.snp.makeConstraints {
            $0.bottom.equalTo(subtitleLabel.snp.top).offset(-4)
            $0.leading.equalToSuperview()
        }
        
        likeButton.snp.makeConstraints {
            $0.bottom.equalTo(movieTitleLabel.snp.bottom)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(movieTitleLabel.snp.height)
            $0.width.equalTo(likeButton.snp.width)
        }
        
        posterImage.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(movieTitleLabel.snp.top).offset(-4)
        }
        
    }
    
    override func setStyle() {
        posterImage.do {
            $0.setImageView(image: UIImage(resource: .profile10), cornerRadius: 10)
            $0.layer.borderWidth = 0
            $0.contentMode = .scaleAspectFill
        }
        
        subtitleLabel.setLabelUI("subtitleLabelsubtitleLabelsubtitleLabelsubtitleLabelsubtitleLabel",
                                 font: .filmAtFont(.body_medium_12),
                                 textColor: .title,
                                 numberOfLines: 2)
        
        movieTitleLabel.setLabelUI("movieTitleLabel",
                                   font: .filmAtFont(.title_heavy_16),
                                   textColor: .title)
        
        likeButton.do {
            $0.setImage(UIImage(systemName: "heart"), for: .normal)
            $0.tintColor = UIColor(resource: .point)
        }
    }
    
    func setTodayMovieCellUI() {
        likeButton.do {
            $0.setImage(UIImage(systemName: "heart"), for: .normal)
            $0.tintColor = UIColor(resource: .point)
        }
    }
    
}
