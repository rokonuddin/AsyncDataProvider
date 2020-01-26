//
//  ImageFilterOutputOperation.swift
//  Asynchronous Data Provider
//
//  Created by Rokon Uddin on 1/26/20.
//  Copyright © 2020 Rokon Uddin. All rights reserved.
//

import UIKit

class ImageFilterOutputOperation: ImageFilterOperation {
    
    fileprivate let completion: (UIImage?) -> ()
    
    init(completion: @escaping (UIImage?) -> ()) {
        self.completion = completion
        super.init(image: nil)
    }
    
    override func main() {
        if isCancelled { return }
        completion(filterInput)
    }
}
