//
//  GenericResponse.swift
//  FinerioAppTest
//
//  Created by René Sandoval on 14/09/20.
//  Copyright © 2020 Finerio. All rights reserved.
//

import Foundation

class GenericResponse {
    var code: Int = Int()
    var response: [String: Any]


    init(code: Int, response: [String: Any]) {
        self.code = code
        self.response = response
    }
}
