//
//  SessionEntity.swift
//  FinerioAppTest
//
//  Created by René Sandoval on 14/09/20.
//  Copyright © 2020 Finerio. All rights reserved.
//

import Foundation
import ObjectMapper

class SessionModel: Mappable {
    var username: String?
    var tokenType: String?
    var accessToken: String?
    var refreshToken: String?
    var hasError: Bool?
    
    public convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        username <- map["username"]
        tokenType <- map["token_type"]
        accessToken <- map["access_token"]
        refreshToken <- map["refresh_token"]
    }
}
