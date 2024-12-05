//
//  UIViewController+Alert.swift
//  Xeven Solutions
//
//  Created by Muhammad Asar on 03/01/2020.
//  Copyright © 2020 IMedHealth. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlertView(title: String, message: String,
                       successTitle: String = "OK",
                       cancelTitle: String = "",
                       successCallback : (()->())! = nil,
                       cancelCallback : (()->())! = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        if successTitle.count > 0 {
            alert.addAction(UIAlertAction(title: successTitle, style: UIAlertAction.Style.default, handler: {
                action in
                
                if successCallback != nil {
                    successCallback()
                }
            }))
        }
        
        if cancelTitle.count > 0 {
            alert.addAction(UIAlertAction(title: cancelTitle, style: UIAlertAction.Style.default, handler: {
                action in
                if cancelCallback != nil {
                    cancelCallback()
                }
            }))
        }
        present(alert, animated: true, completion: nil)
    }
    
    func showAlertView(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func showErrorAlert(with message: String) {
        showAlertView(title: "Error", message: message)
    }
}

