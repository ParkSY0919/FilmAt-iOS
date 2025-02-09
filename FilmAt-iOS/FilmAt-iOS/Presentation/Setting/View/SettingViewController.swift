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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        settingView.profileBox.changeProfileBoxData()
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
        let profileNicknameViewModel = ProfileNicknameViewModel()
        let vc = ProfileNicknameViewController(viewModel: profileNicknameViewModel, isPushType: false)
        vc.onChange = { [weak self] in
            self?.settingView.profileBox.changeProfileBoxData()
        }
        viewTransition(viewController: vc, transitionStyle: .presentWithNav)
    }
    
}

extension SettingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 3:
            let doneAction = UIAlertAction(title: "확인", style: .default) { _ in
                print("탈퇴 누름!")
                //유저디폴츠 값 초기화
                UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
                self.viewTransition(viewController: OnBoardingViewController(), transitionStyle: .resetRootVCwithNav)
            }
            let alert = UIAlertManager.showAlertWithAction(title: "탈퇴하기",
                                                           message: "탈퇴를 하면 데이터가 모두 초기화됩니다. 탈퇴 하시겠습니까?",
                                                           cancelFunc: true, doneAction: doneAction)
            present(alert, animated: true)
        default:
            print("해당 cell(\(indexPath.row)은 동작하지 않습니다")
        }
    }
    
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
