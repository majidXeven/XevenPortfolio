//
//  PortfolioViewModel.swift
//  Xeven Solutions
//
//  Created by Muhammad Asar on 03/01/2020.
//  Copyright © 2020 IMedHealth. All rights reserved.
//

import UIKit

protocol PortfolioViewModelModelDelegate {
    func onFetchCompleted()
    func onFetchFailed(with reason: String)
}

class PortfolioViewModel: NSObject {
    
    var delegate: PortfolioViewModelModelDelegate?
    
    private var portfolioList: [Portfolio] = []
    private var total: Int = 0
    
    init(delegate: PortfolioViewModelModelDelegate) {
        self.delegate = delegate
    }
    
    var totalCount: Int {
        return self.portfolioList.count
    }
    
    func portfolio(at index: Int) -> Portfolio {
        return portfolioList[index]
    }
    
    func fetchPortfoilo() {
        ApiManager.shared.getAllProjects(param: [:]) { (response, error) in
            if error == "" {
                let responseDict = response as! [String: Any]
                if let responseData = responseDict["data"] as? [[String: Any]] {
                    self.portfolioList = responseData.map({
                        Portfolio(dict: $0)
                    })
                    self.delegate?.onFetchCompleted()
                }
            }else {
                self.delegate?.onFetchFailed(with: error)
            }
        }
    }
}
