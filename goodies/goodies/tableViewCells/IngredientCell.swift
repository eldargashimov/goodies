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
            .width(44)
            .top()
            .bottom()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        addToShoppingList.layer.cornerRadius = 5
        addToShoppingList.clipsToBounds = true
        
        [name,quantity,addToShoppingList].forEach { addSubview($0) }
    }
}
