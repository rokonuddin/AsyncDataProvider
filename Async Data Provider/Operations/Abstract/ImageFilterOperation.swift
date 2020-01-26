//
//  ImageFilterOperation.swift
//  Asynchronous Data Provider
//
//  Created by Rokon Uddin on 1/26/20.
//  Copyright © 2020 Rokon Uddin. All rights reserved.
//

import UIKit

protocol ImageFilterDataProvider {
    var image: UIImage? { get }
}

class ImageFilterOperation: Operation {
    var filterOutput: UIImage?
    fileprivate let _filterInput: UIImage?
    
    init(image: UIImage?) {
        _filterInput = image
        super.init()
    }
    
    var filterInput: UIImage? {
        var image: UIImage?
        if let inputImage = _filterInput {
            image = inputImage
        } else if let dataProvider = dependencies
            .filter({ $0 is ImageFilterDataProvider })
            .first as? ImageFilterDataProvider {
            image = dataProvider.image
        }
        return image
    }
}

extension ImageFilterOperation: ImageFilterDataProvider {
    var image: UIImage? {
        return filterOutput
    }
}
