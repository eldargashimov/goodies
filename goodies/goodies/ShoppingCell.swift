//
//  ShoppingCell.swift
//  goodies
//
//  Created by Karbyshev Maxim on 19/11/2020.
//

import UIKit

class ShoppingCell: UITableViewCell {

    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var checkmarkImageView: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
