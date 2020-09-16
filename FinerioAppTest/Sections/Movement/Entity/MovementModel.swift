//
//  MovementModel.swift
//  FinerioAppTest
//
//  Created by René Sandoval on 15/09/20.
//  Copyright © 2020 Finerio. All rights reserved.
//


import ObjectMapper

class MovementModel: Mappable {
    var movements: [Movement]?
    var size: Int?

    public convenience required init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        movements <- map["data"]
        size <- map["size"]
    }
}


class Movement: Mappable {
    var id: String?
    var amount: Double?
    var customDate: String?
    var description: String?
    var type: String?
    var concepts: [Concept]?

    public convenience required init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        id <- map["id"]
        amount <- map["amount"]
        customDate <- map["customDate"]
        description <- map["description"]
        type <- map["type"]
        concepts <- map["concepts"]
    }
}

class Concept: Mappable {
    var category: Category?

    public convenience required init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        category <- map["category"]
    }
}

class Category: Mappable {
    var color: String?
    var name: String?
    var textColor: String?

    public convenience required init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        color <- map["color"]
        name <- map["name"]
        textColor <- map["textColor"]
    }
}

