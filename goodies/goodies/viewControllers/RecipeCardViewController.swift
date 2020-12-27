import UIKit
import PinLayout


//let recipe = parser.getRecipes()[0]


class RecipeCardViewController: UIViewController, UIScrollViewDelegate {
    
    let parser = Parser()

    var recipe: DishParse.Recipe
    
    let screenHeight = UIScreen.main.bounds.height
    
    init(recipe: DishParse.Recipe, nibName: String?, bundle: Bundle?) {
        self.recipe = recipe
        super.init(nibName: nibName, bundle: bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var titleLabel = UILabel()
    var titleImage = UIImageView()
    var timeCookingLabel = UILabel()
    var dishDescription = UILabel()
    var calories = UILabel()
    var nutrilons = UILabel()
    var portions = UILabel()
    var recipeTableView = UITableView()
    var scrollView = UIScrollView()

    let viewHeight: CGFloat = 560 - 88
    var ingredientIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
// колстыль
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissVC))
        
        recipeTableView.dataSource = self
        recipeTableView.delegate = self
        recipeTableView.bounces = false
        recipeTableView.isScrollEnabled = false
        scrollView.delegate = self
        scrollView.bounces = false
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: screenHeight + viewHeight)//scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: recipeTableViewHeight + viewHeight)
        
        recipeTableView.separatorStyle = .none
        recipeTableView.register(IngredientCell.self, forCellReuseIdentifier: "ingredientCell")
        recipeTableView.register(StepCell.self, forCellReuseIdentifier: "stepCell")
        setupViews()
        
        calories.numberOfLines = 0
        calories.text = """
        \(recipe.calories.value)
        \(recipe.calories.unit)
        \(recipe.calories.percent) %
        """
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont(name: "Verdana", size: 18)
        titleLabel.text = recipe.title
        timeCookingLabel.textAlignment = .center
        timeCookingLabel.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
        timeCookingLabel.textColor = .white
        timeCookingLabel.text = "\(recipe.cooking_time["hours"] ?? 0) ч. \(recipe.cooking_time["minutes"] ?? 0) мин."
        timeCookingLabel.layer.cornerRadius = 5
        timeCookingLabel.clipsToBounds = true
        dishDescription.numberOfLines = 0
        dishDescription.text = recipe.description
        portions.text = "Количество порций - \(recipe.portions)"
        nutrilons.numberOfLines = 0
        nutrilons.text = """
        Белки - \(recipe.nutrition["Белки"]!)
        Жиры - \(recipe.nutrition["Жиры"]!)
        Углеводы - \(recipe.nutrition["Углеводы"]!)
        """
        titleImage.contentMode = .scaleAspectFill
        titleImage.image = parser.getImage(for: "\(recipe.id)") { alert in
            self.present(alert, animated: true, completion: nil)
        }
        titleImage.layer.cornerRadius = 20
        titleImage.clipsToBounds = true
    }
    
    override func viewDidLayoutSubviews() {
        
        scrollView.pin
            .top()
            .left()
            .right()
            .bottom()
        
        titleLabel.pin
            .top(10)
            .left()
            .right()
            .height(20)
            .margin(10)
        
        titleImage.pin
            .top(to: titleLabel.edge.bottom)
            .left()
            .right()
            .height(250)
            .margin(10)
        
        dishDescription.pin
            .top(to:titleImage.edge.bottom)
            .left()
            .right()
            .height(100)
            .margin(10)
            
        calories.pin
            .top(to:dishDescription.edge.bottom)
            .left()
            .height(100)
            .width(150)
            .margin(10)
        
        timeCookingLabel.pin
            .bottom(to: titleImage.edge.bottom)
            .right(to: titleImage.edge.right)
            .height(20)
            .width(110)
            .margin(10)
        
        nutrilons.pin
            .top(to: dishDescription.edge.bottom)
            .right()
            .height(100)
            .width(150)
            .margin(10)
        
        portions.pin
            .top(to: nutrilons.edge.bottom)
            .right()
            .left()
            .height(20)
            .margin(10)
        
        recipeTableView.pin
            .top(to: portions.edge.bottom)
            .height(screenHeight - 40)
            .left()
            .right()
            .margin(10)
    }
    
    private func setupViews() {
        
        [titleLabel,
         titleImage,
         timeCookingLabel,
         dishDescription,
         calories,
         nutrilons,
         portions,
         recipeTableView].forEach { scrollView.addSubview($0) }
        view.addSubview(scrollView)
    }
//MARK: scroll in scroll?
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y

        if scrollView == self.scrollView {
            if yOffset >= viewHeight {
                print("yOffset scrollView = \(yOffset)")
                scrollView.isScrollEnabled = false
                recipeTableView.isScrollEnabled = true
            }
        }

        if scrollView == self.recipeTableView {
            print("yOffset = \(yOffset)")
            if yOffset <= 0 {
                print("yOffset tableView = \(yOffset)")
                self.scrollView.isScrollEnabled = true
                self.recipeTableView.isScrollEnabled = false
            }
        }
    }
    
    @objc
    private func dismissVC() {
        self.navigationController?.dismiss(animated: true)
    }
}

extension RecipeCardViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return section == 0 ? "Ингредиенты" : "Рецепт"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return section == 0 ? recipe.ingredients.count : recipe.steps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let ingredientCell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell") as! IngredientCell
            for (name, quantity) in recipe.ingredients {
                if ingredientIndex == indexPath.row {
                    ingredientCell.name.text = name
                    ingredientCell.quantity.text = quantity
                }
                ingredientIndex += 1
            }
            ingredientIndex = 0
            ingredientCell.addToShoppingList.backgroundColor = .red
            return ingredientCell
        } else {
            let stepCell = tableView.dequeueReusableCell(withIdentifier: "stepCell") as! StepCell
            stepCell.stepNumber.text = "Шаг \(indexPath.row + 1) из \(recipe.steps.count)"
            stepCell.stepDescription.text = recipe.steps["\(indexPath.row + 1)"]?.description
            stepCell.stepDescription.font = UIFont(name: "Verdana", size: 14.0)
            stepCell.stepDescription.numberOfLines = 0
// MARK: WHAT DA FUCK?
            if let imageForStepKey = recipe.steps["\(indexPath.row + 1)"]?.img {
                stepCell.stepImage.image = parser.getImage(for: "\(recipe.id)" + "/" + imageForStepKey) { alert in
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                stepCell.stepImage.image = UIImage(named: "turok")
            }
            
            if (recipe.steps["\(indexPath.row + 1)"]?.description.contains("мин"))! || recipe.description.contains("час") {
                stepCell.timerButton.isHidden = false
            }
            return stepCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 44
        } else {
            return StepCell.height(for: recipe.steps["\(indexPath.row + 1)"]!.description, width: tableView.bounds.width - 20.0)
        }
    }
}
