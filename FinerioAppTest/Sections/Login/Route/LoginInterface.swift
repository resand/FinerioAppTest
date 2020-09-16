//
//  LoginInterface.swift
//  FinerioAppTest
//
//  Created by René Sandoval on 14/09/20.
//  Copyright © 2020 Finerio. All rights reserved.
//

import Foundation
import UIKit

protocol LoginView: class {
    func loginResponseSuccess(response: SessionModel)
    func loginResponseFail(response: String)
    func loginResponseServiceFail(response: String)
    
    func userResponseSuccess(response: UserModel)
    func userResponseFail(response: String)
    func userResponseServiceFail(response: String)
}

protocol LoginEventHandler {
    func sendLogin(username: String, password: String)
    func sendUser()
    func showMovementEvent()
}

protocol LoginOutput: class {
    func loginResponse<T>(response: T)
    func userResponse<T>(response: T)
}

protocol LoginProvider {
    func loginRequest(username: String, password: String)
    func userRequest()
}
