//
//  Connection.swift
//  FinerioAppTest
//
//  Created by René Sandoval on 14/09/20.
//  Copyright © 2020 Finerio. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class Connection {
    static func get(url: String?, closure: @escaping (GenericResponse?, Error?) -> Void) {
        print("""
            --------------------
            
            REQUEST INFO
            
            HttpMethod:     Get
            Url:            \(url!)
            """)
        AF.request(url ?? "", method: .get, encoding: JSONEncoding.default, interceptor: BaseInterceptor())
            .validate(statusCode: 200...400)
            .responseJSON {
                (response) in
                print("\n       RESPONSE INFO:: \(String(describing: response.result))")
                switch response.result {
                case .success(let value):
                    print("=================== \n\n SUCCESS: \(String(describing: value))")
                    let code = response.response?.statusCode
                    let generic = GenericResponse(code: code!, response: value as! [String: Any])
                    closure(generic, nil)
                    break
                case .failure(let error):
                    print("=================== \n\n Error: \(String(describing: error))")
                    closure(nil, error)
                    break
                }
        }
    }

    static func post(url: String?, param: Parameters, closure: @escaping (GenericResponse?, Error?) -> Void) {
        print("""
            --------------------
            
            REQUEST INFO
            
            HttpMethod:     Post
            Url:            \(url!)
            Body:           \(String(describing: param))
            """)
        AF.request(url ?? "", method: .post, parameters: param, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<500)
            .responseJSON {
                (response) in
                print("\n       RESPONSE INFO:: \(String(describing: response.result))")

                if response.response?.statusCode == 401 {
                    let code = response.response?.statusCode
                    let generic = GenericResponse(code: code!, response: [:])
                    closure(generic, nil)
                    return
                }

                switch response.result {
                case .success(let value):
                    print("=================== \n\n SUCCESS: \(String(describing: value))")
                    let code = response.response?.statusCode
                    let generic = GenericResponse(code: code!, response: value as! [String: Any])
                    closure(generic, nil)
                    break
                case .failure(let error):
                    print("=================== \n\n Error: \(String(describing: error))")
                    closure(nil, error)
                    break
                }
        }
    }
}
