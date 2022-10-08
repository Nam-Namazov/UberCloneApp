//
//  UIColor + ext.swift
//  UberCloneApp
//
//  Created by Намик on 10/8/22.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat,
                    green: CGFloat,
                    blue: CGFloat) -> UIColor {
        return UIColor(red: red/255,
                       green: green/255,
                       blue: blue/255,
                       alpha: 1)
    }

    static let uber = UIColor.rgb(red: 25, green: 25, blue: 25)
}
