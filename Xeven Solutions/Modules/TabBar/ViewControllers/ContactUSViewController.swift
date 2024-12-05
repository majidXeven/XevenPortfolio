//
//  ContactUSViewController.swift
//  Xeven Solutions
//
//  Created by Muhammad Asar on 30/12/2019.
//  Copyright © 2019 IMedHealth. All rights reserved.
//

import Foundation
import UIKit

class ContactUSViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var data: [[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Contact Us".uppercased()
        addRightBarButton()
        setLargeTitle()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
}

extension ContactUSViewController {
    func addRightBarButton() {
        let button = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(sendMail))
        self.navigationItem.rightBarButtonItem = button
    }
    
    @objc func sendMail() {
        let vc = EmailViewController.instantiate(fromAppStoryboard: .Email)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ContactUSViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactUsTableViewCell", for: indexPath) as! ContactUsTableViewCell
        let item = data[indexPath.row]
        cell.titleLabel.text = item["text"] as? String
        cell.iconImageView.image = UIImage(named: item["image"] as! String)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = data[indexPath.row]
        if indexPath.row == 0 {
            let vc = EmailViewController.instantiate(fromAppStoryboard: .Email)
            self.tabBarController?.tabBar.isHidden = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 1 {
            let number = item["text"] as? String
            number?.makeACall()
        }else if indexPath.row == 2 {
            let vc = MapViewController.instantiate(fromAppStoryboard: .Map)
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }else if indexPath.row == 3 {
            socialMedia(appUrl: "facebook://user?username=xevensolutions", webUrl: "https://facebook.com/xevensolutions")
        }else if indexPath.row == 4 {
            socialMedia(appUrl: "twitter://user?username=SolutionsXeven", webUrl: "https://twitter.com/SolutionsXeven")
        }else if indexPath.row == 5 {
            socialMedia(appUrl: "linkedin://profile/muhammad-irfan-a062aa78", webUrl: "https://www.linkedin.com/in/muhammad-irfan-a062aa78")
        }
    }
}

extension ContactUSViewController {
    func socialMedia(appUrl: String, webUrl: String) {
        let appURL = URL(string: appUrl)!
        let application = UIApplication.shared

        if application.canOpenURL(appURL) {
            application.open(appURL)
        } else {
            let webURL = URL(string: webUrl)!
            application.open(webURL)
        }
    }
}

extension ContactUSViewController {
    func loadData() {
        data.append(["image": "email", "text": "irfan@xevensolutions.com"])
        data.append(["image": "cell-phone", "text": "+923453177413"])
        data.append(["image": "pin", "text": "15 Civic Center (Basement), D2 Block, Johar Town - Lahore"])
        data.append(["image": "facebook", "text": "Facebook"])
        data.append(["image": "twitter", "text": "Twitter"])
        data.append(["image": "linkedin", "text": "Linkedin"])
    }
}
