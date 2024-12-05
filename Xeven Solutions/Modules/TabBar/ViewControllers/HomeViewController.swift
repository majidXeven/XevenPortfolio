//
//  HomeViewController.swift
//  Xeven Solutions
//
//  Created by Muhammad Asar on 30/12/2019.
//  Copyright © 2019 IMedHealth. All rights reserved.
//

import Foundation
import UIKit
import FSPagerView

class HomeViewController: BaseViewController, FSPagerViewDataSource,FSPagerViewDelegate {
    
    @IBOutlet weak var pageControl: FSPageControl!{
        didSet {
            self.pageControl.numberOfPages = self.imageNames.count
            self.pageControl.contentHorizontalAlignment = .right
            self.pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
    }
    
    @IBOutlet weak var pagerView: FSPagerView!{
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.pagerView.itemSize = FSPagerView.automaticSize
        }
    }
    @IBOutlet weak var topContainerView: UIView!
    
    fileprivate let imageNames = ["11.jpg","22.jpg","33.jpg","44.jpg"]
    fileprivate let name = ["My live doctors", "The Doc app", "Intelligent Clinic Management Suite", "iMedTracker"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        self.pagerView.automaticSlidingInterval = 3.0 - self.pagerView.automaticSlidingInterval
//        applyCurvedPath(givenView: self.topContainerView, curvedPercent: 0.2)

    }
    
    @IBAction func onPressServices(_ sender: UIButton) {
        self.tabBarController?.selectedIndex = 1
    }
    
    @IBAction func onPressPortfolio(_ sender: UIButton) {
        self.tabBarController?.selectedIndex = 2
    }
    
    @IBAction func onPressVideos(_ sender: UIButton) {
        self.tabBarController?.selectedIndex = 3
    }
    
    @IBAction func onPressReviews(_ sender: UIButton) {
        let vc = ReviewViewController.instantiate(fromAppStoryboard: .Reviews)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension HomeViewController {
    
    // MARK:- FSPagerView DataSource
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return imageNames.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: self.imageNames[index])
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        cell.textLabel?.text = name[index].uppercased()
        return cell
    }
    
    // MARK:- FSPagerView Delegate
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControl.currentPage = targetIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.pageControl.currentPage = pagerView.currentIndex
    }
}

extension HomeViewController {
    
    func setupViews() {
        title = "Home".uppercased()
    }
    
    func applyCurvedPath(givenView: UIView,curvedPercent:CGFloat) {
        guard curvedPercent <= 1 && curvedPercent >= 0 else{
            return
        }

        let shapeLayer = CAShapeLayer(layer: givenView.layer)
        shapeLayer.path = self.pathCurvedForView(givenView: givenView,curvedPercent: curvedPercent).cgPath
        shapeLayer.frame = givenView.bounds
        shapeLayer.masksToBounds = true
        givenView.layer.mask = shapeLayer
    }
    
    func pathCurvedForView(givenView: UIView, curvedPercent:CGFloat) ->UIBezierPath
    {
        let arrowPath = UIBezierPath()
        arrowPath.move(to: CGPoint(x:0, y:0))
        arrowPath.addLine(to: CGPoint(x:givenView.bounds.size.width, y:0))
        arrowPath.addLine(to: CGPoint(x:givenView.bounds.size.width, y:givenView.bounds.size.height - (givenView.bounds.size.height*curvedPercent)))
        arrowPath.addQuadCurve(to: CGPoint(x:0, y:givenView.bounds.size.height - (givenView.bounds.size.height*curvedPercent)), controlPoint: CGPoint(x:givenView.bounds.size.width/2, y:givenView.bounds.size.height))
        arrowPath.addLine(to: CGPoint(x:0, y:0))
        arrowPath.close()
        
        return arrowPath
    }
    
}
