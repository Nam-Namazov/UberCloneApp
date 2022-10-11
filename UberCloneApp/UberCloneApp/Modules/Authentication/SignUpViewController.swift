//
//  SignUpController.swift
//  UberCloneApp
//
//  Created by Намик on 10/8/22.
//

import UIKit
import Firebase
import GeoFire

final class SignUpViewController: UIViewController {

    private var location  = LocationHandler.shared.locationManager.location

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
            textField: emailTextField
        )
        emailContainerView.heightAnchor.constraint(
            equalToConstant: 50
        ).isActive = true
        return emailContainerView
    }()

    private let emailTextField = UITextField.makeTextField(
        withPlaceholder: "Email",
        isSecureTextEntry: false
    )
    
    private lazy var fullnameContainerView: UIView = {
        let fullnameContainerView = UIView.makeInputContainerView(
            image: UIImage(named: "ic_person_outline_white_2x")!,
            textField: fullnameTextField
        )
        fullnameContainerView.heightAnchor.constraint(
            equalToConstant: 50
        ).isActive = true
        return fullnameContainerView
    }()
    
    private let fullnameTextField = UITextField.makeTextField(
        withPlaceholder: "Fullname",
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
    
    private lazy var accountTypeContainerView: UIView = {
        let accountTypeContainerView = UIView.makeInputContainerView(
            image: UIImage(named: "ic_account_box_white_2x")!,
            segmentedControl: accountTypeSegmentedControl
        )
        accountTypeContainerView.heightAnchor.constraint(
            equalToConstant: 80
        ).isActive = true
        return accountTypeContainerView
    }()

    private let accountTypeSegmentedControl: UISegmentedControl = {
        let accountTypeSegmentedControl = UISegmentedControl(items: ["Rider",
                                                                     "Driver"])
        accountTypeSegmentedControl.backgroundColor = .backgroundColor
        accountTypeSegmentedControl.setTitleTextAttributes(
            [.foregroundColor: UIColor(white: 1, alpha: 0.87)],
            for: .normal
        )
        accountTypeSegmentedControl.setTitleTextAttributes(
            [.foregroundColor: UIColor.black],
            for: .selected
        )
        accountTypeSegmentedControl.selectedSegmentIndex = 0
        return accountTypeSegmentedControl
    }()
    
    private lazy var signUpButton: AuthButton = {
        let signUpButton = AuthButton(type: .system)
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        return signUpButton
    }()
    
    private lazy var alreadyHaveAccountButton: UIButton = {
        let alreadyHaveAccountButton = UIButton(type: .system)

        let alreadyHaveAccountAttributedText = NSMutableAttributedString(
            string: "Already have an account?  ",
            attributes: [.font: UIFont.systemFont(ofSize: 16),
                         .foregroundColor: UIColor.lightGray]
        )
        alreadyHaveAccountAttributedText.append(NSAttributedString(
            string: "Sign In",
            attributes: [.font: UIFont.boldSystemFont(ofSize: 16),
                         .foregroundColor: UIColor.mainBlueTint])
        )

        alreadyHaveAccountButton.setAttributedTitle(alreadyHaveAccountAttributedText,
                                                    for: .normal)
        return alreadyHaveAccountButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        targets()
        layout()
        style()
    }
    
    private func layout() {
        view.addSubview(logoLabel)
        logoLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        logoLabel.centerX(inView: view)
        
        let vStack = UIStackView(
            arrangedSubviews: [emailContainerView,
                               fullnameContainerView,
                               passwordContainerView,
                               accountTypeContainerView,
                               signUpButton]
        )
        vStack.axis = .vertical
        vStack.distribution = .equalCentering
        vStack.spacing = 12
        
        view.addSubview(vStack)
        vStack.anchor(top: logoLabel.bottomAnchor,
                      left: view.leftAnchor,
                      right: view.rightAnchor,
                      paddingTop: 40,
                      paddingLeft: 16,
                      paddingRight: 16)
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.centerX(inView: view)
        alreadyHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                        height: 32)
    }
    
    private func style() {
        view.backgroundColor = .backgroundColor
    }
    
    private func targets() {
        signUpButton.addTarget(self,
                               action: #selector(onSignUpComplete),
                               for: .touchUpInside)
        alreadyHaveAccountButton.addTarget(self,
                                           action: #selector(onLogin),
                                           for: .touchUpInside)

    }

    @objc
    private func onLogin() {
        navigationController?.popViewController(animated: true)
    }

    @objc
    private func onSignUpComplete() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let fullname = fullnameTextField.text else {
            return
        }

        let accountTypeIndex = accountTypeSegmentedControl.selectedSegmentIndex

        Auth.auth().createUser(withEmail: email,
                               password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to register user with error \(error.localizedDescription)")
                return
            }

            guard let uid = result?.user.uid else { return }

            let values = ["email": email,
                          "fullname": fullname,
                          "accountType": accountTypeIndex] as [String : Any]

            if accountTypeIndex == 1 {
                let geofire = GeoFire(firebaseRef: REF_DRIVER_LOCATIONS)
                guard let location = self.location else { return }

                geofire.setLocation(location, forKey: uid) { error in
                    self.uploadUserDataAndShowHomeVC(uid: uid, values: values)
                }
            }

            self.uploadUserDataAndShowHomeVC(uid: uid, values: values)
        }
    }

    private func uploadUserDataAndShowHomeVC(uid: String, values: [String: Any]) {
        REF_USERS.child(uid).updateChildValues(values) { error, ref in
            guard let homeVC = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first?.rootViewController as? HomeViewController else {
                return
            }
            homeVC.setup()
            self.dismiss(animated: true)
        }
    }
}
