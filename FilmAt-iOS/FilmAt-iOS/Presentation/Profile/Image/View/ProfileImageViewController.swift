//
//  ProfileImageViewController.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/27/25.
//

import UIKit

final class ProfileImageViewController: BaseViewController {
    
    var onChange: ((UIImage, String)->Void)?
    private let viewModel: ProfileImageViewModel
    
    private lazy var profileImageView = ProfileImageView(profileImage: viewModel.output.setCurrentImage.value ?? UIImage())
    
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
        onChange?(viewModel.output.setCurrentImage.value ?? UIImage(), viewModel.currentImageName)
        
        super.popBtnTapped()
    }
    
}

private extension ProfileImageViewController {
    
    func setDelegate() {
        profileImageView.collectionView.delegate = self
        profileImageView.collectionView.dataSource = self
    }
    
    func bindViewModel() {
        viewModel.output.setCurrentImage.lazyBind { [weak self] image in
            guard let image else {return}
            DispatchQueue.main.async {
                self?.profileImageView.profileImageView.image = image
                self?.profileImageView.collectionView.performBatchUpdates {
                    self?.profileImageView.collectionView.reloadSections(IndexSet(integer: 0))
                }
            }
        }
    }
    
}

extension ProfileImageViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.input.loadCurrentImageIndex.value = indexPath.item
    }
    
}

extension ProfileImageViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.profileImageArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.cellIdentifier, for: indexPath) as! ProfileImageCollectionViewCell
        
        let isSame = (profileImageView.profileImageView.image == viewModel.profileImageArr[indexPath.item]) ? true : false
        
        DispatchQueue.main.async {
            cell.setProfileCellUI(image: self.viewModel.profileImageArr[indexPath.item], isSame: isSame)
        }
        
        return cell
    }
    
}
