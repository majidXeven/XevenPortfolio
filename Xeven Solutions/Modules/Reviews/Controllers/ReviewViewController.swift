//
//  ReviewViewController.swift
//  Xeven Solutions
//
//  Created by Muhammad Asar on 31/12/2019.
//  Copyright © 2019 IMedHealth. All rights reserved.
//

import UIKit
import KRProgressHUD

class ReviewViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: ReviewViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Reviews".uppercased()
        viewModel = ReviewViewModel(delegate: self)
        setLargeTitle()
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if viewModel.totalCount == 0 {
            KRProgressHUD.show()
            viewModel.fetchAllTestmonials()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
}

extension ReviewViewController: ReviewViewModelDelegate {
    func onFetchCompleted() {
        KRProgressHUD.dismiss()
        collectionView.reloadData()
    }
    
    func onFetchFailed(with reason: String) {
        KRProgressHUD.dismiss()
        showErrorAlert(with: reason)
    }
}

extension ReviewViewController {
    func registerCell() {
        collectionView.register(UINib(nibName: "ReviewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ReviewCollectionViewCell")
        collectionView.contentInset = UIEdgeInsets.init(top: 0, left: 60, bottom: 0, right: 60)
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
    }
}

extension ReviewViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.totalCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewCollectionViewCell", for: indexPath) as! ReviewCollectionViewCell
        let obj = viewModel.review(at: indexPath.row)
        cell.ratingView.editable = false
        cell.ratingView.rating = Double(obj.stars)
        cell.nameLabel.text = obj.clientName
        cell.titleLabel.text = "Quality Support"
        cell.detailLabel.text = obj.clientReview
        cell.imageView.set(urlString: ApiManager.shared.imagesBaseURL + obj.featureImage.replacingOccurrences(of: " ", with: "%20"), placeholder: "dummyUser")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var cellSize: CGSize = collectionView.bounds.size
        
        cellSize.width -= collectionView.contentInset.left
        cellSize.width -= collectionView.contentInset.right
        cellSize.height = cellSize.height - 80
        
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let obj = viewModel.review(at: indexPath.row)
        let vc = ReviewDetailViewController.instantiate(fromAppStoryboard: .Reviews)
        vc.name = obj.clientName
        vc.titleString = "Quality Support"
        vc.descriptionString = obj.clientReview
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

