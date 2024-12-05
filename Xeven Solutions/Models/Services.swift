//
//  Services.swift
//  Xeven Solutions
//
//  Created by Muhammad Asar on 06/01/2020.
//  Copyright © 2020 IMedHealth. All rights reserved.
//

import UIKit

class Services: NSObject {
    
    var id: Int
    var servicesName: String
    var serviceDescription: String
    var serviceIcon: String
    var isActive: Bool
    var isDeleted: Bool
    var url: String
    
    override init() {
        id = 0
        servicesName = ""
        serviceDescription = ""
        serviceIcon = ""
        isActive = false
        isDeleted = false
        url = ""
        super.init()
    }
    
    init(dict: [String: Any]) {
        id = dict["id"] as? Int ?? 0
        servicesName = dict["servicesName"] as? String ?? ""
        serviceDescription = dict["serviceDescription"] as? String ?? ""
        serviceIcon = dict["serviceIcon"] as? String ?? ""
        isActive = dict["isActive"] as? Bool ?? false
        isDeleted = dict["isDeleted"] as? Bool ?? false
        url = dict["url"] as? String ?? ""
    }
}
