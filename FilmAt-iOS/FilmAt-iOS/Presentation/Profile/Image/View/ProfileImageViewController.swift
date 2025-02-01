//
//  ProfileImageViewController.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/27/25.
//

import UIKit

final class ProfileImageViewController: BaseViewController {
    
    var onChange: ((UIImage, Int)->Void)?
    private let viewModel: ProfileImageViewModel
    
    private lazy var profileImageView = ProfileImageView(profileImage: viewModel.currentImage.value ?? UIImage())
    private var profileImageArr = [
        UIImage(resource: .profile0),
        UIImage(resource: .profile1),
        UIImage(resource: .profile2),
        UIImage(resource: .profile3),
        UIImage(resource: .profile4),
        UIImage(resource: .profile5),
        UIImage(resource: .profile6),
        UIImage(resource: .profile7),
        UIImage(resource: .profile8),
        UIImage(resource: .profile9),
        UIImage(resource: .profile10),
        UIImage(resource: .profile11)
    ]
    
    init(viewModel: ProfileImageViewModel) {
        self.viewModel = viewModel
        
        super.init(navTitle: "프로필 이미지 설정", navLeftBtnType: .pop)
    }
    
    override func loadView() {
        view = profileImageView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegate()
        bindViewModel()
    }
    
    override func popBtnTapped() {
        onChange?(viewModel.currentImage.value ?? UIImage(), viewModel.currentImageIndex ?? 0)
        
        super.popBtnTapped()
    }
    
}

private extension ProfileImageViewController {
    
    func setDelegate() {
        profileImageView.collectionView.delegate = self
        profileImageView.collectionView.dataSource = self
    }
    
    func bindViewModel() {
        viewModel.currentImage.bind { [weak self] image in
            guard let image else {return}
            DispatchQueue.main.async {
                self?.profileImageView.profileImageView.image = image
                self?.profileImageView.collectionView.reloadData()
            }
        }
    }
    
}

extension ProfileImageViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.currentImage.value = profileImageArr[indexPath.item]
        self.viewModel.currentImageIndex = indexPath.item
        self.viewModel.imageStr = "profile_\(indexPath.item)"
    }
    
}

extension ProfileImageViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profileImageArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.cellIdentifier, for: indexPath) as! ProfileImageCollectionViewCell
        cell.profileImageView.tag = indexPath.item
        var isSame: Bool = false
        if viewModel.isPush ?? false {
            isSame = (viewModel.currentImage.value == profileImageArr[indexPath.item])
        } else {
            isSame = UIImage(named: viewModel.imageStr) == profileImageArr[indexPath.item]
        }
        
        DispatchQueue.main.async {
            cell.setProfileCellUI(image: self.profileImageArr[indexPath.item], isSame: isSame)
        }
        
        return cell
    }
    
}
