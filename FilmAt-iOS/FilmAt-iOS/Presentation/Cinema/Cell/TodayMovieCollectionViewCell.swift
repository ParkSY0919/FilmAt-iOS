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
    let likeBtnComponent = LikeButton()
    private let subtitleLabel = UILabel()
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterImage.image = nil
        movieTitleLabel.text = nil
        subtitleLabel.text = nil
        subtitleLabel.textColor = nil
        likeBtnComponent.likeButton.configuration?.image = nil
    }
    
    override func setHierarchy() {
        contentView.addSubviews(posterImage,
                                movieTitleLabel,
                                likeBtnComponent,
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
        
        likeBtnComponent.snp.makeConstraints {
//            $0.size.equalTo(10)
            $0.bottom.equalTo(movieTitleLabel.snp.bottom)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(movieTitleLabel.snp.height)
            $0.width.equalTo(likeBtnComponent.snp.width)
            
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
        
        likeBtnComponent.likeButton.do {
            $0.setImage(UIImage(systemName: "heart"), for: .normal)
            $0.tintColor = UIColor(resource: .point)
        }
    }
    
    func setTodayMovieCellUI(imageURL: String, title: String, subtitle: String) {
        likeBtnComponent.likeButton.do {
            $0.setImage(UIImage(systemName: "heart"), for: .normal)
            $0.tintColor = UIColor(resource: .point)
        }
        
        posterImage.do {
            $0.setImageKfDownSampling(with: imageURL, loadImageType: .thumb, cornerRadius: 10)
            $0.contentMode = .scaleAspectFill
        }
        movieTitleLabel.text = title
        switch subtitle.isEmpty {
        case true:
            subtitleLabel.do {
                $0.text = "제공되는 줄거리가 없습니다\n"
                $0.textColor = UIColor(resource: .gray1)
            }
        case false:
            subtitleLabel.do {
                $0.text = subtitle
                $0.textColor = UIColor(resource: .title)
            }
        }
    }
    
    func setTodayMovieCellUITest(imageURL: String, title: String, subtitle: String) {
        
        posterImage.setImageView(image: UIImage(systemName: imageURL) ?? UIImage(), cornerRadius: 6)
        movieTitleLabel.text = title
        subtitleLabel.do {
            $0.text = subtitle
            $0.textColor = UIColor(resource: .title)
        }
    }
    
}
