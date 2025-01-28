//
//  SearchViewController.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/28/25.
//

import UIKit

final class SearchViewController: BaseViewController {
    
    let dummy = ["미스터리", "다큐멘터리", "모험"]
    private let searchView = SearchView()
    
    init() {
        super.init(navTitle: "영화 검색", navLeftBtnType: .pop)
    }
    
    override func loadView() {
        view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegate()
    }
    
    

}

private extension SearchViewController {
    
    func setDelegate() {
        searchView.searchTextField.delegate = self
        
        searchView.searchTableView.delegate = self
        searchView.searchTableView.dataSource = self
    }
    
}

extension SearchViewController: UITextFieldDelegate {
    
    
    
}

extension SearchViewController: UITableViewDelegate {
    
    
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.cellIdentifier, for: indexPath) as! SearchTableViewCell
        
        cell.setGenreUI(genreArr: dummy)
        
        return cell
    }
}
