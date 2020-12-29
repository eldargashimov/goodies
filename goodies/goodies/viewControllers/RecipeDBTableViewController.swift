//
//  RecipeDBTableViewController.swift
//  goodies
//
//  Created by Mac on 12/29/20.
//

import UIKit

class RecipeDBTableViewController: UITableViewController {
    
    var recipe: Dish
    
    let screenHeight = UIScreen.main.bounds.height
    
    init(recipe: Dish, nibName: String?, bundle: Bundle?) {
        self.recipe = recipe
        super.init(nibName: nibName, bundle: bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(HeaderRecipeCardCell.self, forCellReuseIdentifier: "headerCell")
        tableView.register(IngredientCell.self, forCellReuseIdentifier: "ingredientCell")
        tableView.register(StepCell.self, forCellReuseIdentifier: "stepCell")
        
        tableView.separatorStyle = .none
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissVC))
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
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return recipe.name
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return HeaderRecipeCardCell.height(for: recipe.dishDescription, width: view.frame.size.width - 2 * 10)
        case 1:
            return 64
        case 2:
            return StepCell.height(for: recipe.steps[indexPath.row].stepDescription, width: tableView.bounds.width - 20.0)
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! HeaderRecipeCardCell
            headerCell.calories.numberOfLines = 0
            headerCell.calories.text = """
            \(recipe.calories[0].value)
            \(recipe.calories[0].unit)
            \(recipe.calories[0].percent) %
            """

            headerCell.timeCookingLabel.textAlignment = .center
            headerCell.timeCookingLabel.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
            headerCell.timeCookingLabel.textColor = .white
            headerCell.timeCookingLabel.text = recipe.timeCooking
            headerCell.timeCookingLabel.layer.cornerRadius = 5
            headerCell.timeCookingLabel.clipsToBounds = true
            headerCell.dishDescription.font = UIFont(name: "Verdana", size: 12.0)
            headerCell.dishDescription.numberOfLines = 0
            headerCell.dishDescription.text = recipe.dishDescription
            headerCell.portions.text = "Количество порций - \(recipe.portions)"
            headerCell.nutrilons.numberOfLines = 0

            headerCell.nutrilons.text = """
            Белки - \(recipe.nutrilion[0].proteins)
            Жиры - \(recipe.nutrilion[0].fats)
            Углеводы - \(recipe.nutrilion[0].carbohydrates)
            """
            
            
            headerCell.titleImage.contentMode = .scaleAspectFill
            if let imageData = recipe.imageData {
                headerCell.titleImage.image = UIImage(data: imageData)
            }
            headerCell.titleImage.layer.cornerRadius = 20
            headerCell.titleImage.clipsToBounds = true
            return headerCell
        } else if indexPath.section == 1 {
            let ingredientCell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell") as! IngredientCell
                 
            ingredientCell.name.text = recipe.ingredients[indexPath.row].name
            ingredientCell.quantity.text = recipe.ingredients[indexPath.row].quantity
            return ingredientCell
        } else {
            let stepCell = tableView.dequeueReusableCell(withIdentifier: "stepCell") as! StepCell
            stepCell.stepNumber.text = "Шаг \(indexPath.row + 1) из \(recipe.steps.count)"
            stepCell.stepDescription.text = recipe.steps[indexPath.row].stepDescription
            stepCell.stepDescription.font = UIFont(name: "Verdana", size: 14.0)
            stepCell.stepDescription.numberOfLines = 0
            if let imageForStepKey = recipe.steps[indexPath.row].stepImageData {
                stepCell.stepImage.image = UIImage(data: imageForStepKey)
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
}
