//
//  HeaderRecipeCardCell.swift
//  goodies
//
//  Created by Mac on 12/29/20.
//

import UIKit

class HeaderRecipeCardCell: UITableViewCell {
    
    private let margin: CGFloat = 10.0
    
    var titleImage = UIImageView()
    var timeCookingLabel = UILabel()
    var dishDescription = UILabel()
    var calories = UILabel()
    var nutrilons = UILabel()
    var portions = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
       
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    override func layoutSubviews() {
        
        titleImage.pin
            .top()
            .left()
            .right()
            .height(250)
            .margin(margin)
        
        dishDescription.pin
            .top(to:titleImage.edge.bottom)
            .left()
            .right()
            .height(self.bounds.height - 250 - 100 - 20 - 4 * margin)
            .margin(margin)
            
        calories.pin
            .top(to:dishDescription.edge.bottom)
            .left()
            .height(100)
            .width(150)
            .margin(margin)
        
        timeCookingLabel.pin
            .bottom(to: titleImage.edge.bottom)
            .right(to: titleImage.edge.right)
            .height(20)
            .width(110)
            .margin(margin)
        
        nutrilons.pin
            .top(to: dishDescription.edge.bottom)
            .right()
            .height(100)
            .width(150)
            .margin(margin)
        
        portions.pin
            .top(to: nutrilons.edge.bottom)
            .right()
            .left()
            .height(20)
            .margin(margin)
    }
    
    private func setupViews() {
        
        [titleImage,
         timeCookingLabel,
         dishDescription,
         calories,
         nutrilons,
         portions].forEach { addSubview($0) }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func height(for model: String, width: CGFloat) -> CGFloat {
        return model.height(for: width, font: UIFont(name: "Verdana", size: 14.0)!) + 250 + 100 + 20 + 4 * 10
    }
}
