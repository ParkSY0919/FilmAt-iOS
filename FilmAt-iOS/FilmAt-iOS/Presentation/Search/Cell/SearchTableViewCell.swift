//
//  SearchTableViewCell.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/28/25.
//

import UIKit

import SnapKit
import Then

final class SearchTableViewCell: BaseTableViewCell {
    
    private let containerView = UIView()
    private let posterImageView = UIImageView()
    private let movieTitleLabel = UILabel()
    private let releaseDateLabel = UILabel()
    
    private let genreContainerView = UIView()
    private let firstGenreView = UIView()
    private let secondGenreView = UIView()
    let likeBtnComponent = LikeButton()

    override func setHierarchy() {
        contentView.addSubview(containerView)
        containerView.addSubviews(posterImageView,
                                movieTitleLabel,
                                releaseDateLabel,
                                  genreContainerView,
                                likeBtnComponent)
        
        genreContainerView.addSubviews(firstGenreView, secondGenreView)
    }
    
    override func setLayout() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(12)
        }
        
        posterImageView.snp.makeConstraints {
            $0.leading.verticalEdges.equalToSuperview()
            $0.width.equalTo(100)
        }
        
        movieTitleLabel.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.top).offset(10)
            $0.leading.equalTo(posterImageView.snp.trailing).offset(15)
            $0.trailing.equalToSuperview()
        }
        
        releaseDateLabel.snp.makeConstraints {
            $0.top.equalTo(movieTitleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(movieTitleLabel.snp.leading)
            $0.width.equalTo(100)
        }
        
        genreContainerView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.equalTo(movieTitleLabel.snp.leading)
            $0.trailing.equalTo(likeBtnComponent.snp.leading).offset(-10)
        }
        
        likeBtnComponent.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview()
            $0.size.equalTo(30)
        }
    }
    
    override func setStyle() {
        posterImageView.setImageView(image: UIImage(resource: .profile0), cornerRadius: 10)
        
        movieTitleLabel.setLabelUI("movieTitleLabel",
                                   font: .filmAtFont(.title_bold_16),
                                   textColor: UIColor(resource: .title),
                                   numberOfLines: 2)
        
        releaseDateLabel.setLabelUI("releaseDateLabel",
                                    font: .filmAtFont(.body_medium_12),
                                    textColor: UIColor(resource: .gray1))
        
//        genreStackView.do {
//            $0.axis = .horizontal
//            $0.spacing = 6
//            $0.alignment = .leading
//            $0.distribution = .fillProportionally
//        }
        
        
    }
    
    func setGenreUI(genreArr: [String]) {
        let genreViewARR = [firstGenreView, secondGenreView]
        
        for i in 0..<genreViewARR.count {
            let label = UILabel()
            label.setLabelUI(genreArr[i], font: .filmAtFont(.body_bold_12), textColor: .gray2)
            label.numberOfLines = 1

            genreViewARR[i].do {
                $0.backgroundColor = .gray1
                $0.layer.cornerRadius = 4
                $0.addSubview(label)
            }
            
            label.snp.makeConstraints {
                $0.edges.equalToSuperview().inset(4)
            }
        }
        
        firstGenreView.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview()
        }
        secondGenreView.snp.makeConstraints {
            $0.leading.equalTo(firstGenreView.snp.trailing).offset(4)
            $0.bottom.equalToSuperview()
        }
    }
    
}
