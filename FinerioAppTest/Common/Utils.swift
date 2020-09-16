//
//  Utils.swift
//  FinerioAppTest
//
//  Created by René Sandoval on 14/09/20.
//  Copyright © 2020 Finerio. All rights reserved.
//

import Foundation
import UIKit
import LocalAuthentication

class Utils: NSObject {

    struct ServerConfig {
        static let url = Constants.BaseUrl
    }

    struct CreateURL {
        var urlString = ""

        init(requestName: String) {
            urlString = String.init(format: "%@%@", ServerConfig.url, requestName)
        }
    }

    static func saveInfoUserDefaults(value: String, key: String) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
    }

    static func getInfoUserDefaults(key: String) -> String? {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: key)
    }

    static func showAlert(title: String, message: String, context: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style {
            case .default:
                break
            case .cancel:
                break
            case .destructive:
                break

            @unknown default:
                break
            } }))
        context.present(alert, animated: true, completion: nil)
    }
    
    static func formatAmount(_ amount: Double) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "es_MX")
        
        return currencyFormatter.string(from: NSNumber(value: amount))!
    }
}
