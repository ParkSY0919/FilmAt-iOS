//
//  UtilZoomViewController.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 2/1/25.
//

import UIKit

import SnapKit
import Then

final class ImageZoomViewController: BaseViewController {
    
    private let scrollView = UIScrollView()
    private let imageView = UIImageView()
    let closeButton = UIButton()
    
    init(image: UIImage?) {
        imageView.image = image
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setHierarchy() {
        view.addSubviews(scrollView, closeButton)
        scrollView.addSubview(imageView)
    }
    
    override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.size.equalToSuperview()
            $0.center.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints {
            $0.top.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.width.height.equalTo(44)
        }
    }
    
    override func setStyle() {
        view.backgroundColor = .black
        
        scrollView.do {
            $0.minimumZoomScale = 1.0
            $0.maximumZoomScale = 4.0
            $0.delegate = self
        }
        
        imageView.contentMode = .scaleAspectFit
        
        closeButton.do {
            $0.setImage(UIImage(systemName: "xmark"), for: .normal)
            $0.tintColor = UIColor(resource: .gray2)
            $0.addTarget(self, action: #selector(closeBtnTapped), for: .touchUpInside)
        }
    }
    
    @objc
    private func closeBtnTapped() {
        self.dismiss(animated: true)
    }
    
}

extension ImageZoomViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
}

