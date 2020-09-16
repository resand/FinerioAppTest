//
//  LoginPresenter.swift
//  FinerioAppTest
//
//  Created by René Sandoval on 14/09/20.
//  Copyright © 2020 Finerio. All rights reserved.
//

class LoginPresenter: LoginOutput {
    weak var view: LoginView?
    var provider: LoginProvider?
    var wireframe: LoginWireFrame?

    func loginResponse<T>(response: T) {
        switch response {
        case is SessionModel:
            view?.loginResponseSuccess(response: response as! SessionModel)
        case is String:
            view?.loginResponseServiceFail(response: response as! String)
            break
        default:
            break
        }
    }
    
    func userResponse<T>(response: T) {
        switch response {
        case is UserModel:
            view?.userResponseSuccess(response: response as! UserModel)
        case is String:
            view?.userResponseServiceFail(response: response as! String)
            break
        default:
            break
        }
    }
}

extension LoginPresenter: LoginEventHandler {
    func sendLogin(username: String, password: String) {
        provider?.loginRequest(username: username, password: password)
    }
    
    func sendUser() {
        provider?.userRequest()
    }

    func showMovementEvent() {
        wireframe?.rootMovementView()
    }
}
