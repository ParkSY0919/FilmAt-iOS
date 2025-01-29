//
//  SettingViewController.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/29/25.
//

import UIKit

final class SettingViewController: BaseViewController {
    
    private var viewModel: SettingViewModel
    
    let settingView = SettingView()
    
    init(viewModel: SettingViewModel) {
        self.viewModel = viewModel
        
        super.init(navTitle: "설정")
    }
    
    override func loadView() {
        view = settingView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegate()
        setAddTarget()
    }

}

private extension SettingViewController {
    
    func setDelegate() {
        settingView.settingTableView.delegate = self
        settingView.settingTableView.dataSource = self
    }
    
    func setAddTarget() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileBoxTapped))
        settingView.profileBox.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func profileBoxTapped() {
        print(#function)
        let vc = ProfileNicknameViewController(viewModel: ProfileNicknameViewModel(), isPushType: false)
        vc.onChange = { [weak self] in
            self?.settingView.profileBox.changeProfileBoxData()
        }
        viewTransition(viewController: vc, transitionStyle: .presentWithNav)
    }
    
}

extension SettingViewController: UITableViewDelegate {
    
}

extension SettingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.titleTextArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.cellIdentifier) as! SettingTableViewCell
        
        cell.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        let rowTitle = viewModel.titleTextArr[indexPath.row]
        cell.configureCellUI(rowTitle: rowTitle)
        
        return cell
    }
    
}
