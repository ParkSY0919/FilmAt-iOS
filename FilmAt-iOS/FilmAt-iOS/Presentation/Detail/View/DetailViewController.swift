//
//  DetailViewController.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/30/25.
//

import UIKit

final class DetailViewController: BaseViewController {
    
    private let viewModel: DetailViewModel
    
    private let detailView = DetailView()
    
    init(viewModel: DetailViewModel) {
        print("DetailViewController init 시작")
        self.viewModel = viewModel
        
        super.init(navTitle: viewModel.moviewTitle, navLeftBtnType: .pop, navRightBtnType: .like)
        print("DetailViewController init 끝")
    }
    
    override func loadView() {
        view = self.detailView
    }
    
    override func setStyle() {
        
    }
    
    override func setLayout() {
        
    }
    
    override func setHierarchy() {
        
    }
    
}
