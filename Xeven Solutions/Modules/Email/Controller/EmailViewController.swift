//
//  EmailViewController.swift
//  Xeven Solutions
//
//  Created by Muhammad Asar on 02/01/2020.
//  Copyright © 2020 IMedHealth. All rights reserved.
//

import UIKit
import KRProgressHUD

class EmailViewController: BaseViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    
    var isKeyboardAppear = false
    var viewModel: EmailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Email".uppercased()
        messageTextView.text = "Message"
        messageTextView.textColor = UIColor.lightGray
        viewModel = EmailViewModel(delegate: self)
        setLargeTitle()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func onPressSubmit(_ sender: UIButton) {
        if isValidInput(){
            KRProgressHUD.show()
            let param: [String: Any] = [
              "name": self.nameTextField.text ?? "",
              "email": self.emailTextField.text ?? "",
              "subject": self.subjectTextField.text ?? "",
              "body": self.messageTextView.text ?? ""
            ]
            viewModel.sendMail(with: param)
        }
    }
}

extension EmailViewController {
    func isValidInput() -> Bool {
        if !nameTextField.isValidInput() {
            showAlertView(title: "Error", message: "Name field is required.")
            return false
        }
        if !emailTextField.isValidInput() {
            showAlertView(title: "Error", message: "Email field is required.")
            return false
        }
        if !Utility.isValidEmail(emailTextField.text!) {
            showAlertView(title: "Error", message: "Please enter valid Email address")
            return false
        }
        if !subjectTextField.isValidInput() {
            showAlertView(title: "Error", message: "Subject field is required.")
            return false
        }
        if self.messageTextView.text == "Message" {
            showAlertView(title: "Error", message: "Message field is required.")
            return false
        }
        return true
    }
}

extension EmailViewController: EmailViewModelDelegate {
    func onCompleted() {
        KRProgressHUD.dismiss()
        showAlertView(title: "Success", message: "Email Send Successfully")
    }
    
    func onFailed(with reason: String) {
        KRProgressHUD.dismiss()
        showErrorAlert(with: reason)
    }
}


extension EmailViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if messageTextView.textColor == UIColor.lightGray {
            messageTextView.text = nil
            messageTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if messageTextView.text.isEmpty {
            messageTextView.text = "Message"
            messageTextView.textColor = UIColor.lightGray
        }
    }
}
