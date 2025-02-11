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
        searchView.searchTableView.prefetchDataSource = self
    }
    
    func setAddTarget() {
        searchView.searchTextField.addTarget(self,
                                             action: #selector(textFieldDidChange),
                                             for: .editingChanged)
    }
    
    func bindViewModel() {
        viewModel.isSearchAPICallSuccessful.lazyBind { [weak self] isSuccessful in
            print("viewModel.isSearchAPICallSuccessful.bind 호출 중")
            guard
                let isSuccessful,
                let isEmpty = self?.viewModel.searchResultList.isEmpty
            else {return}
            
            if isSuccessful == "true" {
                DispatchQueue.main.async {
                    self?.searchView.setHiddenUI(isEmpty: isEmpty)
                    self?.searchView.searchTableView.reloadData()
                    if self?.viewModel.page == 1 {
                        self?.setScrollToTop()
                    }
                }
            } else {
                print("isSearchAPICallSuccessful.value = false")
                DispatchQueue.main.async {
                    let alert = UIAlertManager.showAlert(title: "에러 발생", message: isSuccessful)
                    self?.present(alert, animated: true)
                }
            }
        }
        
        viewModel.output.setDetailViewModel.lazyBind { [weak self] detailViewModel in
            guard let self, let detailViewModel else {return}
            detailViewModel.likeMovieListDic = viewModel.likeMovieListDic
            detailViewModel.getImageData(movieID: self.viewModel.detailViewMoviewID)
            
            detailViewModel.endDataLoading = { [weak self] in
                DispatchQueue.main.async {
                    let vc = DetailViewController(viewModel: detailViewModel)
                    self?.viewTransition(viewController: vc, transitionStyle: .push)
                }
            }
            
            detailViewModel.onAlert = { [weak self] alert in
                self?.present(alert, animated: true)
            }
            
            detailViewModel.likedMovieListChange = { likeMovieListDic in
                self.viewModel.likeMovieListDic = likeMovieListDic
                
                // reloadData하기위해 값 설정
                self.viewModel.isSearchAPICallSuccessful.value = "true"
                self.viewModel.likedMovieListChange?(likeMovieListDic)
            }
        }
    }
    
    func setScrollToTop() {
        print(#function)
        let indexPath = NSIndexPath(row: NSNotFound, section: 0)
        searchView.searchTableView.scrollToRow(at: indexPath as IndexPath, at: .top, animated: false)
    }
    
    @objc
    func textFieldDidChange(_ textField: UITextField) {
        print(#function, textField.text ?? "")
        viewModel.input.textFieldText.value = textField.text
    }
    
}

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewModel.input.isTextFieldReturn.value = ()
        self.searchView.searchTextField.resignFirstResponder()
        return true
    }
    
}

extension SearchViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for i in indexPaths {
            if (viewModel.searchResultList.count - 4) == i.item {
                print("추가호출")
                viewModel.input.isCallPrefetch.value = ()
            }
        }
    }
    
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.input.prepareDetailViewModel.value = indexPath.row
    }
    
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchResultList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.cellIdentifier, for: indexPath) as! SearchTableViewCell
        
        let item = viewModel.searchResultList[indexPath.item]
        
        let posterUrlPath = item.posterPath ?? ""
        let title = item.title
        guard let date = item.releaseDate,
              let genreIDs = item.genreIDS else {return UITableViewCell()}
        let releaseDate = DateFormatterManager.shard.setDateString(strDate: date, format: "yy.MM.dd")
        
        cell.setCellUI(posterUrlPth: posterUrlPath, title: title, releaseDate: releaseDate)
        cell.setGenreUI(genreArr: genreIDs)
        
        cell.likeBtnComponent.configureLikeBtn(isLiked: viewModel.likeMovieListDic[String(item.id)] ?? false)
        
        cell.likeBtnComponent.onTapLikeButton = { [weak self] isSelected in
            guard let self = self else { return }
            if isSelected {
                self.viewModel.likeMovieListDic[String(item.id)] = true
            } else {
                self.viewModel.likeMovieListDic[String(item.id)] = nil
            }
            UserDefaultsManager.shared.likeMovieListDic = self.viewModel.likeMovieListDic
            viewModel.likedMovieListChange?(viewModel.likeMovieListDic)
        }
        
        return cell
    }
    
}
