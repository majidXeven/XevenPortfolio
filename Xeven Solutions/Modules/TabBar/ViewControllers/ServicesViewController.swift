//
//  ServicesViewController.swift
//  Xeven Solutions
//
//  Created by Muhammad Asar on 30/12/2019.
//  Copyright © 2019 IMedHealth. All rights reserved.
//

import Foundation
import UIKit

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

class ServicesViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var servicesList: [[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Our Services".uppercased()
        collectionView.contentInset = UIEdgeInsets.init(top: 30, left: 0, bottom: 40, right: 0)
        loadData()
        setLargeTitle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateCollectionViewLayout(with: UIScreen.main.bounds.size)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateCollectionViewLayout(with: size)
    }
    
}


extension ServicesViewController {
    func updateCollectionViewLayout(with size: CGSize) {
        guard let flowLayout = collectionView.collectionViewLayout as? DSSCollectionViewFlowLayout else {
            return
        }
        let width = size.width
        let cellWidth = width - 10
        flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth * 0.2)
        flowLayout.invalidateLayout()
    }
}

extension ServicesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return servicesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServicesCollectionViewCell", for: indexPath) as! ServicesCollectionViewCell
        let service = servicesList[indexPath.row]
        cell.titleLabel.text = service["title"] as? String ?? ""
        cell.iconImageView.image = UIImage(named: service["photo"] as! String)
        return cell
    }
}

extension ServicesViewController {
    func loadData() {
        servicesList.append(["photo": "apple.png", "title": "IOS Development"])
        servicesList.append(["photo": "facebook.png", "title": "Facebook Games"])
        servicesList.append(["photo": "wordpress.png", "title": "Wordpress Press"])
        servicesList.append(["photo": "android.png", "title": "Android Development"])
        servicesList.append(["photo": "ecommerce.png", "title": "Ecommerce Solutions"])
        servicesList.append(["photo": "gamepad.png", "title": "Games"])
        servicesList.append(["photo": "html5.png", "title": "HTML5 Development"])
        servicesList.append(["photo": "paint.png", "title": "Design"])
    }
}
