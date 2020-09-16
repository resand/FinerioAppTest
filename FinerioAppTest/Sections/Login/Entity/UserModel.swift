//
//  UserModel.swift
//  FinerioAppTest
//
//  Created by René Sandoval on 14/09/20.
//  Copyright © 2020 Finerio. All rights reserved.
//

import Foundation
import ObjectMapper

class UserModel: Mappable {
    var id: String?
    var email: String?
    var name: String?
    
    public convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        email <- map["email"]
        name <- map["name"]
    }
}
