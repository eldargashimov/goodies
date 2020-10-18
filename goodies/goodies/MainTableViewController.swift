//
//  MainTableViewController.swift
//  goodies
//
//  Created by Mac on 10/15/20.
//

import UIKit

class MainTableViewController: UITableViewController {
    let someDishes = ["Карбонара", "Борщ", "Ичпачмак", "Ризотто с креветками под винным соусом", "Британский завтрак", "Неаполитанская пицца", "Хинкали", "Манты", "Тататрский плов", "Бурата с томатами и перцем", "Фаршированный перец", "Ленивые вареники", "Цезарь с курицей", "Брускетта со страчателлой", "Поэлья", "Блинчики с сулугуни и шпинатом", "Глазунья", "Шарлотка", "Фаршированный индюк ёптэ"]
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Лента"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return someDishes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dishCell", for: indexPath)
        cell.textLabel?.text = someDishes[indexPath.row]
        cell.imageView?.image = UIImage(named: "dish")
        cell.imageView?.layer.cornerRadius = 25
        cell.imageView?.clipsToBounds = true
        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
