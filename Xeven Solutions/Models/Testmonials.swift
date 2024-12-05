//
//  Testmonials.swift
//  Xeven Solutions
//
//  Created by Muhammad Asar on 06/01/2020.
//  Copyright © 2020 IMedHealth. All rights reserved.
//

import UIKit

class Testmonials: NSObject {
    
    var id: Int
    var clientName: String
    var clientReview: String
    var featureImage: String
    var isActive: Bool
    var isDeleted: Bool
    var stars: Int
    var url: String
    
    override init() {
        id = 0
        clientName = ""
        clientReview = ""
        featureImage = ""
        isActive = false
        isDeleted = false
        stars = 0
        url = ""
        super.init()
    }
    
    init(dict: [String: Any]) {
        id = dict["id"] as? Int ?? 0
        clientName = dict["clientName"] as? String ?? ""
        clientReview = dict["clientReview"] as? String ?? ""
        featureImage = dict["featureImage"] as? String ?? ""
        isActive = dict["isActive"] as? Bool ?? false
        isDeleted = dict["isDeleted"] as? Bool ?? false
        stars = dict["stars"] as? Int ?? 0
        url = dict["url"] as? String ?? ""
    }
}

