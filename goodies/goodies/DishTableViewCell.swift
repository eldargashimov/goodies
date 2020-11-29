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
    static let dishImageHeight: CGFloat = 200.0
    static let timeCookingHeight: CGFloat = 18.0
    static let dishNameHeight: CGFloat = 20.0
}

class DishTableViewCell: UITableViewCell {
    
    var dishImage = UIImageView()
    var dishName = UILabel()
    var timeCooking = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dishImage.pin
//            .height(Constants.dishImageHeight)
            .top(Constants.standardIndent)
            .left(Constants.standardIndent)
            .right(Constants.standardIndent)
            .height(dishImage.bounds.width * 386 / 580)
        
        dishName.pin
            .height(Constants.dishNameHeight)
            .bottom(Constants.standardIndent)
            .left(Constants.standardIndent)
            .right(Constants.standardIndent)
        
        timeCooking.pin
            .height(Constants.timeCookingHeight)
            .bottom(Constants.standardIndent * 6)
            .right(Constants.standardIndent * 2)
            .width(Constants.standardIndent * 13)

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        [dishImage, dishName, timeCooking].forEach { addSubview($0) }
    }
    
    
    
}
