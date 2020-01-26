//
//  DataLoadOperation.swift
//  Asynchronous Data Provider
//
//  Created by Rokon Uddin on 1/26/20.
//  Copyright © 2020 Rokon Uddin. All rights reserved.
//

import Foundation

class DataLoadOperation: AsyncOperation {
    
    fileprivate let url: URL
    fileprivate let completion: ((Data?) -> ())?
    fileprivate var loadedData: Data?
    
    init(url: URL, completion: ((Data?) -> ())? = nil) {
        self.url = url
        self.completion = completion
        super.init()
    }
    
    override func main() {
        if self.isCancelled { return }
        NetworkSimulator.asyncLoadDataAtURL(url) {
            data in
            if self.isCancelled { return }
            self.loadedData = data
            self.completion?(data)
            self.state = .Finished
        }
    }
}

extension DataLoadOperation: ImageDecompressionOperationDataProvider {
    var compressedData: Data? { return loadedData }
}

