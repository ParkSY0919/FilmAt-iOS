//
//  BackDropCollectionViewCell.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/30/25.
//

import UIKit

import SnapKit
import Then

final class BackDropCollectionViewCell: BaseCollectionViewCell {
    
    let imageView = UIImageView()
    let pageControl = UIPageControl()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }
    
    override func setHierarchy() {
        contentView.addSubview(imageView)
        
        imageView.addSubview(pageControl)
    }
    
    override func setLayout() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(0).priority(.low)
        }
        
        pageControl.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-8)
            $0.centerX.equalToSuperview()
        }
    }
    
    override func setStyle() {
        imageView.setImageView(image: UIImage(systemName: "star") ?? UIImage(), cornerRadius: 0)
        imageView.do {
            $0.layer.borderWidth = 0
            $0.contentMode = .scaleAspectFill
            $0.isUserInteractionEnabled = true
        }
        
        pageControl.do {
            $0.currentPageIndicatorTintColor = UIColor(resource: .title)
            $0.pageIndicatorTintColor = UIColor(resource: .gray1)
            $0.currentPage = 0
            //page개수 1개일 때 숨기기
            $0.hidesForSinglePage = true
        }
    }
    
    func configureBackDropCell(imageUrlPath: String, backDropImageCnt: Int) {
        print(#function, "imageUrlPath : \(imageUrlPath)")
        imageView.setImageKfDownSampling(with: imageUrlPath,
                                         loadImageType: .backdrop,
                                         cornerRadius: 0)
        pageControl.numberOfPages = backDropImageCnt
    }
    
    func updatePageControl(currentPage: Int) {
        pageControl.currentPage = currentPage
    }
    
}
