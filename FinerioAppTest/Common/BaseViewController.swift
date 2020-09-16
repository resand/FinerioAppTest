//
//  BaseViewController.swift
//  FinerioAppTest
//
//  Created by René Sandoval on 14/09/20.
//  Copyright © 2020 Finerio. All rights reserved.
//

import Foundation
import UIKit

open class BaseViewController: UIViewController {

    var offset = 0

    func configurationView() {
        view.backgroundColor = .white
    }

    func addViews() {

    }

    func setupLayout() {

    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        configurationView()
        addViews()
        setupLayout()
    }

    func stopLoader() {
        self.navigationController?.isNavigationBarHidden = false
        self.view.removeLoader()
    }

    func startLoader(gameAnimation: Bool = false) {
        self.navigationController?.isNavigationBarHidden = true
        self.view.addLoader(gameAnimation: gameAnimation)
    }

    func connectionStatus() -> Bool {
        let status = Reach().connectionStatus()

        switch status {
        case .unknown, .offline:
            return false
        case .online(.wwan):
            return true
        case .online(.wiFi):
            return true
        }
    }
}
