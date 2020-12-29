//
//  ProfileViewController.swift
//  goodies
//
//  Created by Mac on 10/19/20.
//

import UIKit
import PinLayout
import RealmSwift

class ProfileViewController: UIViewController {
    
    var profile = Profile()
    
    var registration = UIView()
    var hello = UILabel()
    var portrait2 = UIImageView()
    var nameText = UITextField()
    var surnameText = UITextField()
    var createButton = UIButton()
    var editPhotoButton = UIButton()
    
    var isRegistered: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isRegistered_key")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isRegistered_key")
            UserDefaults.standard.synchronize()
        }
    }
    
    var avatarImage = UIImageView()
    var name = UILabel()
    var viewForButtons = UIView()
    let favoritRecepts = UILabel()
    var showFavoritReceptsButton = UIButton()
    var addNewReceptButton = UIButton()
    
    let margin: CGFloat = 8.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        unregistered()
        profile = realm.objects(Profile.self).isEmpty ? Profile() : realm.objects(Profile.self).last!
        setup()
    }

// MARK: Почти удаление приложения
    private func unregistered() {
        isRegistered = false
        for profile in realm.objects(Profile.self) {
            StorageManager.deleteProfileFromDB(profile)
        }
    
        for dish in realm.objects(Dish.self) {
            StorageManager.deleteDishFromDB(dish)
        }
    }
//--------------------------------
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupRegistration()

        avatarImage.pin
            .top(100)
            .left(20)
            .height(100)
            .width(100)
        
        name.pin
            .height(40)
            .top(130)
            .right(of: avatarImage)
            .right(8)
            .marginHorizontal(10)
        
        viewForButtons.pin
            .top(250)
            .left(8)
            .right(8)
            .height(50)
        
        addNewReceptButton.pin
            .top(to: viewForButtons.edge.top)
            .right(to: viewForButtons.edge.right)
            .bottom(to: viewForButtons.edge.bottom)
            .width(50)
            .marginRight(margin)
//            .marginVertical(margin)
        
        showFavoritReceptsButton.pin
            .top(to: viewForButtons.edge.top)
            .right(to: addNewReceptButton.edge.left)
            .bottom(to: viewForButtons.edge.bottom)
            .width(50)
