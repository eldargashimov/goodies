import UIKit

class ShoppingTableViewController: UITableViewController {
    
    @IBOutlet var popUpView: UIView!
    @IBOutlet weak var popUpLabel: UILabel!
    @IBOutlet weak var popUpCancel: UIButton!
    @IBOutlet weak var popUpCreate: UIButton!
    @IBOutlet weak var popUpPicker: UIPickerView!
    @IBOutlet weak var popUpTextField: UITextField!
    
    let pickerCount = [" ", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14"]
    let pickerType = [" ", "шт", "кг", "г", "л", "мл"]
    var newDose = "", component1 = "", component2: String = ""
    
    @IBAction func openPopUp(_ sender: Any) {
        animateIn()
    }
    
    
    @IBAction func dissmissPopUp(_ sender: Any) {
        animateOut()
    }
    
    
    @IBAction func createPopUp(_ sender: Any) {
        let newItem = popUpTextField.text
        newDose = component1 + component2
        print(newDose)
        addItem(nameItem: newItem!, newDose: newDose)
        self.tableView.reloadData()
        popUpTextField.text = nil
        component1 = ""
        component2 = ""
        popUpPicker.selectRow(0, inComponent: 0, animated: true)
        popUpPicker.selectRow(0, inComponent: 1, animated: true)
    }
    
    func animateIn() {
        self.view.addSubview(popUpView)
        popUpView.center = self.view.center
        
        popUpView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        UIView.animate(withDuration: 0.4){
            self.popUpView.transform = CGAffineTransform.identity
        }
    }
    
    func animateOut() {
        UIView.animate(withDuration: 0.4, animations: {
            self.popUpView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        }) {
            (success: Bool) in
            self.popUpView.removeFromSuperview()
        }
    }
    
//    
//    @IBAction func pushEditAction(_ sender: Any) {
//        tableView.setEditing(!tableView.isEditing, animated: true)
//    }
    
    @IBAction func pushDoneAction(_ sender: Any) {
        while ToShopItems.isEmpty == false {
            removeItem(at: 0)
        }
        tableView.reloadData()
    }
    
    @IBOutlet var toshopTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let data = UserDefaults.standard.value(forKey:"ToShopItems") as? Data {
            ToShopItems = try! PropertyListDecoder().decode(Array<ShopItem>.self, from: data)
        }
        
        popUpView.layer.cornerRadius = 10
        toshopTableView.separatorStyle = .none
        
        popUpPicker.dataSource = self
        popUpPicker.delegate = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {

        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ToShopItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shopCell", for: indexPath) as! ShoppingCell

        let currentItem = ToShopItems[indexPath.row]
        cell.nameLabel.adjustsFontSizeToFitWidth = true
        cell.nameLabel.text = currentItem.name
        cell.quantityLabel.text = currentItem.dose
        cell.quantityLabel.adjustsFontSizeToFitWidth = true
        
        if (currentItem.isComplited) == true {
            cell.checkImage.image = UIImage(named: "check")
            
        } else {
            cell.checkImage.image = UIImage(named: "uncheck")
        }
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if changeState(at: indexPath.row) {
            (tableView.cellForRow(at: indexPath) as! ShoppingCell).checkImage.image = UIImage(named: "check")
        } else {
            (tableView.cellForRow(at: indexPath) as! ShoppingCell).checkImage.image = UIImage(named: "uncheck")
        }
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        moveItem(fromIndex: fromIndexPath.row, toIndex: to.row)
        
        tableView.reloadData()
    }
    

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

extension ShoppingTableViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return pickerCount.count
        }else {
            return pickerType.count
        }
    }
}

extension ShoppingTableViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return pickerCount[row]
        }else {
            return pickerType[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            component1 = pickerCount[row]
        }else{
            component2 = pickerType[row]
        }
    }
}
