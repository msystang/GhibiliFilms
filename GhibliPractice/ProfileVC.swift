//
//  ProfileVC.swift
//  GhibliPractice
//
//  Created by C4Q on 10/1/19.
//  Copyright © 2019 Iram Fattah. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var favoritesCollectionView: UICollectionView!
    
    @IBOutlet weak var profileContainerView: UIView!
    var favorites = [Film]() {
        didSet {
            self.favoritesCollectionView.reloadData()
        }
    }
    
    private var tap: UITapGestureRecognizer!
    private var imagePickerViewController: UIImagePickerController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesCollectionView.dataSource = self
        favoritesCollectionView.delegate = self 
        setupImage()
        loadFavoriteFilms()
        loadProfileImage()
        setupLabelFromUserDefaults()
        setupTapGestureRecognizor()
        setupImagePicker()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavoriteFilms()
        
    }
    
    
    
    private func setupLabelFromUserDefaults() {
        let emailAndPass = UserDefaultsWrapper.shared.getEmailAndPassword()
        guard let email = emailAndPass.email else {return}
        self.emailLabel.text = email
    }
    
    private func loadFavoriteFilms() {
        do {
        favorites = try FilmsPersistenceManager.manager.getFilms()
        } catch {
            print(error)
        }
    }
    
    private func loadProfileImage() {
        do {
            let imageInfo = try ProfileImagePersistence.manager.getProfileImage()
            self.profileImageView.image = UIImage(data: imageInfo.imageData)
        } catch {
            print(error)
        }
    }
    
    private func setupImage() {
         profileImageView.layer.cornerRadius = 150 / 2
    }
    
    private func setupTapGestureRecognizor() {
        self.tap = UITapGestureRecognizer(target: self, action: #selector(profileContainerViewClicked))
        profileContainerView.addGestureRecognizer(tap)
    }
    

    private func setupImagePicker() {
        imagePickerViewController =  UIImagePickerController()
               imagePickerViewController.delegate = self
        
    }
    
    @objc func profileContainerViewClicked() {
        imagePickerViewController.sourceType = .photoLibrary
        present(imagePickerViewController, animated: true, completion: nil)
    }

  

}
extension ProfileVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCell", for: indexPath) as! FavoritesCell
        let fave = favorites[indexPath.row]
        cell.imageView.image = UIImage(named: fave.title)
        cell.nameLabel.text = fave.title
        return cell
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
            print("original image is nil")
        }
        dismiss(animated: true) {
            //save to File Manager
            guard let imageData = self.profileImageView.image?.jpegData(compressionQuality: 0.5) else {return}
            
            let profileImageInfo = ProfileImageInfo(imageData: imageData)
             try? ProfileImagePersistence.manager.saveProfileImage(info: profileImageInfo)
        }
    }
    
}
