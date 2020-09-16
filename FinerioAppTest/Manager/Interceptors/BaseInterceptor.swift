//
//  BaseInterceptor.swift
//  FinerioAppTest
//
//  Created by René Sandoval on 15/09/20.
//  Copyright © 2020 Finerio. All rights reserved.
//

import Alamofire

class BaseInterceptor: RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        if let urlString = urlRequest.url?.absoluteString, urlString.hasPrefix(Constants.BaseUrl) {
            var urlRequest = urlRequest
            urlRequest.setValue("Bearer " + Utils.getInfoUserDefaults(key: Constants.UserKeys.accessToken)!, forHTTPHeaderField: "Authorization")
            completion(.success(urlRequest))
        }
    }

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        if let urlString = request.request?.url?.absoluteString, urlString.hasPrefix(Constants.BaseUrl), request.response?.statusCode == 401 {
            let url = Constants.TokenUrl
            let parameters: Parameters = [
                "grant_type": "refresh_token",
                "refresh_token": Utils.getInfoUserDefaults(key: Constants.UserKeys.refreshToken)!,
            ]

            AF.request(url, method: .post, parameters: parameters)
                .validate(statusCode: 200..<500)
                .responseJSON {
                    (response) in
                    switch response.result {
                    case .success(let value):
                        let code = response.response?.statusCode
                        let generic = GenericResponse(code: code!, response: value as! [String: Any])
                        let responseModel = SessionModel(JSON: (generic.response))

                        Utils.saveInfoUserDefaults(value: responseModel?.accessToken ?? "", key: Constants.UserKeys.accessToken)
                        Utils.saveInfoUserDefaults(value: responseModel?.refreshToken ?? "", key: Constants.UserKeys.refreshToken)
                        break
                    case .failure:
                        break
                    }
            }
            completion(.retry)
        }
    }
}
