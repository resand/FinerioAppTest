//
//  FinerioServices.swift
//  FinerioAppTest
//
//  Created by René Sandoval on 14/09/20.
//  Copyright © 2020 Finerio. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

class CustomerService {
    static func loginRequest(username: String, password: String, completion: @escaping (GenericResponse?, Error?) -> ()) {
        let url = Utils.CreateURL(requestName: Constants.Endpoints.login).urlString
        let parameters: Parameters = [
            "username": username,
            "password": password,
        ]

        Connection.post(url: url, param: parameters) { (response, error) in
            if error != nil {
                completion(nil, error)
            } else {
                completion(response, nil)
            }
        }
    }

    static func userRequest(completion: @escaping (GenericResponse?, Error?) -> ()) {
        let url = Utils.CreateURL(requestName: Constants.Endpoints.user).urlString

        Connection.get(url: url) { (response, error) in
            if error != nil {
                completion(nil, error)
            } else {
                completion(response, nil)
            }
        }
    }

    static func movementRequest(page: Int, completion: @escaping (GenericResponse?, Error?) -> ()) {
        let userId = Utils.getInfoUserDefaults(key: Constants.UserKeys.userId)!
        let url = Utils.CreateURL(requestName: Constants.Endpoints.movement
            .replacingOccurrences(of: "{id}", with: userId)
            .replacingOccurrences(of: "{0}", with: String(page))).urlString

        Connection.get(url: url) { (response, error) in
            if error != nil {
                completion(nil, error)
            } else {
                completion(response, nil)
            }
        }
    }
}
