//
//  LocationCell.swift
//  UberCloneApp
//
//  Created by Намик on 10/9/22.
//

import UIKit

final class LocationCell: UITableViewCell {
    static let identifier = "LocationCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
