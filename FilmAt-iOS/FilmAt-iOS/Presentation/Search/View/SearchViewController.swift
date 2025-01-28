//
//  SearchViewController.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/28/25.
//

import UIKit

final class SearchViewController: BaseViewController {
    
    private let searchView = SearchView()
    
    init() {
        super.init(navTitle: "영화 검색", navLeftBtnType: .pop)
    }
    
    override func loadView() {
        view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

}
