//
//  MovementWireFrame.swift
//  FinerioAppTest
//
//  Created by René Sandoval on 15/09/20.
//  Copyright © 2020 Finerio. All rights reserved.
//

import UIKit

class MovementWireFrame {
    private var view: MovementViewController?
    private let presenter: MovementPresenter?
    private let interactor: MovementInteractor?
    private var window: UIWindow?

    init(in window: UIWindow?) {
        self.view = MovementViewController()
        self.presenter = MovementPresenter()
        self.interactor = MovementInteractor()

        self.view?.eventHandler = self.presenter
        self.presenter?.view = self.view
        self.presenter?.provider = self.interactor
        self.interactor?.output = presenter
        self.presenter?.wireframe = self
        self.window = window
    }

    func rootMovementViewController() {
        self.window?.rootViewController = UINavigationController(rootViewController: self.view!)
        self.window?.makeKeyAndVisible()
    }

    func rootLoginViewController() {
        let frame = LoginWireFrame(in: self.window)
        frame.rootLoginViewController()
    }
}
