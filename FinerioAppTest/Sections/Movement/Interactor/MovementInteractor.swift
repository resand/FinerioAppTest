//
//  MovementInteractor.swift
//  FinerioAppTest
//
//  Created by René Sandoval on 15/09/20.
//  Copyright © 2020 Finerio. All rights reserved.
//

class MovementInteractor: MovementProvider {
    weak var output: MovementOutput?
    
    func movementRequest(page: Int) {
        CustomerService.movementRequest(page: page) {
            (response, error) in
            if response?.code == 500 || response?.code == 404 {
                self.output?.movementResponse(response: "Error del servidor")
            }
            else if response?.code == 401 {
                self.output?.movementResponse(response: "Alguno de tus datos es incorrecto")
            } else if error != nil {
                self.output?.movementResponse(response: error.debugDescription)
            } else {
                let responseModel = MovementModel(JSON: (response?.response)!)
                self.output?.movementResponse(response: responseModel)
            }
        }
    }
}
