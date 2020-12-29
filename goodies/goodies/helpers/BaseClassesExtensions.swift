//
//  BaseClassesExtensions.swift
//  goodies
//
//  Created by Mac on 12/28/20.
//

import Foundation
import UIKit

extension String {
    func height(for width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
}
