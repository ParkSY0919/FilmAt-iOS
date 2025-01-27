//
//  CinemaViewController.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/27/25.
//

import UIKit

final class CinemaViewController: BaseViewController {
    
    private let cinemaView = CinemaView()
    
    init() {
        super.init(navTitle: "FilmAt", navRightBtnType: .search)
    }
    
    override func loadView() {
        view = cinemaView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        print("CinemaViewController")
        setAddTarget()
    }

    override func searchBtnTapped() {
        print(#function)
    }

}

private extension CinemaViewController {
    
    func setAddTarget() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileBoxTapped))
        cinemaView.profileBox.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func profileBoxTapped() {
        print(#function)
    }
    
}
