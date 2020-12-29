//
//  MainTableViewController.swift
//  goodies
//
//  Created by Mac on 10/15/20.
//

import UIKit
import RealmSwift


class MainTableViewController: UITableViewController {
    
    var dishes: Results<Dish>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(DishTableViewCell.self, forCellReuseIdentifier: "dishCell")
        tableView.separatorStyle = .none
        dishes = realm.objects(Dish.self)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dishes.isEmpty ? 0 : dishes.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "dishCell", for: indexPath) as! DishTableViewCell
        let dish = dishes[indexPath.row]
        
        cell.dishName.numberOfLines = 0
        cell.dishName.text = dish.name
        cell.dishName.font = UIFont(name: "Verdana", size: 18.0)
        cell.dishName.textAlignment = .center
        cell.dishImage.image = UIImage(data: dish.imageData!)
        cell.dishImage.layer.cornerRadius = 10
        cell.dishImage.contentMode = .scaleAspectFill
        cell.dishImage.clipsToBounds = true

        cell.timeCooking.text = dish.timeCooking

        cell.timeCooking.font = UIFont(name: "Verdana", size: 16.0)
        cell.timeCooking.textAlignment = .center
        cell.timeCooking.textColor = .white
        cell.timeCooking.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
        cell.timeCooking.layer.cornerRadius = 5
        cell.timeCooking.clipsToBounds = true

        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let dish = dishes[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .normal, title: "Удалить") { (_,_,_)  in
            StorageManager.deleteDishFromDB(dish)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return DishTableViewCell.height(for: dishes[indexPath.row].name, width: tableView.bounds.width)
    }
    
      override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            tableView.deselectRow(at: indexPath, animated: true)
            let dishViewController = RecipeDBTableViewController(recipe: dishes[indexPath.row], nibName: nil, bundle: nil)
            dishViewController.view.backgroundColor = .white
            let navigationVC = UINavigationController(rootViewController: dishViewController)
            navigationVC.modalPresentationStyle = .fullScreen
            present(navigationVC, animated: true, completion: nil)
        }
}
