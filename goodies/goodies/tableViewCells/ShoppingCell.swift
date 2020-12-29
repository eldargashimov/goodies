
import UIKit
import PinLayout

class ShoppingCell: UITableViewCell {
    
    var nameLabel = UILabel()
    var quantityLabel = UILabel()
    var checkImage = UIImageView()
    
    override func layoutSubviews() {
        
//        imageView?.pin.vCenter().left().margin(10).width(27)
        
        checkImage.pin
            .vCenter()
            .left()
            .width(27)
            .height(27)
            .margin(10)
        
        quantityLabel.pin
            .right()
            .top()
            .bottom()
            .width(80)
            .margin(10)
        
        nameLabel.pin
            .left(to: checkImage.edge.right)
            .top()
            .bottom()
            .right(to: quantityLabel.edge.left)
            .margin(10)
    }
    override func awakeFromNib() {
    
        setup()
    }
    
    private func setup() {

        [checkImage,
         quantityLabel,
         nameLabel].forEach { addSubview($0) }
    }
}
