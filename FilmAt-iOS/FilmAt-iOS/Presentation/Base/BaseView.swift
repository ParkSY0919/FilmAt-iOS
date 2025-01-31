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
        
        setHierarchy()
        setLayout()
        setStyle()
//        baseSetup()
        
    }
    
    private func baseSetup() {
        self.backgroundColor = UIColor(resource: .background)
    }
    
    func setHierarchy() {}
    
    func setLayout() {}
    
    func setStyle() {
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
