//
//  UIImageView+kf.swift
//  Xeven Solutions
//
//  Created by Muhammad Asar on 30/12/2019.
//  Copyright © 2019 IMedHealth. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func set(url: URL, placeholder: String = "placeholder") {
        self.kf.setImage(with: url,placeholder: UIImage(named: placeholder))
    }
    
    func set(urlString: String, placeholder: String = "placeholder") {
        if let url = URL(string: urlString.replacingOccurrences(of: " ", with: "%20")) {
            set(url: url, placeholder: placeholder)
        }else {
            self.image = UIImage(named: placeholder)
        }
    }
    
    func getImage(urlString: String, completionHandler: @escaping (_ imageSize: CGSize?) -> Void) {
        if let url = URL(string: urlString) {
            self.kf.indicatorType = .activity
            self.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), options: nil, progressBlock: nil) { (result) in
                switch result {
                case .success(let value):
                    let imageSize = value.image.size
                    completionHandler(imageSize)
                    break
                case .failure(_):
                    completionHandler(nil)
                    break
                }
            }
        }
    }
}

