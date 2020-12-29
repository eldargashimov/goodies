import UIKit
import PinLayout

class StepCell: UITableViewCell {

    var stepNumber = UILabel()
    var stepDescription = UILabel()
    var stepImage = UIImageView()
//    var timerButton = UIButton()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        stepNumber.pin
            .top()
            .height(20)
            .left()
            .right()
            .margin(10)
         
        stepImage.pin
            .top(to: stepNumber.edge.bottom)
            .height(250)
            .left()
            .right()
            .margin(10)
        
        stepDescription.pin
            .top(to: stepImage.edge.bottom)
            .left()
            .right()
            .bottom()
            .margin(10)
        
//        timerButton.pin
//            .bottom(to: stepImage.edge.bottom)
//            .right(to: stepImage.edge.right)
//            .width(44)
//            .height(44)
//            .margin(10)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        stepImage.layer.cornerRadius = 20
        stepImage.clipsToBounds = true
        
        [stepNumber,stepImage,stepDescription/*,timerButton*/].forEach { addSubview($0) }
    }
    
    static func height(for model: String, width: CGFloat) -> CGFloat {
        return model.height(for: width, font: UIFont(name: "Verdana", size: 14.0)!) + 4 * 10 + 250 + 20
    }
}
