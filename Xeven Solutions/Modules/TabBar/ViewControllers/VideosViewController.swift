//
//  VideosViewController.swift
//  Xeven Solutions
//
//  Created by Muhammad Asar on 31/12/2019.
//  Copyright © 2019 IMedHealth. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import KRProgressHUD

class VideosViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: VideosViewModel!
    private var isFirstAppearance = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Video".uppercased()
        viewModel = VideosViewModel(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setLargeTitle()
        updateCollectionViewLayout(with: UIScreen.main.bounds.size)
        if viewModel.totalCount == 0 {
            KRProgressHUD.show()
            viewModel.fetchAllVideos()
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateCollectionViewLayout(with: size)
    }
}

extension VideosViewController: VideosViewModelDelegate {
    func onFetchCompleted() {
        KRProgressHUD.dismiss()
        collectionView.reloadData()
    }
    
    func onFetchFailed(with reason: String) {
        KRProgressHUD.dismiss()
        showErrorAlert(with: reason)
    }
}

extension VideosViewController {
    
//    private func applyLargeTitlesFix() {
//        collectionView.contentInset = UIEdgeInsets.init(top: 40, left: 0, bottom: 40, right: 0)
//        isFirstAppearance = false
//    }
    
    func updateCollectionViewLayout(with size: CGSize) {
        guard let flowLayout = collectionView.collectionViewLayout as? DSSCollectionViewFlowLayout else {
            return
        }
        let width = size.width
        let cellWidth = (width / 2) - 16
        flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        flowLayout.invalidateLayout()
    }
}

extension VideosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.totalCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCollectionViewCell", for: indexPath) as! VideoCollectionViewCell
        let obj = viewModel.video(at: indexPath.row)
//        cell.imageView.image =
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let obj = viewModel.video(at: indexPath.row)
        let vc = WebViewContoller.instantiate(fromAppStoryboard: .WebView)
        self.tabBarController?.tabBar.isHidden = true
        vc.videoURL = obj.videoUrl
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension VideosViewController {
    func generateThumbnail(path: URL) -> UIImage? {
        do {
            let asset = AVURLAsset(url: path, options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
            let thumbnail = UIImage(cgImage: cgImage)
            return thumbnail
        } catch let error {
            print("*** Error generating thumbnail: \(error.localizedDescription)")
            return nil
        }
    }
}
