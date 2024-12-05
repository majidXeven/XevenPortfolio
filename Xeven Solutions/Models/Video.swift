//
//  Video.swift
//  Xeven Solutions
//
//  Created by Muhammad Asar on 06/01/2020.
//  Copyright © 2020 IMedHealth. All rights reserved.
//

import UIKit

class Video: NSObject {
    
    var id: Int
    var title: String
    var isActive: Bool
    var videoUrl: String
    var isDeleted: Bool
    var url: String
    
    override init() {
        id = 0
        title = ""
        isActive = false
        videoUrl = ""
        isDeleted = false
        url = ""
        super.init()
    }
    
    init(dict: [String: Any]) {
        id = dict["id"] as? Int ?? 0
        title = dict["title"] as? String ?? ""
        isActive = dict["isActive"] as? Bool ?? false
        videoUrl = dict["videoUrl"] as? String ?? ""
        isDeleted = dict["isDeleted"] as? Bool ?? false
        url = dict["url"] as? String ?? ""
    }
}
