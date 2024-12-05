//
//  WebViewContoller.swift
//  Xeven Solutions
//
//  Created by Muhammad Asar on 07/01/2020.
//  Copyright © 2020 IMedHealth. All rights reserved.
//

import UIKit
import WebKit
import KRProgressHUD

class WebViewContoller: BaseViewController, WKNavigationDelegate {
    
    fileprivate var webView: WKWebView!
    var videoURL = ""
    var timeOut: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUrl()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        webView.load(URLRequest.init(url: URL.init(string: "about:blank")!))
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationItem.largeTitleDisplayMode = .never
    }
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
}

extension WebViewContoller {
    
    func loadUrl() {
        let url = URL(string: videoURL)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        KRProgressHUD.show(withMessage: "Loading.....", completion: nil)
        self.timeOut = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(cancelWeb), userInfo: nil, repeats: false)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        KRProgressHUD.dismiss()
        self.timeOut.invalidate()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        KRProgressHUD.dismiss()
        self.timeOut.invalidate()
    }
    
    @objc func cancelWeb() {
        KRProgressHUD.dismiss()
        showAlertView(title: "Error", message: "Something went wrong!", cancelTitle: "Retry", successCallback: {
            self.navigationController?.popViewController(animated: true)
        }, cancelCallback: {
            self.loadUrl()
        })
    }
}
