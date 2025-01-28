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
    private let firstGenreLabel = UILabel()
    private let secondGenreLabel = UILabel()
    
    let likeBtnComponent = LikeButton()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterImageView.image = nil
        movieTitleLabel.text = nil
        releaseDateLabel.text = nil
        firstGenreView.backgroundColor = nil
        secondGenreView.backgroundColor = nil
        firstGenreLabel.text = nil
        secondGenreLabel.text = nil
        likeBtnComponent.likeButton.setImage(nil, for: .normal)
    }

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
        self.backgroundColor = UIColor(resource: .background)
        
        posterImageView.setImageView(image: UIImage(resource: .profile0), cornerRadius: 10)
        
        movieTitleLabel.setLabelUI("movieTitleLabel",
                                   font: .filmAtFont(.title_bold_16),
                                   textColor: UIColor(resource: .title),
                                   numberOfLines: 2)
        
        releaseDateLabel.setLabelUI("releaseDateLabel",
                                    font: .filmAtFont(.body_medium_12),
                                    textColor: UIColor(resource: .gray1))
    }
    
    func setGenreUI(genreArr: [Int]) {
        let genreViewARR = [firstGenreView, secondGenreView]
        let genreLabelArr = [firstGenreLabel, secondGenreLabel]
        
        for i in 0..<genreArr.count {
            if i == 2 { break }
            let genreText = GenreType(rawValue: genreArr[i])?.name ?? "실패"
            
            genreLabelArr[i].setLabelUI(genreText,
                                        font: .filmAtFont(.body_bold_12),
                                        textColor: .gray2,
                                        numberOfLines: 1)

            genreViewARR[i].do {
                $0.backgroundColor = .gray1
                $0.layer.cornerRadius = 4
                $0.addSubview(genreLabelArr[i])
            }
            
            genreLabelArr[i].snp.makeConstraints {
                $0.edges.equalToSuperview().inset(4)
            }
        }
        
        switch genreArr.count < 2 {
        case true:
            firstGenreView.snp.makeConstraints {
                $0.leading.bottom.equalToSuperview()
            }
        case false:
            firstGenreView.snp.makeConstraints {
                $0.leading.bottom.equalToSuperview()
            }
            secondGenreView.snp.makeConstraints {
                $0.leading.equalTo(firstGenreView.snp.trailing).offset(4)
                $0.bottom.equalToSuperview()
            }
        }
        
        
    }
    
    func setCellUI(posterUrlPth: String, title: String, releaseDate: String) {
        posterImageView.setImageKfDownSampling(with: posterUrlPth, cornerRadius: 8)
        movieTitleLabel.text = title
        releaseDateLabel.text = releaseDate
    }
    
}
