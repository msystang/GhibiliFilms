//
//  ProfileVC.swift
//  GhibliPractice
//
//  Created by Sunni Tang on 10/3/19.
//  Copyright © 2019 Iram Fattah. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    
    var favorites = [Film]() {
        didSet {
            self.favoriteCollectionView.reloadData()
        }
    }
    
    private var tap: UITapGestureRecognizer!
    private var imagePickerViewController: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteCollectionView.dataSource = self
        favoriteCollectionView.delegate = self
        setupImage()
        loadFavoriteFilms()
        loadProfileImage()
        setUpTagGesture()
        setUpImagePicker()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavoriteFilms()
    }
    
    private func loadFavoriteFilms() {
        do {
            favorites = try FilmPersistenceHelper.manager.getFilms()
        } catch {
            print(error)
        }
    }
    
    private func loadProfileImage() {
        do {
            guard let imageInfo = try ProfileImagePersistenceHelper.manager.getProfileImage() else {
                return
            }
            self.profileImageView.image = UIImage(data: imageInfo.imageData)
        } catch {
            print(error)
        }
    }
    
    private func setupImage() {
        profileImageView.layer.cornerRadius = 150/2
    }
    
    private func setUpTagGesture() {
        self.tap = UITapGestureRecognizer(target: self, action: #selector(profileContainerViewClicked))
        containerView.addGestureRecognizer(tap)
    }
    
    private func setUpImagePicker() {
        imagePickerViewController = UIImagePickerController()
        imagePickerViewController.delegate = self
    }
    
    @objc func profileContainerViewClicked() {
        imagePickerViewController.sourceType = .photoLibrary
        present(imagePickerViewController, animated: true, completion: nil)
    }
    
}

extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            profileImageView.image = image
        } else {
            print("No original image")
            
        }
        dismiss(animated: true) {
            guard let imageData = self.profileImageView.image?.jpegData(compressionQuality: 0.5) else { return }
            let profileImageInfo = ProfileImageInfo(imageData: imageData)
                
            try? ProfileImagePersistenceHelper.manager.saveProfileImage(info: profileImageInfo)
        }
            
        
    }
    
}

extension ProfileVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCell", for: indexPath) as! FavoriteCell
        let favorite = favorites[indexPath.row]
        
        cell.favoriteImageView.image = UIImage(named: favorite.title)
        cell.favoriteTitleLabel.text = favorite.title
        
        return cell
    }
}
extension ProfileVC: UICollectionViewDelegate {}
