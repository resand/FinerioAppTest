//
//  MovementPresenter.swift
//  FinerioAppTest
//
//  Created by René Sandoval on 15/09/20.
//  Copyright © 2020 Finerio. All rights reserved.
//

class MovementPresenter: MovementOutput {
    weak var view: MovementView?
    var provider: MovementProvider?
    var wireframe: MovementWireFrame?

    func movementResponse<T>(response: T) {
        switch response {
        case is MovementModel:
            view?.movementResponseSuccess(response: response as! MovementModel)
        case is String:
            view?.movementResponseServiceFail(response: response as! String)
            break
        default:
            break
        }
    }
}

extension MovementPresenter: MovementEventHandler {
    func sendMovement(page: Int) {
        provider?.movementRequest(page: page)
    }
    
    func sendLogin() {
        wireframe?.rootLoginViewController()
    }
}
