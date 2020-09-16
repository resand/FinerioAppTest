//
//  SplashViewController.swift
//  FinerioAppTest
//
//  Created by René Sandoval on 14/09/20.
//  Copyright © 2020 Finerio. All rights reserved.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {
    var logoSplashLottie: LOTAnimationView!
    var window: UIWindow!

    override func viewDidLoad() {
        super.viewDidLoad()
        createView()
        addViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNeedsStatusBarAppearanceUpdate()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logoSplashLottie.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            if let currentSession = Utils.getInfoUserDefaults(key: Constants.UserKeys.currentSession) {
                if currentSession == "true" {
                    let frame = LoginWireFrame(in: self.window)
                    frame.rootMovementView()
                    return
                }
            }

            let frame = LoginWireFrame(in: self.window)
            frame.rootLoginViewController()
        }
    }

    func createView() {
        logoSplashLottie = LOTAnimationView(name: "splash.json")
        logoSplashLottie.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        logoSplashLottie.contentMode = .scaleAspectFit
        logoSplashLottie.backgroundColor = .white
    }

    func addViews() {
        view.addSubview(logoSplashLottie)
    }
}
