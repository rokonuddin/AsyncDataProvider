//
//  ImageDecompressionOperation.swift
//  Asynchronous Data Provider
//
//  Created by Rokon Uddin on 1/26/20.
//  Copyright © 2020 Rokon Uddin. All rights reserved.
//

import UIKit

protocol ImageDecompressionOperationDataProvider {
    var compressedData: Data? { get }
}

class ImageDecompressionOperation: Operation {
    
    fileprivate let inputData: Data?
    fileprivate let completion: ((UIImage?) -> ())?
    fileprivate var outputImage: UIImage?
    
    init(data: Data?, completion: ((UIImage?) -> ())? = nil) {
        inputData = data
        self.completion = completion
        super.init()
    }
    
    override func main() {
        let compressedData: Data?
        if self.isCancelled { return }
        if let inputData = inputData {
            compressedData = inputData
        } else {
            let dataProvider = dependencies
                .filter { $0 is ImageDecompressionOperationDataProvider }
                .first as? ImageDecompressionOperationDataProvider
            compressedData = dataProvider?.compressedData
        }
        
        guard let data = compressedData else { return }
        
        if self.isCancelled { return }
        if let decompressedData = Compressor.decompressData(data) {
            outputImage = UIImage(data: decompressedData)
        }
        
        if self.isCancelled { return }
        completion?(outputImage)
    }
}

extension ImageDecompressionOperation: ImageFilterDataProvider {
    var image: UIImage? { return outputImage }
}
