//
//  BaseView.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/25/25.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //setLayout 없음
        setHierarchy()
        setStyle()
    }
    
    func setHierarchy() {}
    
    func setLayout() {}
    
    func setStyle() {
        self.backgroundColor = .white
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
