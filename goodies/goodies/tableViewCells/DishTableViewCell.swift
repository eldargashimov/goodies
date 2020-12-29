//
//  DishTableViewCell.swift
//  goodies
//
//  Created by Mac on 10/21/20.
//

import UIKit
import PinLayout

private struct Constants {
    static let standardIndent: CGFloat = 8.0
    static let timeCookingHeight: CGFloat = 18.0
    static let dishNameHeight: CGFloat = 20.0
    static let dishImageHeight: CGFloat = 250.0
}

final class DishTableViewCell: UITableViewCell {
    
    var dishImage = UIImageView()
    var dishName = UILabel()
    var timeCooking = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dishImage.pin
            .top(Constants.standardIndent)
            .left(Constants.standardIndent)
            .right(Constants.standardIndent)
            .height(Constants.dishImageHeight)

        dishName.pin
            .height(self.bounds.height - Constants.dishImageHeight - 3 * Constants.standardIndent)
            .top(to: dishImage.edge.bottom)
            .left(Constants.standardIndent)
            .right(Constants.standardIndent)
            .margin(Constants.standardIndent)

        timeCooking.pin
            .height(Constants.timeCookingHeight)
            .right(to: dishImage.edge.right)
            .bottom(to: dishImage.edge.bottom)
            .width(104)
            .margin(Constants.standardIndent)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        
        [dishImage, dishName, timeCooking].forEach { addSubview($0) }
    }
    
    static func height(for model: String, width: CGFloat) -> CGFloat {
        return model.height(for: width, font: UIFont(name: "Verdana", size: 18.0)!) + 3 * Constants.standardIndent + Constants.dishImageHeight
    }
}
