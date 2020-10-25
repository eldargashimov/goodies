//
//  MainTableViewController.swift
//  goodies
//
//  Created by Mac on 10/15/20.
//

import UIKit


class MainTableViewController: UITableViewController {
    let someDishes = ["Карбонара",
                      "Борщ",
                      "Ичпачмак",
                      "Ризотто с креветками",
                      "Британский завтрак",
                      "Неаполитанская пицца",
                      "Хинкали",
                      "Манты",
                      "Тататрский плов",
                      "Бурата с томатами и перцем",
                      "Фаршированный перец",
                      "Ленивые вареники",
                      "Цезарь с курицей",
                      "Брускетта со страчателлой",
                      "Поэлья",
                      "Блинчики с сулугуни и шпинатом",
                      "Глазунья",
                      "Шарлотка",
                      "Фаршированный индюк"]
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Лента"
        tableView.separatorStyle = .none
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return someDishes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dishCell", for: indexPath) as! DishTableViewCell
        cell.dishName.text = someDishes[indexPath.row]
        cell.dishName.font = UIFont(name: "Verdana", size: 18.0)
        cell.dishName.textAlignment = .center
        cell.dishImage.image = UIImage(named: "dish")
        cell.dishImage.layer.cornerRadius = 10
        cell.dishImage.clipsToBounds = true
        cell.timeCooking.text = "15 мин."
        cell.timeCooking.font = UIFont(name: "Verdana", size: 16.0)
        cell.timeCooking.textAlignment = .right
        cell.timeCooking.textColor = .white
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 244
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
