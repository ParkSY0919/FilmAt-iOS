//
//  SearchViewController.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/28/25.
//

import UIKit

final class SearchViewController: BaseViewController {
    
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
        bindViewModel()
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
    
    func bindViewModel() {
        viewModel.searchAPIResult.bind { [weak self] flag in
            guard let flag,
                  let isEmpty = self?.viewModel.searchResultList.isEmpty
            else {return}
            
            if flag {
                DispatchQueue.main.async {
                    self?.searchView.searchTextField.text = self?.viewModel.currentSearchText
                    self?.searchView.setHiddenUI(isEmpty: isEmpty)
                    self?.searchView.searchTableView.reloadData()
                }
            } else {
                print("searchAPIResult.value = false")
            }
        }
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
            viewModel.onChange?(viewModel.currentSearchText)
            viewModel.getSearchData(searchText: viewModel.currentSearchText)
        }
        self.searchView.searchTextField.resignFirstResponder()
        
        return true
    }
    
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = viewModel.searchResultList[indexPath.row]
        
        let detailViewModel = DetailViewModel(moviewTitle: row.title)
        let vc = DetailViewController(viewModel: detailViewModel)
        viewTransition(viewController: vc, transitionStyle: .push)
    }
    
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchResultList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.cellIdentifier, for: indexPath) as! SearchTableViewCell
        cell.likeBtnComponent.likeButton.addTarget(self, action: #selector(likeBtnComponentTapped), for: .touchUpInside)
        
        let item = viewModel.searchResultList[indexPath.item]
        
        let posterUrlPath = item.posterPath ?? ""
        let title = item.title
        let releaseDate = DateFormatterManager.shard.setDateString(strDate: item.releaseDate, format: "yy.MM.dd")
        cell.setCellUI(posterUrlPth: posterUrlPath, title: title, releaseDate: releaseDate)
        cell.setGenreUI(genreArr: item.genreIDS)
        
        return cell
    }
    
}
