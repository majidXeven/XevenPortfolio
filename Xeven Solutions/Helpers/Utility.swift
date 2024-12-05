//
//  Utility.swift
//  Xeven Solutions
//
//  Created by Muhammad Asar on 07/01/2020.
//  Copyright © 2020 IMedHealth. All rights reserved.
//

import UIKit

class Utility {
    
    static func isValidEmail(_ email:String)-> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
}
