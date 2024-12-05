//
//  PortfolioViewController.swift
//  Xeven Solutions
//
//  Created by Muhammad Asar on 30/12/2019.
//  Copyright © 2019 IMedHealth. All rights reserved.
//

import Foundation
import UIKit
import KRProgressHUD

class PortfolioViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: PortfolioViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Portfolio".uppercased()
        viewModel = PortfolioViewModel(delegate: self)
        setLargeTitle()
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if viewModel.totalCount == 0 {
            KRProgressHUD.show()
            viewModel.fetchPortfoilo()
        }
    }
    
}

extension PortfolioViewController: PortfolioViewModelModelDelegate {
    func onFetchCompleted() {
        KRProgressHUD.dismiss()
        collectionView.reloadData()
    }
    
    func onFetchFailed(with reason: String) {
        KRProgressHUD.dismiss()
        showErrorAlert(with: reason)
    }
}

extension PortfolioViewController {
    func registerCell() {
        collectionView.register(UINib(nibName: "PortfolioCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PortfolioCollectionViewCell")
        collectionView.contentInset = UIEdgeInsets.init(top: 0, left: 70, bottom: 0, right: 70)
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
    }
}

extension PortfolioViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.totalCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PortfolioCollectionViewCell", for: indexPath) as! PortfolioCollectionViewCell
        let item = viewModel.portfolio(at: indexPath.row)
        cell.imageView.set(urlString: ApiManager.shared.imagesBaseURL + item.images.replacingOccurrences(of: " ", with: "%20"), placeholder: "22")
        cell.titleLabel.text = item.title
        cell.detailLabel.text = item.descriptions.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.portfolio(at: indexPath.row)
        guard let url = URL(string: item.url) else { return }
        UIApplication.shared.open(url)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellSize: CGSize = collectionView.bounds.size
        cellSize.width -= collectionView.contentInset.left
        cellSize.width -= collectionView.contentInset.right
        cellSize.height = cellSize.height - 80
        return cellSize
    }
    
}
