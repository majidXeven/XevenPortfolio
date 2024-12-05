//
//  ReviewViewModel.swift
//  Xeven Solutions
//
//  Created by Muhammad Asar on 06/01/2020.
//  Copyright © 2020 IMedHealth. All rights reserved.
//

import UIKit

protocol ReviewViewModelDelegate {
    func onFetchCompleted()
    func onFetchFailed(with reason: String)
}

class ReviewViewModel: NSObject {
    
    var delegate: ReviewViewModelDelegate?
    
    private var reviewsList: [Testmonials] = []
    
    init(delegate: ReviewViewModelDelegate) {
        self.delegate = delegate
    }
    
    var totalCount: Int {
        return self.reviewsList.count
    }
    
    func review(at index: Int) -> Testmonials {
        return reviewsList[index]
    }
    
    func fetchAllTestmonials() {
        ApiManager.shared.getAllTestmonials(param: [:]) { (response, error) in
            if error == "" {
                let responseDict = response as! [String: Any]
                if let responseData = responseDict["data"] as? [[String: Any]] {
                    self.reviewsList = responseData.map({
                        Testmonials(dict: $0)
                    })
                    self.delegate?.onFetchCompleted()
                }
            }else {
                self.delegate?.onFetchFailed(with: error)
            }
        }
    }
}

