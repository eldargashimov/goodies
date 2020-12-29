//
//  RecipeCardTableViewController.swift
//  goodies
//
//  Created by Mac on 12/29/20.
//

import UIKit
import RealmSwift
import PinLayout

class RecipeCardTableViewController: UITableViewController {
    
    let parser = Parser()

    var recipe: DishParse.Recipe
    
    var dishes: Results<Dish>!
    
    var isRegistered: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isRegistered_key")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isRegistered_key")
            UserDefaults.standard.synchronize()
        }
    }
    
    var ingredientIndex = 0
    
    init(recipe: DishParse.Recipe, nibName: String?, bundle: Bundle?) {
        self.recipe = recipe
        super.init(nibName: nibName, bundle: bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dishes = realm.objects(Dish.self)
        
        tableView.register(HeaderRecipeCardCell.self, forCellReuseIdentifier: "headerCell")
        tableView.register(IngredientCell.self, forCellReuseIdentifier: "ingredientCell")
        tableView.register(StepCell.self, forCellReuseIdentifier: "stepCell")
        
        tableView.separatorStyle = .none
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissVC))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addRecipeToDB))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let dishes = self.dishes {
            for dish in dishes {
                if dish.id == self.recipe.id {
                    self.navigationItem.rightBarButtonItem?.isEnabled = false
                    return
                }
            }
        }
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return recipe.ingredients.count
        case 2:
            return recipe.steps.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return HeaderRecipeCardCell.height(for: recipe.description, width: view.frame.size.width - 2 * 10)
        case 1:
            return 64
        case 2:
            return StepCell.height(for: recipe.steps["\(indexPath.row + 1)"]!.description, width: tableView.bounds.width - 20.0)
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return recipe.title
        case 1:
            return "Ингредиенты"
        case 2:
            return "Рецепт"
        default:
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.tintColor = LightColors.lightGreen
        header.textLabel?.textColor = LightColors.green
        header.textLabel?.adjustsFontSizeToFitWidth = true
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! HeaderRecipeCardCell
            headerCell.titleImage.contentMode = .scaleAspectFill
            headerCell.titleImage.image = parser.getImage(for: "\(recipe.id)") { alert in
                self.present(alert, animated: true, completion: nil)
            }
            headerCell.titleImage.layer.cornerRadius = 20
            headerCell.titleImage.clipsToBounds = true
            
            headerCell.timeCookingLabel.textAlignment = .center
            headerCell.timeCookingLabel.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
            headerCell.timeCookingLabel.textColor = .white
            headerCell.timeCookingLabel.text = "\(recipe.cooking_time["hours"] ?? 0) ч. \(recipe.cooking_time["minutes"] ?? 0) мин."
            headerCell.timeCookingLabel.layer.cornerRadius = 5
            headerCell.timeCookingLabel.clipsToBounds = true
            headerCell.dishDescription.font = UIFont(name: "Verdana", size: 12.0)
            headerCell.dishDescription.numberOfLines = 0
            headerCell.dishDescription.text = recipe.description
            headerCell.portions.text = "Количество порций - \(recipe.portions)"
            headerCell.nutrilons.numberOfLines = 0
            headerCell.nutrilons.text = """
            Белки - \(recipe.nutrition["Белки"]!)
            Жиры - \(recipe.nutrition["Жиры"]!)
            Углеводы - \(recipe.nutrition["Углеводы"]!)
            """
            headerCell.calories.numberOfLines = 0
            headerCell.calories.text = """
            \(recipe.calories.value)
            \(recipe.calories.unit)
            \(recipe.calories.percent) %
            """
            return headerCell
        } else if indexPath.section == 1 {
            let ingredientCell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell") as! IngredientCell
            for (name, quantity) in recipe.ingredients {
                if ingredientIndex == indexPath.row {
                    ingredientCell.name.text = name
                    ingredientCell.quantity.text = quantity
                }
                ingredientIndex += 1
            }
            ingredientIndex = 0
            return ingredientCell
        } else {
            let stepCell = tableView.dequeueReusableCell(withIdentifier: "stepCell") as! StepCell
            stepCell.stepNumber.text = "Шаг \(indexPath.row + 1) из \(recipe.steps.count)"
            stepCell.stepDescription.text = recipe.steps["\(indexPath.row + 1)"]?.description
            stepCell.stepDescription.font = UIFont(name: "Verdana", size: 14.0)
            stepCell.stepDescription.numberOfLines = 0
            if let imageForStepKey = recipe.steps["\(indexPath.row + 1)"]?.img {
                stepCell.stepImage.image = parser.getImage(for: "\(recipe.id)" + "/" + imageForStepKey) { alert in
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                stepCell.stepImage.image = UIImage(named: "turok")
            }
            return stepCell
        }
    }
    
    @objc
    private func dismissVC() {
        self.navigationController?.dismiss(animated: true)
    }
    
    @objc
    private func addRecipeToDB() {

        if isRegistered {
            StorageManager.saveDishToDB(ModelTransformer.transformToModelForDB(from: self.recipe))
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            _ = getAlert(message: "Пожалуйста, зарегистрируйтесь:)")
        }
    }
}
