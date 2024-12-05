//
//  VideosViewModel.swift
//  Xeven Solutions
//
//  Created by Muhammad Asar on 06/01/2020.
//  Copyright © 2020 IMedHealth. All rights reserved.
//

import UIKit

protocol VideosViewModelDelegate {
    func onFetchCompleted()
    func onFetchFailed(with reason: String)
}

class VideosViewModel: NSObject {
    
    var delegate: VideosViewModelDelegate?
    
    private var videoList: [Video] = []
    
    init(delegate: VideosViewModelDelegate) {
        self.delegate = delegate
    }
    
    var totalCount: Int {
        return self.videoList.count
    }
    
    func video(at index: Int) -> Video {
        return videoList[index]
    }
    
    func fetchAllVideos() {
        ApiManager.shared.getAllVideos(param: [:]) { (response, error) in
            if error == "" {
                let responseDict = response as! [String: Any]
                if let responseData = responseDict["data"] as? [[String: Any]] {
                    self.videoList = responseData.map({
                        Video(dict: $0)
                    })
                    self.delegate?.onFetchCompleted()
                }
            }else {
                self.delegate?.onFetchFailed(with: error)
            }
        }
    }
}

