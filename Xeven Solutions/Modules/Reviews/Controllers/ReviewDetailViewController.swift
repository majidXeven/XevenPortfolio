//
//  ReviewDetailViewController.swift
//  Xeven Solutions
//
//  Created by Muhammad Asar on 06/01/2020.
//  Copyright © 2020 IMedHealth. All rights reserved.
//

import UIKit

class ReviewDetailViewController: BaseViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var titleString = ""
    var descriptionString = ""
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleString.uppercased()
        titleLabel.text = name
        descriptionTextView.text = descriptionString
        descriptionTextView.isEditable = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
}
