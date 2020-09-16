//
//  MovementInterface.swift
//  FinerioAppTest
//
//  Created by René Sandoval on 15/09/20.
//  Copyright © 2020 Finerio. All rights reserved.
//

import Foundation
import UIKit

protocol MovementView: class {
    func movementResponseSuccess(response: MovementModel)
    func movementResponseFail(response: String)
    func movementResponseServiceFail(response: String)
}

protocol MovementEventHandler {
    func sendMovement(page: Int)
    func sendLogin()
}

protocol MovementOutput: class {
    func movementResponse<T>(response: T)
}

protocol MovementProvider {
    func movementRequest(page: Int)
}
