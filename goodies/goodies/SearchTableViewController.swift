//
//  SearchTableViewController.swift
//  goodies
//
//  Created by Mac on 11/9/20.
//

import UIKit
import RealmSwift

class SearchTableViewController: MainTableViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchDishes: Results<Dish>!
    private var filteredDishes: Results<Dish>!
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
        searchDishes = realm.objects(Dish.self)
        
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

            cell.dishName.text = dish.name
            cell.dishName.font = UIFont(name: "Verdana", size: 18.0)
            cell.dishName.textAlignment = .center
            cell.dishImage.image = UIImage(data: dish.imageData!)
            cell.dishImage.layer.cornerRadius = 10
            cell.dishImage.contentMode = .scaleToFill
            cell.dishImage.clipsToBounds = true
        
            if let timeCooking = dish.timeCooking {
                cell.timeCooking.text = timeCooking
            } else {
                cell.timeCooking.text = "неизвестно"
            }
        
            cell.timeCooking.font = UIFont(name: "Verdana", size: 16.0)
            cell.timeCooking.textAlignment = .right
            cell.timeCooking.textColor = .white
        
            return cell
        }

        /*
         MARK: - Navigation

        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
        }
        */

    }

    extension SearchTableViewController: UISearchResultsUpdating {
        
        func updateSearchResults(for searchController: UISearchController) {
            filterContentForSearchText(searchController.searchBar.text!)
        }
        
        private func filterContentForSearchText(_ searchText: String) {
            
            filteredDishes = searchDishes.filter("name CONTAINS[c] %@ OR timeCooking CONTAINS[c] %@", searchText, searchText)
            
            tableView.reloadData()
        }
    }
