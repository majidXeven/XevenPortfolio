//
//  ServicesViewModel.swift
//  Xeven Solutions
//
//  Created by Muhammad Asar on 06/01/2020.
//  Copyright © 2020 IMedHealth. All rights reserved.
//

import UIKit

protocol ServicesViewModelDelegate {
    func onFetchCompleted()
    func onFetchFailed(with reason: String)
}

class ServicesViewModel: NSObject {
    
    var delegate: ServicesViewModelDelegate?
    
    private var servicesList: [Services] = []
    
    init(delegate: ServicesViewModelDelegate) {
        self.delegate = delegate
    }
    
    var totalCount: Int {
        return self.servicesList.count
    }
    
    func service(at index: Int) -> Services {
        return servicesList[index]
    }
    
    func fetchAllServices() {
        ApiManager.shared.getAllServices(param: [:]) { (response, error) in
            if error == "" {
                let responseDict = response as! [String: Any]
                if let responseData = responseDict["data"] as? [[String: Any]] {
                    self.servicesList = responseData.map({
                        Services(dict: $0)
                    })
                    self.delegate?.onFetchCompleted()
                }
            }else {
                self.delegate?.onFetchFailed(with: error)
            }
        }
    }
}


