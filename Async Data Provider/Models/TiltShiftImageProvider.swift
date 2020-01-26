//
//  TiltShiftImageProvider.swift
//  Asynchronous Data Provider
//
//  Created by Rokon Uddin on 1/26/20.
//  Copyright © 2020 Rokon Uddin. All rights reserved.
//

import UIKit

class TiltShiftImageProvider {
    
    fileprivate let operationQueue = OperationQueue()
    let tiltShiftImage: TiltShiftImage
    var image: UIImage?
    
    init(tiltShiftImage: TiltShiftImage, completion: @escaping (UIImage?) -> ()) {
        self.tiltShiftImage = tiltShiftImage
        let url = Bundle.main.url(forResource: tiltShiftImage.imageName, withExtension: "compressed")!
        
        // Create the operations
        let dataLoad = DataLoadOperation(url: url)
        let imageDecompress = ImageDecompressionOperation(data: nil)
        let tiltShift = TiltShiftOperation(image: nil)
        let filterOutput = ImageFilterOutputOperation { [weak self] image in
            self?.image = image
            completion(image)
        }
        
        let operations = [dataLoad, imageDecompress, tiltShift, filterOutput]
        
        // Add dependencies
        imageDecompress.addDependency(dataLoad)
        tiltShift.addDependency(imageDecompress)
        filterOutput.addDependency(tiltShift)
        
        operationQueue.addOperations(operations, waitUntilFinished: false)
    }
    
    func cancel() {
        operationQueue.cancelAllOperations()
    }
}

extension TiltShiftImageProvider: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(tiltShiftImage.imageName)
        hasher.combine(tiltShiftImage.title)
    }
}

func ==(lhs: TiltShiftImageProvider, rhs: TiltShiftImageProvider) -> Bool {
    return lhs.tiltShiftImage == rhs.tiltShiftImage
}