//            .marginVertical(margin)
        
        favoritRecepts.pin
            .topRight(to: showFavoritReceptsButton.anchor.topLeft)
            .bottomLeft(to: viewForButtons.anchor.bottomLeft)
            .marginLeft(margin)
            .marginVertical(margin)
    }
    
    private func setupRegistration() {
        registration.pin.top().bottom().right().left()

        registration.pin
            .top()
            .left()
            .right()
            .bottom()

        hello.pin
            .topCenter(70)
            .width(170)
            .height(75)

        nameText.pin
            .topCenter(320)
            .width(250)
            .height(37)

        surnameText.pin
            .topCenter(400)
            .width(250)
            .height(37)
        portrait2.pin
            .topCenter(150)
            .width(150)
            .height(150)

        createButton.pin
            .topCenter(440)
            .height(40)
            .width(100)

        editPhotoButton.pin
            .topCenter(275)
            .height(26)
            .width(100)
    }
    
    private func setup() {
        
        avatarImage.layer.cornerRadius = 50
        avatarImage.clipsToBounds = true
        if let avatar = profile.avatarImageData {
            avatarImage.image = UIImage(data: avatar)
        }
        
        name.font = UIFont(name: "Verdana", size: 30.0)
        name.text = "\(profile.name) \(profile.surName)"
        name.textAlignment = .center
        name.textColor = .black
        name.adjustsFontSizeToFitWidth = true
        
        viewForButtons.layer.cornerRadius = 15
        viewForButtons.clipsToBounds = true
        viewForButtons.backgroundColor = LightColors.lightGreen
        
        favoritRecepts.font = UIFont(name: "Verdana", size: 20.0)
        favoritRecepts.text = "Избранные рецепты"
        favoritRecepts.textAlignment = .center
        favoritRecepts.textColor = .black
        
        showFavoritReceptsButton.addTarget(self, action: #selector(showFavoritRecepts), for: .touchUpInside)
        showFavoritReceptsButton.setImage(UIImage(systemName: "text.badge.star"), for: .normal)
        
        addNewReceptButton.addTarget(self, action: #selector(addNewRecept), for: .touchUpInside)
        addNewReceptButton.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        
        [avatarImage,
         name,
         viewForButtons,
         favoritRecepts,
         showFavoritReceptsButton,
         addNewReceptButton].forEach { view.addSubview($0) }
        
        if isRegistered == false {
            
            createButton.addTarget(self, action: #selector(createAcc), for: .touchUpInside)
            editPhotoButton.addTarget(self, action: #selector(editPhoto), for: .touchUpInside)
             
             portrait2.image = UIImage(named: "popa")
             hello.text = "Добро пожаловать"
             createButton.setTitle("Создать", for: .normal)
             editPhotoButton.setTitle("Изменить", for: .normal)
             editPhotoButton.setTitleColor(.black, for: .normal)
             nameText.placeholder = "имя"
             surnameText.placeholder = "фамилия"
             
             nameText.backgroundColor = .white
             surnameText.backgroundColor = .white
             portrait2.backgroundColor = .white
             registration.backgroundColor = UIColor(red: 205/255.0, green: 212/255.0, blue: 106/255.0, alpha: 1)
             
             
             portrait2.layer.cornerRadius = 25
             nameText.layer.cornerRadius = 10
             surnameText.layer.cornerRadius = 10
             nameText.textAlignment = .center
             surnameText.textAlignment = .center
             hello.textAlignment = .center
             
             nameText.clipsToBounds = true
             surnameText.clipsToBounds = true

            
            view.addSubview(registration)
            
            [portrait2,
             hello,
             nameText,
             surnameText,
             createButton,
             editPhotoButton].forEach { self.registration.addSubview($0) }
        }
    }
    
    @objc private func showFavoritRecepts() {
        
        let vc = MainTableViewController()
        let navigationController = UINavigationController(rootViewController: vc)
        vc.title = self.favoritRecepts.text
        present(navigationController, animated: true, completion: nil)
    }
    
    @objc private func addNewRecept() {
        
        _ = getAlert(message: "Не успели реализовать:)")
//        print("add new recept")
    }
    
    @objc
    private func editPhoto(){
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let camera = UIAlertAction(title: "Камера", style: .default) { (_) in
                self.chooseImagePicker(source: .camera)
            }
            let photo = UIAlertAction(title: "Фото", style: .default) { (_) in
                self.chooseImagePicker(source: .photoLibrary)
            }
            let cancel = UIAlertAction(title: "Отмена", style: .cancel)
                
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
                    
            present(actionSheet, animated: true)
        }
                   
        @objc
        private func createAcc() {
            if (nameText.text == "") || (surnameText.text == ""){
            let alertController = UIAlertController(title: "ошибка", message: "Введите данные", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        } else {
                let myProfile = Profile()
                myProfile.name = nameText.text ?? "Ivan"
                myProfile.surName = surnameText.text ?? "Ivanov"
                myProfile.avatarImageData = portrait2.image?.pngData()
                name.text = "\(nameText.text ?? "Ivan") \(surnameText.text ?? "Ivanov")"
                avatarImage.image = portrait2.image
                StorageManager.saveProfileToDB(myProfile)
                registration.removeFromSuperview()
                isRegistered = true
        }
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func chooseImagePicker(source: UIImagePickerController.SourceType ){
        if UIImagePickerController.isSourceTypeAvailable(source){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        portrait2.image = info[.editedImage] as? UIImage
        portrait2.contentMode = .scaleAspectFill
        portrait2.clipsToBounds = true
        dismiss(animated: true)
    }
}
