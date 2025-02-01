//
//  UtilZoomViewController.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 2/1/25.
//

import UIKit

import SnapKit
import Then

final class UtilZoomViewController: BaseViewController {
    
    private let scrollView = UIScrollView()
    private weak var imageView: UIImageView?
    private let closeButton = UIButton()
    
    init(imageView: UIImageView) {
        self.imageView = imageView
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setImageView()
    }
    
    override func setHierarchy() {
        view.addSubviews(scrollView, closeButton)
    }
    
    override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints {
            $0.top.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.width.height.equalTo(30)
        }
    }
    
    override func setStyle() {
        view.backgroundColor = .black
        
        scrollView.do {
            $0.minimumZoomScale = 1.0
            $0.maximumZoomScale = 4.0
            $0.delegate = self
        }
        
        closeButton.do {
            $0.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
            $0.tintColor = UIColor(resource: .point)
            $0.addTarget(self,
                         action: #selector(closeBtnTapped),
                         for: .touchUpInside)
            $0.imageView?.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
    }
    
    private func setImageView() {
        guard let imageView else { return }
        scrollView.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.size.equalToSuperview()
            $0.center.equalToSuperview()
        }
        
        imageView.contentMode = .scaleAspectFit
    }
    
    @objc
    private func closeBtnTapped() {
        self.dismiss(animated: true)
    }
    
}

extension UtilZoomViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
}

