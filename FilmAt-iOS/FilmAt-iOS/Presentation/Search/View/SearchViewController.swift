//
//  SearchViewController.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/28/25.
//

import UIKit

final class SearchViewController: BaseViewController {
    
    let dummy = ["미스터리", "다큐멘터리", "모험"]
    private let viewModel: SearchViewModel
    
    private let searchView = SearchView()
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        
        super.init(navTitle: "영화 검색", navLeftBtnType: .pop)
    }
    
    override func loadView() {
        view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegate()
        setAddTarget()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let text = searchView.searchTextField.text else {return}
        if text.isEmpty {
            searchView.searchTextField.becomeFirstResponder()
        }
    }

}

private extension SearchViewController {
    
    func setDelegate() {
        searchView.searchTextField.delegate = self
        
        searchView.searchTableView.delegate = self
        searchView.searchTableView.dataSource = self
    }
    
    func setAddTarget() {
        searchView.searchTextField.addTarget(self,
                                             action: #selector(textFieldDidChange),
                                             for: .editingChanged)
    }
    
    @objc
    func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        print(#function, text)
        viewModel.currentSearchText = text
    }
    
    @objc
    func likeBtnComponentTapped(_ sender: UIButton) {
        print(#function)
        switch sender.isSelected {
        case true:
            sender.isSelected = false
        case false:
            sender.isSelected = true
        }
    }
    
}

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch viewModel.checkDuplicateSearchText() {
        case true:
            print("이전 검색어와 현재 검색어가 일치합니다.")
        case false:
            viewModel.getSearchData(searchText: viewModel.currentSearchText)
        }
        searchView.searchTextField.resignFirstResponder()
        return true
    }
    
}

extension SearchViewController: UITableViewDelegate {
    
    
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.cellIdentifier, for: indexPath) as! SearchTableViewCell
        
        cell.likeBtnComponent.likeButton.addTarget(self, action: #selector(likeBtnComponentTapped), for: .touchUpInside)
        
        cell.setGenreUI(genreArr: dummy)
        
        return cell
    }
}
