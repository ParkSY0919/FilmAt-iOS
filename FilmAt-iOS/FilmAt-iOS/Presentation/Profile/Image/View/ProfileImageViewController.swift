//
//  ProfileImageViewController.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/27/25.
//

import UIKit

final class ProfileImageViewController: BaseViewController {
    
    let profileImage: UIImage
    private lazy var profileImageView = ProfileImageView(profileImage: self.profileImage)
    
    init(profileImage: UIImage) {
        self.profileImage = profileImage
        super.init(navTitle: "프로필 이미지 설정", navLeftBtnType: .pop)
    }
    
    override func loadView() {
        view = profileImageView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
