//
//  UITextField.swift
//  UberCloneApp
//
//  Created by Намик on 10/8/22.
//

import UIKit

extension UITextField {
    static func makeTextField(withPlaceholder placeholder: String, isSecureTextEntry: Bool) -> UITextField {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.font = .systemFont(ofSize: 16)
        textField.textColor = .white
        textField.keyboardAppearance = .dark
        textField.isSecureTextEntry = isSecureTextEntry
        textField.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                             attributes: [.foregroundColor: UIColor.lightGray])
        return textField
    }
}
