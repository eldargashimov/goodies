import UIKit

class IngredientCell: UITableViewCell {
    
    var name = UILabel()
    var quantity = UILabel()
    var addToShoppingList = UIButton()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        name.pin
            .margin(10)
            .top()
            .left()
            .width(self.bounds.width / 1.7)
            .bottom()
        
        quantity.pin
            .margin(10)
            .top()
            .left(to: name.edge.right)
            .right()
            .bottom()
        
        addToShoppingList.pin
            .margin(10)
            .right()
            .top()
            .bottom()
            .width(44)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        addToShoppingList.addTarget(self, action: #selector(addIngredientToShoppingList), for: .touchUpInside)
        addToShoppingList.setImage(UIImage(systemName: "bag"), for: .normal)
        
        addToShoppingList.layer.cornerRadius = 5
        addToShoppingList.clipsToBounds = true
        name.adjustsFontSizeToFitWidth = true
        name.minimumScaleFactor = 0.5
        
        [name,
         quantity,
         addToShoppingList].forEach { addSubview($0) }
    }
    
    @objc private func addIngredientToShoppingList() {
        addItem(nameItem: name.text!, isComplited: false, newDose: quantity.text!)
        addToShoppingList.setImage(UIImage(systemName: "checkmark"), for: .normal)
        addToShoppingList.isEnabled = false
    }
}
