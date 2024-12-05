//
//  Portfolio.swift
//  Xeven Solutions
//
//  Created by Muhammad Asar on 03/01/2020.
//  Copyright © 2020 IMedHealth. All rights reserved.
//

import UIKit

class Portfolio: NSObject {
    
    var id: Int
    var title: String
    var descriptions: String
    var url: String
    var tag: String
    var technology: String
    var isVisible: Int
    var isCaseStudy: Int
    var showAt: Int
    var images: String
    var projectCategoryId: Int
    
    override init() {
        id = 0
        title = ""
        descriptions = ""
        url = ""
        tag = ""
        technology = ""
        isVisible = 0
        isCaseStudy = 0
        showAt = 0
        images = ""
        projectCategoryId = 0
        super.init()
    }
    
    init(dict: [String: Any]) {
        id = dict["id"] as? Int ?? 0
        title = dict["projectTitle"] as? String ?? ""
        descriptions = dict["description"] as? String ?? ""
        url = dict["demoUrl"] as? String ?? ""
        tag = dict["tags"] as? String ?? ""
        technology = dict["technologies"] as? String ?? ""
        isVisible = dict["IsVisible"] as? Int ?? 0
        isCaseStudy = dict["IsCaseStudy"] as? Int ?? 0
        showAt = dict["ShowAt"] as? Int ?? 0
        images = dict["featuredImage"] as? String ?? ""
        projectCategoryId = dict["projectCategoryId"] as? Int ?? 0
    }
}

