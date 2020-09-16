//
//  Constants.swift
//  FinerioAppTest
//
//  Created by René Sandoval on 14/09/20.
//  Copyright © 2020 Finerio. All rights reserved.
//

import Foundation

struct Constants {

    /// URL
    static let BaseUrl = "https://api.finerio.mx/api/"
    static let TokenUrl = "https://api.finerio.mx/oauth/access_token"

    /// Tags
    struct Endpoints {
        static let login = "login"
        static let user = "me"
        static let movement = "users/{id}/movements?deep=true&includeDuplicates=true&offset={0}&max=10"
    }
    
    /// Colors
    struct Colors {
        static let mainColor = "#18307A"
        static let secundaryColor = "#2CB7EF"
    }
    
    /// UserKeys
    struct UserKeys {
        static let currentSession = "currentSession"
        static let userId = "userId"
        static let userName = "username"
        static let name = "name"
        static let email = "email"
        static let accessToken = "access_token"
        static let refreshToken = "refresh_token"
    }
}
