//
//  LentaTableViewController.swift
//  goodies
//
//  Created by Mac on 11/26/20.
//

import UIKit

class LentaTableViewController: UITableViewController {
    
    var dishes: [DishParse.Recipe] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        DispatchQueue.global().async {
            self.dishes = getRecipes(count: 5){ [weak self] alert in
                self?.present(alert, animated: true, completion: nil)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dishes.isEmpty ? 0 : dishes.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "dishCell", for: indexPath) as! DishTableViewCell
        let dish = dishes[indexPath.row]
        
        cell.dishName.numberOfLines = 0
        cell.dishName.text = dish.title
        cell.dishName.font = UIFont(name: "Verdana", size: 18.0)
        cell.dishName.textAlignment = .center
        cell.dishImage.image = getImage(for: "\(dish.id)") { alert in
            self.present(alert, animated: true, completion: nil)
        }
        cell.dishImage.layer.cornerRadius = 20
        cell.dishImage.contentMode = .scaleAspectFill
        cell.dishImage.clipsToBounds = true
        
        cell.timeCooking.text = "\(dish.cooking_time["hours"] ?? 0) ч. \(dish.cooking_time["minutes"] ?? 0) мин."

        cell.timeCooking.font = UIFont(name: "Verdana", size: 16.0)
        cell.timeCooking.textAlignment = .right
        cell.timeCooking.textColor = .white
        cell.timeCooking.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
        cell.timeCooking.layer.cornerRadius = 5
        cell.timeCooking.clipsToBounds = true
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return DishTableViewCell.height(for: dishes[indexPath.row].title, width: tableView.bounds.width)
    }
}
