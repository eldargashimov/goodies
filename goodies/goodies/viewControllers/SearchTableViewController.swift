//
//  SearchTableViewController.swift
//  goodies
//
//  Created by Mac on 11/9/20.
//

import UIKit
import RealmSwift

class SearchTableViewController: MainTableViewController {
    
    let parser = Parser()
    
    private let searchController = UISearchController(searchResultsController: nil)
//    private var searchDishes: Results<Dish>!
    private var filteredDishes: [DishParse.Recipe] = []
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
        
    var searchBar = UISearchBar()
            
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Поиск"
//        searchDishes = realm.objects(Dish.self)
            // setup the search controller
        searchController.searchResultsUpdater = self // получатель информации об изменении текста в строке поиска - наш класс
        searchController.obscuresBackgroundDuringPresentation = false // позволяем пользователю взаимодействовать с полученным в результате поиска контентом
        searchController.searchBar.placeholder = "Название или время приготовления" // то что написано в строке поиска перед вводом
        navigationItem.searchController = searchController // вставляем строку поиска в навигейшн бар
        definesPresentationContext = true // отпускаем строку поиска при переходе на другой экран
            
    }
        
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredDishes.count : 0
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "dishCell", for: indexPath) as! DishTableViewCell

        let dish = filteredDishes[indexPath.row]
        
        cell.dishName.numberOfLines = 0
        cell.dishName.text = dish.title
        cell.dishName.font = UIFont(name: "Verdana", size: 18.0)
        cell.dishName.textAlignment = .center
        cell.dishImage.image = self.parser.getImage(for: "\(dish.id)") { alert in
            self.present(alert, animated: true, completion: nil)
        }
        cell.dishImage.layer.cornerRadius = 10
        cell.dishImage.contentMode = .scaleAspectFill
        cell.dishImage.clipsToBounds = true

        cell.timeCooking.text = "\(dish.cooking_time["hours"] ?? 0) ч. \(dish.cooking_time["minutes"] ?? 0) мин."

        cell.timeCooking.font = UIFont(name: "Verdana", size: 16.0)
        cell.timeCooking.textAlignment = .right
        cell.timeCooking.textColor = .white
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return DishTableViewCell.height(for: filteredDishes[indexPath.row].title, width: tableView.bounds.width)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
        let dishViewController = RecipeCardViewController(recipe: filteredDishes[indexPath.row], nibName: nil, bundle: nil)
        dishViewController.view.backgroundColor = .white
        present(dishViewController, animated: true, completion: nil)
    }
}

extension SearchTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if isFiltering{
            filterContentForSearchText(searchController.searchBar.text!)
        }
    }

// MARK: fucking search
    
    private func filterContentForSearchText(_ searchText: String) {
        DispatchQueue.global().sync {
            let dishIdArray = parser.getIdArrayForSearch(dishName: searchText) { [weak self] alert in
                self?.present(alert, animated: true, completion: nil)
            }
            self.filteredDishes = self.parser.getRecipes(idArray: dishIdArray) { [weak self] alert in
                self?.present(alert, animated: true, completion: nil)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
//            filteredDishes = searchDishes.filter("name CONTAINS[c] %@ OR timeCooking CONTAINS[c] %@", searchText, searchText)
    }
}
