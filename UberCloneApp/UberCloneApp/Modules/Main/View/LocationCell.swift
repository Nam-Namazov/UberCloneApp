//
//  LocationCell.swift
//  UberCloneApp
//
//  Created by Намик on 10/9/22.
//

import UIKit
import MapKit

final class LocationCell: UITableViewCell {
    
    private let placeTitleLabel: UILabel = {
        let placeTitleLabel = UILabel()
        placeTitleLabel.font = .boldSystemFont(ofSize: 14)
        return placeTitleLabel
    }()
    
    private let addressLabel: UILabel = {
        let addressLabel = UILabel()
        addressLabel.font = .systemFont(ofSize: 14)
        addressLabel.textColor = .lightGray
        addressLabel.numberOfLines = 1
        addressLabel.lineBreakMode = .byTruncatingTail
        addressLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-30).isActive = true
        return addressLabel
    }()

    var placemark: MKPlacemark? {
        didSet {
            placeTitleLabel.text = placemark?.name
            addressLabel.text = placemark?.address
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        layout()
        self.style()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        let verticalStackView = UIStackView(arrangedSubviews: [placeTitleLabel, addressLabel])
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fillEqually
        verticalStackView.spacing = 4
        
        addSubview(verticalStackView)
        verticalStackView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        
        addSubview(verticalStackView)
    }

    private func style() {
        selectionStyle = .none
    }
}
