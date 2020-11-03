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
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        
        
    }
    func setup(){
        dishName.font = UIFont(name: "Verdana", size: 18.0)
        dishName.textAlignment = .center
        dishImage.layer.cornerRadius = 10
        dishImage.clipsToBounds = true
        timeCooking.font = UIFont(name: "Verdana", size: 16.0)
        timeCooking.textAlignment = .right
        timeCooking.textColor = .white
        
    }
    
    
    var dishImage = UIImageView()
    var dishName = UILabel()
    var timeCooking = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()

     
        
        dishImage.pin
            .height(Constants.dishImageHeight)
            .top(Constants.standardIndent)
            .left(Constants.standardIndent)
            .right(Constants.standardIndent)
        
        dishName.pin
            .height(Constants.dishNameHeight)
            .bottom(Constants.standardIndent)
            .left(Constants.standardIndent)
            .right(Constants.standardIndent)
        
        timeCooking.pin
            .height(Constants.timeCookingHeight)
            .bottom(Constants.standardIndent * 6)
            .right(Constants.standardIndent * 2)
            .width(Constants.standardIndent * 8)
        
//        dotView.pin
//            .size(Constants.dotDiameter)
//            .after(of: titleLabel)
//            .marginLeft(Constants.dotLeftMargin)
//            .top(to: titleLabel.edge.top)
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubview(dishImage)
        addSubview(dishName)
        
        addSubview(timeCooking)
        setup()
    }
    
}
