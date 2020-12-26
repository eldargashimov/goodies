import UIKit
import PinLayout

class StepCell: UITableViewCell {

    var stepNumber = UILabel()
    var stepDescription = UILabel()
    var stepImage = UIImageView()
    var timerButton = UIButton()
    
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
        
        timerButton.pin
            .bottom(to: stepImage.edge.bottom)
            .right(to: stepImage.edge.right)
            .width(44)
            .height(44)
            .margin(10)
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
        
        timerButton.backgroundColor = .gray
        timerButton.isHidden = true
        timerButton.layer.cornerRadius = 5
        timerButton.clipsToBounds = true
        
        [stepNumber,stepImage,stepDescription,timerButton].forEach { addSubview($0) }
    }
}
