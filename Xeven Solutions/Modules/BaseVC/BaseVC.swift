//
//  BaseVC.swift
//  Xeven Solutions
//
//  Created by Muhammad Asar on 30/12/2019.
//  Copyright © 2019 IMedHealth. All rights reserved.
//

import Foundation
import UIKit
//import SVProgressHUD

enum NavigatioBarType: Int {
    case withLeftCloseBtnAndTitle
    case withLeftBackAndRightOptionBtn
    case withTitleInCentre
}

typealias BaseControllerClickAction = (()->Void)

@objc protocol MTNavigationHandlerProtocol {
    @objc optional func didSelectLeftNavigationBtn(sender: UIBarButtonItem)
    @objc optional func didSelectRightNaviationBtn(sender: UIBarButtonItem)
}

class BaseViewController: UIViewController, UIGestureRecognizerDelegate{
    
    var delegate:MTNavigationHandlerProtocol?
    var leftActionHandler: BaseControllerClickAction?
    var rightActionHandler: BaseControllerClickAction?
    
    var isModal: Bool {
        if self.presentingViewController != nil {
            return true
        } else if self.navigationController?.presentingViewController?.presentedViewController == self.navigationController  {
            return true
        } else if self.tabBarController?.presentingViewController is UITabBarController {
            return true
        }
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.navigationBar.isTranslucent = false
        basicNavigationSetting()
//        if(self.navigationController?.viewControllers.count == 1)
//        {
//            self.addLeftBarButtonWithImage(UIImage(named: "")!)
//        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setNavigationBar(with title:String, ofType:NavigatioBarType, delegate: MTNavigationHandlerProtocol?){
        self.delegate = delegate
        switch ofType {
        case .withLeftCloseBtnAndTitle:
            navigationWithLeftColseBtne(title: title)
        case .withLeftBackAndRightOptionBtn:
            self.setNavigationWithLeftBakAndRighOptionBtn(title: title)
            
        case .withTitleInCentre:
            self.setNavigationWithTitleOnly(title: title)
        }
    }
    
    func setLargeTitle() {
        if #available(iOS 11.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = UIColor(named: "appColor")
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
    }
    
    func setLargeTitleDisplayMode(_ largeTitleDisplayMode: UINavigationItem.LargeTitleDisplayMode) {
        switch largeTitleDisplayMode {
        case .automatic:
              guard let navigationController = navigationController else { break }
            if let index = navigationController.children.firstIndex(of: self) {
                setLargeTitleDisplayMode(index == 0 ? .always : .never)
            } else {
                setLargeTitleDisplayMode(.always)
            }
        case .always, .never:
            navigationItem.largeTitleDisplayMode = largeTitleDisplayMode
            // Even when .never, needs to be true otherwise animation will be broken on iOS11, 12, 13
            navigationController?.navigationBar.prefersLargeTitles = true
        @unknown default:
            assertionFailure("\(#function): Missing handler for \(largeTitleDisplayMode)")
        }
    }
    
