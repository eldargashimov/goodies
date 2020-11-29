//
//  ProfileViewController.swift
//  goodies
//
//  Created by Mac on 10/19/20.
//

import UIKit
import PinLayout

class ProfileViewController: UIViewController {
    
    var avatarImage = UIImageView()
    var name = UILabel()
    var viewForButtons = UIView()
    let favoritRecepts = UILabel()
    var showFavoritReceptsButton = UIButton()
    var addNewReceptButton = UIButton()
    
    let margin: CGFloat = 8.0
    
    override func awakeFromNib() {
        
        setup()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
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
    
    private func setup() {
        
        avatarImage.layer.cornerRadius = 50
        avatarImage.clipsToBounds = true
        avatarImage.backgroundColor = .black
        
        name.font = UIFont(name: "Verdana", size: 30.0)
        name.text = "Иван Иванов"
        name.textAlignment = .center
        name.textColor = .black
        
        viewForButtons.layer.cornerRadius = 15
        viewForButtons.clipsToBounds = true
        viewForButtons.backgroundColor = .green
        
        favoritRecepts.font = UIFont(name: "Verdana", size: 20.0)
        favoritRecepts.text = "Избранные рецепты"
        favoritRecepts.textAlignment = .center
        favoritRecepts.textColor = .black
        
        showFavoritReceptsButton.addTarget(self, action: #selector(showFavoritRecepts), for: .touchUpInside)
        showFavoritReceptsButton.setImage(UIImage(systemName: "text.badge.star"), for: .normal)
        
        addNewReceptButton.addTarget(self, action: #selector(addNewRecept), for: .touchUpInside)
        addNewReceptButton.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        
        [avatarImage, name, viewForButtons, favoritRecepts, showFavoritReceptsButton, addNewReceptButton].forEach { view.addSubview($0) }
    }
    
    @objc func showFavoritRecepts() {
        
        let vc = MainTableViewController()
        let navigationController = UINavigationController(rootViewController: vc)
        vc.title = self.favoritRecepts.text
        present(navigationController, animated: true, completion: nil)
    }
    
    @objc func addNewRecept() {
        
//        для заполнения бд раскомментировать и нажать на кнопку +
        
//        let dish = Dish()
//        DispatchQueue.main.async {
//            dish.saveDishesToDB()
//        }
        
        print("add new recept")
    }
}
