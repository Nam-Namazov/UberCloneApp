//
//  LoginController.swift
//  UberCloneApp
//
//  Created by Намик on 10/8/22.
//

import UIKit

final class LoginController: UIViewController {
    private let logoLabel: UILabel = {
        let logoLabel = UILabel()
        logoLabel.text = "UBER"
        logoLabel.font = UIFont(name: "Avenir-Light", size: 36)
        logoLabel.textColor = UIColor(white: 1, alpha: 0.8)
        return logoLabel
    }()
    
    private lazy var emailContainerView: UIView = {
        let emailContainerView = UIView.makeInputContainerView(
            image: UIImage(named: "ic_mail_outline_white_2x")!,
            textField: emailTextField)
        emailContainerView.heightAnchor.constraint(
            equalToConstant: 50
        ).isActive = true
        return emailContainerView
    }()
    
    private let emailTextField = UITextField.makeTextField(
        withPlaceholder: "Email",
        isSecureTextEntry: false
    )
    
    private lazy var passwordContainerView: UIView = {
        let passwordContainerView = UIView.makeInputContainerView(
            image: UIImage(named: "ic_lock_outline_white_2x")!,
            textField: passwordTextField
        )
        passwordContainerView.heightAnchor.constraint(
            equalToConstant: 50
        ).isActive = true
        return passwordContainerView
    }()
    
    private let passwordTextField = UITextField.makeTextField(
        withPlaceholder: "Password",
        isSecureTextEntry: true
    )
    
    private lazy var loginButton: AuthButton = {
        let loginButton = AuthButton(type: .system)
        loginButton.setTitle("Log In", for: .normal)
        loginButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        return loginButton
    }()
    
    private lazy var dontHaveAccountButton: UIButton = {
        let dontHaveAccountButton = UIButton(type: .system)
        
        let dontHaveAccountAttributedText = NSMutableAttributedString(
            string: "Don't have an account?  ",
            attributes: [.font: UIFont.systemFont(ofSize: 16),
                         .foregroundColor: UIColor.lightGray]
        )
        dontHaveAccountAttributedText.append(NSAttributedString(
            string: "Sign Up",
            attributes: [.font: UIFont.boldSystemFont(ofSize: 16),
                         .foregroundColor: UIColor.mainBlueTint])
        )
        dontHaveAccountButton.setAttributedTitle(
            dontHaveAccountAttributedText,
            for: .normal
        )
        return dontHaveAccountButton
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "UBER"
        label.font = UIFont(name: "Avenir-Light", size: 36)
        label.textColor = UIColor(white: 1, alpha: 0.8)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
        targets()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func setup() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    private func style() {
        view.backgroundColor = .backgroundColor
    }
    
    private func layout() {
        view.addSubview(logoLabel)
        logoLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        logoLabel.centerX(inView: view)
        
        let verticalStackView = UIStackView(
            arrangedSubviews: [emailContainerView,
                               passwordContainerView,
                               loginButton])
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fillEqually
        verticalStackView.spacing = 24
        
        view.addSubview(verticalStackView)
        verticalStackView.anchor(
            top: logoLabel.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 40,
            paddingLeft: 16,
            paddingRight: 16
        )
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            height: 32
        )
    }
    
    private func targets() {
        loginButton.addTarget(
            self,
            action: #selector(onLogin)
            , for: .touchUpInside
        )
        dontHaveAccountButton.addTarget(
            self,
            action: #selector(onSignUp),
            for: .touchUpInside
        )
    }
    
    @objc
    private func onSignUp() {
        let controller = SignUpController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc
    private func onLogin() {
        
    }
}
