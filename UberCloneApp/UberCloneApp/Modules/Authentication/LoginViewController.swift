//
//  LoginController.swift
//  UberCloneApp
//
//  Created by Намик on 10/8/22.
//

import UIKit
import Firebase

final class LoginViewController: UIViewController {

    private let logoLabel: UILabel = {
        let logoLabel = UILabel()
        logoLabel.text = "UBER"
        logoLabel.font = UIFont(name: "Avenir-Light", size: 36)
        logoLabel.textColor = UIColor(white: 1, alpha: 0.8)
        return logoLabel
    }()

    private lazy var emailContainerView: UIView = {
        let emailContainerView = UIView.makeInputContainerView(image: UIImage(named: "ic_mail_outline_white_2x")!, textField: emailTextField)
        emailContainerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return emailContainerView
    }()
    
    private let emailTextField = UITextField.makeTextField(withPlaceholder: "Email", isSecureTextEntry: false)
    
    private lazy var passwordContainerView: UIView = {
        let passwordContainerView = UIView.makeInputContainerView(image: UIImage(named: "ic_lock_outline_white_2x")!, textField: passwordTextField)
        passwordContainerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return passwordContainerView
    }()
    
    private let passwordTextField = UITextField.makeTextField(withPlaceholder: "Password", isSecureTextEntry: true)
    
    private let loginButton: AuthButton = {
        let loginButton = AuthButton(type: .system)
        loginButton.setTitle("Log In", for: .normal)
        loginButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        loginButton.addTarget(self, action: #selector(onLogin), for: .touchUpInside)
        return loginButton
    }()
    
    private let dontHaveAccountButton: UIButton = {
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
        dontHaveAccountButton.setAttributedTitle(dontHaveAccountAttributedText, for: .normal)
        dontHaveAccountButton.addTarget(self, action: #selector(onSignUp), for: .touchUpInside)
        
        return dontHaveAccountButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layout()
        style()
    }
    
    private func setup() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    private func layout() {
        view.addSubview(logoLabel)
        logoLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        logoLabel.centerX(inView: view)
        
        let verticalStackView = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fillEqually
        verticalStackView.spacing = 24
        
        view.addSubview(verticalStackView)
        verticalStackView.anchor(top: logoLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, height: 32)
    }
    
    private func style() {
        view.backgroundColor = .backgroundColor
    }

    @objc private func onSignUp() {
        let signUpViewController = SignUpViewController()
        navigationController?.pushViewController(signUpViewController, animated: true)
    }

    @objc private func onLogin() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else {
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to log user in with error \(error.localizedDescription)")
                return
            }

            guard let homeViewController = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first?.rootViewController as? HomeController else {
                return
            }

            homeViewController.setup()
            self.dismiss(animated: true)
        }
    }
}