    private func setNavigationWithLeftBakAndRighOptionBtn(title: String) {
        setTitle(title: title)
        basicNavigationSetting()
        if (self.navigationController?.navigationBar) != nil {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "BackImage"), style: .plain, target: self, action: #selector(didTapLeftButton(sender:)))
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "OptionImage"), style: .plain, target: self, action: #selector(didTapRightButton(sender:)) )
        }else {
            print("not a navigation stage")
        }
    }
    private func setNavigationWithTitleOnly(title: String){
        setTitle(title: title)
        basicNavigationSetting()
    }
    
    private func navigationWithLeftColseBtne(title: String){
        setNavigationBarWithLeftCloseButton(title: title)
        
    }
    
    private func setNavigationWithLeftCloseAndRightCheckBtn(title: String){
        
        setTitle(title: title)
        basicNavigationSetting()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "user"), style: .plain, target: self, action: #selector(didTapLeftButton(sender:)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "user"), style: .plain, target: self, action: #selector(didTapRightButton(sender:)) )
    }
    
    private func setTitle(title: String){
        self.navigationItem.title = title
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.white]
    }
    
    private func setNavigationBarWithLeftCloseButton(title: String){
        setTitle(title: title)
        basicNavigationSetting()
        if (self.navigationController?.navigationBar) != nil {
            
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "BackImage"), style: .plain, target: self, action: #selector(didTapLeftButton(sender:)))
            
        }
    }
    
    private func basicNavigationSetting(){
        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "appColor")
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "appColor")
        self.navigationController?.navigationBar.tintColor = UIColor.white
        let font = UIFont.systemFont(ofSize: 20.0, weight: .semibold)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: font]
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationItem.rightBarButtonItem?.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 18.0, weight: .bold)], for: .normal)
    }
    
    func popViewController(animated: Bool) {
        if isModal {
            self.dismiss(animated: animated, completion: nil)
        }else {
            self.navigationController?.popViewController(animated: animated)
        }
    }
    
    func leftBarClicked(completion: @escaping BaseControllerClickAction) {
        self.leftActionHandler = completion
    }
    
    @objc func didTapLeftButton(sender: UIBarButtonItem){
        if let completion = self.leftActionHandler {
            completion()
        }else{
            self.popViewController(animated: true)
        }
    }
    
    @objc func didTapRightButton(sender: UIBarButtonItem){
        //        let viewController = LoginViewController()
        //        self.pushViewController(viewController: viewController)
        guard let dell = self.delegate else {return}
        dell.didSelectRightNaviationBtn!(sender: sender)
        
    }
    
    
    
    //    func setUpNavigationBar(height: CGFloat, animated: Bool) {
    //        (self.navigationController as? KMNavigationController)?.setNavBar(height: height, animated: animated)
    //    }

    
//
//    @objc  override func hideKeyboardWhenTappedAround() {
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//        tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
//    }
//
//    @objc override func dismissKeyboard() {
//        view.endEditing(true)
//    }
}

extension UINavigationBar
{
    /// Applies a background gradient with the given colors
    func applyNavigationGradient( colors : [UIColor]) {
        var frameAndStatusBar: CGRect = self.bounds
//        frameAndStatusBar.size.height += 20 // add 20 to account for the status bar
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5 or 5S or 5C")
                frameAndStatusBar.size.height += 20
            case 1334:
                print("iPhone 6/6S/7/8")
                frameAndStatusBar.size.height += 20
            case 1920, 2208:
                print("iPhone 6+/6S+/7+/8+")
                frameAndStatusBar.size.height += 20
            case 2436:
                print("iPhone X, XS")
                frameAndStatusBar.size.height += 44
            case 2688:
                print("iPhone XS Max")
                frameAndStatusBar.size.height += 44
            case 1792:
                print("iPhone XR")
                frameAndStatusBar.size.height += 44
            default:
                print("Unknown")
            }
        }
        
        setBackgroundImage(UINavigationBar.gradient(size: frameAndStatusBar.size, colors: colors), for: .default)
    }
    
    /// Creates a gradient image with the given settings
    static func gradient(size : CGSize, colors : [UIColor]) -> UIImage?
    {
        // Turn the colors into CGColors
        let cgcolors = colors.map { $0.cgColor }
        
        // Begin the graphics context
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        
        // If no context was retrieved, then it failed
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        // From now on, the context gets ended if any return happens
        defer { UIGraphicsEndImageContext() }
        
        // Create the Coregraphics gradient
        var locations : [CGFloat] = [0.0, 1.0]
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: cgcolors as NSArray as CFArray, locations: &locations) else { return nil }
        
        // Draw the gradient
        context.drawLinearGradient(gradient, start: CGPoint(x: 0.0, y: 0.0), end: CGPoint(x: 0.0, y: size.height), options: [])
        
        // Generate the image (the defer takes care of closing the context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}


