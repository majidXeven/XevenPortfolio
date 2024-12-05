//
//  EmailViewModel.swift
//  Xeven Solutions
//
//  Created by Muhammad Asar on 06/01/2020.
//  Copyright © 2020 IMedHealth. All rights reserved.
//

import UIKit

protocol EmailViewModelDelegate {
    func onCompleted()
    func onFailed(with reason: String)
}

class EmailViewModel: NSObject {
    
    var delegate: EmailViewModelDelegate?
    
    init(delegate: EmailViewModelDelegate) {
        self.delegate = delegate
    }
    
    func sendMail(with param: [String: Any]) {
        ApiManager.shared.sendMail(param: param) { (response, error) in
            if error == "" {
                self.delegate?.onCompleted()
            }else {
                self.delegate?.onFailed(with: error)
            }
        }
    }
}
