//
//  LoginInteractor.swift
//  FinerioAppTest
//
//  Created by René Sandoval on 14/09/20.
//  Copyright © 2020 Finerio. All rights reserved.
//

class LoginInteractor: LoginProvider {
    weak var output: LoginOutput?
    
    func loginRequest(username: String, password: String) {
        CustomerService.loginRequest(username: username, password: password) {
            (response, error) in
            if response?.code == 500 || response?.code == 404 {
                self.output?.loginResponse(response: "Error del servidor")
            }
            else if response?.code == 401 {
                self.output?.loginResponse(response: "Alguno de tus datos es incorrecto")
            } else if error != nil {
                self.output?.loginResponse(response: error.debugDescription)
            } else {
                let responseModel = SessionModel(JSON: (response?.response)!)
                Utils.saveInfoUserDefaults(value: responseModel?.username ?? "", key: Constants.UserKeys.userName)
                Utils.saveInfoUserDefaults(value: responseModel?.accessToken ?? "", key: Constants.UserKeys.accessToken)
                Utils.saveInfoUserDefaults(value: responseModel?.refreshToken ?? "", key: Constants.UserKeys.refreshToken)
                self.output?.loginResponse(response: responseModel)
            }
        }
    }
    
    func userRequest() {
        CustomerService.userRequest() {
            (response, error) in
            if response?.code == 500 || response?.code == 404 {
                self.output?.userResponse(response: "Error del servidor")
            }
            else if response?.code == 401 {
                self.output?.userResponse(response: "Error de token")
            } else if error != nil {
                self.output?.userResponse(response: error.debugDescription)
            } else {
                let responseModel = UserModel(JSON: (response?.response)!)
                Utils.saveInfoUserDefaults(value: responseModel?.id ?? "", key: Constants.UserKeys.userId)
                Utils.saveInfoUserDefaults(value: responseModel?.name ?? "", key: Constants.UserKeys.name)
                Utils.saveInfoUserDefaults(value: responseModel?.email ?? "", key: Constants.UserKeys.email)
                self.output?.userResponse(response: responseModel)
            }
        }
    }
}
