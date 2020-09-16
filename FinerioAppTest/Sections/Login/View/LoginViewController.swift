//
//  LoginViewController.swift
//  FinerioAppTest
//
//  Created by René Sandoval on 14/09/20.
//  Copyright © 2020 Finerio. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {
    var eventHandler: LoginEventHandler?

    private lazy var titleLabel: UILabel = self.setupTitleLabel()
    private lazy var usernameTexfield: UITextField = self.setupUsernameTexfild(keyboardType: .emailAddress, placeholder: "Correo Electrónico", returnKeyType: .continue)
    private lazy var passwordTexfield: UITextField = self.setupUsernameTexfild(keyboardType: .default, placeholder: "Contraseña (8 o más caracteres)", returnKeyType: .done)
    private lazy var loginButton: UIButton = self.setupLoginButton()

    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ingresar"
    }
    
    override func addViews() {
        [titleLabel, usernameTexfield, passwordTexfield, loginButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    override func setupLayout() {
        // titleLabel
        titleLabel.topAnchor(equalTo: view.topAnchor, constant: 60)
        titleLabel.centerXAnchor(equalTo: view.centerXAnchor)

        // usernameTexfield
        usernameTexfield.topAnchor(equalTo: titleLabel.bottomAnchor, constant: 30)

        // passwordTexfield
        passwordTexfield.topAnchor(equalTo: usernameTexfield.bottomAnchor, constant: 10)

        // loginButton
        loginButton.topAnchor(equalTo: passwordTexfield.bottomAnchor, constant: 30)

        [titleLabel, usernameTexfield, passwordTexfield, loginButton].forEach {
            $0.widthAnchor(equalTo: view.frame.width - 50)
            $0.centerXAnchor(equalTo: view.centerXAnchor)
            $0.heightAnchor(equalTo: 40)
        }
    }
}

// MARK: - Views
extension LoginViewController {
    private func setupTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = label.font.withSize(20)
        label.textColor = UIColor(hex: Constants.Colors.mainColor)
        label.text = "Ingresa con tu correo electrónico"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }

    private func setupUsernameTexfild(keyboardType: UIKeyboardType, placeholder: String, returnKeyType: UIReturnKeyType) -> UITextField {
        let textField = UITextField()
        textField.delegate = self
        textField.keyboardType = keyboardType
        textField.placeholder = placeholder
        textField.returnKeyType = returnKeyType
        textField.isSecureTextEntry = keyboardType == UIKeyboardType.emailAddress ? false : true
        textField.textAlignment = .center
        textField.layer.borderColor = UIColor.mainColor.cgColor
        textField.layer.borderWidth = CGFloat(1.0)
        textField.layer.cornerRadius = CGFloat(10.0)
        textField.font = UIFont.systemFont(ofSize: 16.0)
        return textField
    }

    private func setupLoginButton() -> UIButton {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor.secundaryColor
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        button.setTitle("Ingresar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didSelectLogin), for: .touchUpInside)
        return button
    }
}

extension LoginViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTexfield {
            passwordTexfield.becomeFirstResponder()
        } else {
            passwordTexfield.resignFirstResponder()
        }

        return true
    }
}


extension LoginViewController {
    @objc private func didSelectLogin() {
        if !connectionStatus() {
            Utils.showAlert(title: "Error", message: "No tienes conexión a Internet", context: self)
            return
        } else {
            startLoader()
            usernameTexfield.resignFirstResponder()
            passwordTexfield.resignFirstResponder()
            if usernameTexfield.text?.isEmpty ?? false {
                stopLoader()
                Utils.showAlert(title: "Error al ingresar", message: "Necesitamos tu correo electrónico", context: self)
                return
            }

            if passwordTexfield.text?.isEmpty ?? false {
                stopLoader()
                Utils.showAlert(title: "Error al ingresar", message: "Necesitamos tu contraseña", context: self)
                return
            }
        }

        eventHandler?.sendLogin(username: usernameTexfield.text!, password: passwordTexfield.text!)
    }
}

extension LoginViewController: LoginView {
    func loginResponseSuccess(response: SessionModel) {
        Utils.saveInfoUserDefaults(value: "true", key: Constants.UserKeys.currentSession)
        eventHandler?.sendUser()
    }

    func loginResponseFail(response: String) {
        stopLoader()
        Utils.showAlert(title: "Error", message: response, context: self)
    }

    func loginResponseServiceFail(response: String) {
        stopLoader()
        Utils.showAlert(title: "Error al ingresar", message: response, context: self)
    }

    func userResponseSuccess(response: UserModel) {
        stopLoader()
        eventHandler?.showMovementEvent()
    }

    func userResponseFail(response: String) {
        stopLoader()
        Utils.showAlert(title: "Error", message: response, context: self)
    }

    func userResponseServiceFail(response: String) {
        stopLoader()
        Utils.showAlert(title: "Error al ingresar", message: response, context: self)
    }
}

