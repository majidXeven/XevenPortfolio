//
//  ApiManager.swift
//  Xeven Solutions
//
//  Created by Muhammad Asar on 30/12/2019.
//  Copyright © 2019 IMedHealth. All rights reserved.
//

import Foundation
import Alamofire

class ApiManager: NSObject {
    
    static let shared = ApiManager()
    
    private let API_BASE_URL = "https://api.xevensolutions.com"
    private let IMAGES_BASE_URL = "http://staging.xevensolutions.com"
    let ftpBaseUrl = ""
    let ftpUsername = ""
    let ftpPassword = ""
    let ftpDirectoryPath = ""
    
    private override init() {
        super.init()
    }
    
    var imagesBaseURL: String {
        return IMAGES_BASE_URL
    }
}

//MARK: - Portfolio
extension ApiManager {
    func getAllProjects(param: [String: Any], completionHandler: @escaping (_ response: Any?, _ error: String) -> Void) {
        performGetRequest(method: "/projects/getAll", parameters: param) { (response, error) in
            self.validateResponse(response: response, error: error, completionHandler: completionHandler)
        }
    }
}

//MARK: - Video
extension ApiManager {
    func getAllVideos(param: [String: Any], completionHandler: @escaping (_ response: Any?, _ error: String) -> Void) {
        performGetRequest(method: "/videos/getAll", parameters: param) { (response, error) in
            self.validateResponse(response: response, error: error, completionHandler: completionHandler)
        }
    }
}

//MARK: - Testmonials
extension ApiManager {
    func getAllTestmonials(param: [String: Any], completionHandler: @escaping (_ response: Any?, _ error: String) -> Void) {
        performGetRequest(method: "/testmonials/getAll", parameters: param) { (response, error) in
            self.validateResponse(response: response, error: error, completionHandler: completionHandler)
        }
    }
}

//MARK: - Services
extension ApiManager {
    func getAllServices(param: [String: Any], completionHandler: @escaping (_ response: Any?, _ error: String) -> Void) {
        performGetRequest(method: "/services/getAll", parameters: param) { (response, error) in
            self.validateResponse(response: response, error: error, completionHandler: completionHandler)
        }
    }
}

//MARK: - EMail
extension ApiManager {
    func sendMail(param: [String: Any], completionHandler: @escaping (_ response: Any?, _ error: String) -> Void) {
        performPostRequest(method: "/sendMail", parameters: param) { (response, error) in
            self.validateResponse(response: response, error: error, completionHandler: completionHandler)
        }
    }
}

extension ApiManager {
    func validateResponse(response: Any?, error: Error?, completionHandler: @escaping (_ response: Any?, _ error: String ) -> Void) {
        guard let response = response else {
            completionHandler(nil, error?.localizedDescription ?? "Failed to perform action.")
            return
        }
        var isSuccess = false
        if let responseDict = response as? [String: Any] {
            if let status = responseDict["status"] as? Int {
                if status == 0 {
                    if let message = responseDict["message"] as? String {
                        if message.lowercased() == "success" {
                            isSuccess = true
                        }else {
                            completionHandler(nil, message)
                            return
                        }
                    }else {
                        completionHandler(nil, "Failed to perform action.")
                        return
                    }
                }else {
                    isSuccess = true
                }
            }
        }
        if isSuccess {
            completionHandler(response, "")
        }else {
            completionHandler(nil, "Failed to perform action.")
        }
    }
}

extension ApiManager {
    private func performGetRequest(method: String, parameters: [String: Any], completionHandler: @escaping (_ response: Any?, _ error: Error?) -> Void) {
        let methodURl = URL(string: API_BASE_URL + method)!
        
        AF.request(methodURl, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.result.isSuccess {
                completionHandler(response.result.value, nil)
            }else {
                completionHandler(nil,response.error)
            }
        }
    }
    
    private func performPostRequest(method: String, parameters: [String: Any], completionHandler: @escaping (_ response: Any?, _ error: Error?) -> Void) {
        
        let methodURl = URL(string: API_BASE_URL + method)!
        
        AF.request(methodURl, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            if response.result.isSuccess {
                completionHandler(response.result.value, nil)
            }else {
                completionHandler(nil,response.error)
            }
        }
    }
}

