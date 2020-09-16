//
//  LoginWireFrame.swift
//  FinerioAppTest
//
//  Created by René Sandoval on 14/09/20.
//  Copyright © 2020 Finerio. All rights reserved.
//

import UIKit

class LoginWireFrame {
    private var view: LoginViewController?
    private let presenter: LoginPresenter?
    private let interactor: LoginInteractor?
    private var window: UIWindow?

    init(in window: UIWindow?) {
        self.view = LoginViewController()
        self.presenter = LoginPresenter()
        self.interactor = LoginInteractor()

        self.view?.eventHandler = self.presenter
        self.presenter?.view = self.view
        self.presenter?.provider = self.interactor
        self.interactor?.output = presenter
        self.presenter?.wireframe = self
        self.window = window
    }

    func rootLoginViewController() {
        self.window?.rootViewController = UINavigationController(rootViewController: self.view!)
        self.window?.makeKeyAndVisible()
    }

    func rootMovementView() {
        let frame = MovementWireFrame(in: self.window)
        frame.rootMovementViewController()
    }
}
