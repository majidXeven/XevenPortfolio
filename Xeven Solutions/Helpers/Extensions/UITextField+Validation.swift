//
//  UITextField+Validation.swift
//  Xeven Solutions
//
//  Created by Muhammad Asar on 07/01/2020.
//  Copyright © 2020 IMedHealth. All rights reserved.
//

import UIKit

extension UITextField {
    func isValidInput() -> Bool {
        if text == "" || text == nil {
            return false
        }
        let text1 = text?.replacingOccurrences(of: " ", with: "")
        if text1 == "" || text1 == nil {
            return false
        }
        return true
    }
}
