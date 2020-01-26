//
//  PostProcess.swift
//  Asynchronous Data Provider
//
//  Created by Rokon Uddin on 1/26/20.
//  Copyright © 2020 Rokon Uddin. All rights reserved.
//

import CoreImage
import UIKit


// This is an implementation of a Core Image filter chain that returns a CGImage
// backed UIImage. This is not usually the best approach - CIImage-backed
// UIImages are more optimised to display straight on screen.
func postProcessImage(_ image: UIImage) -> UIImage {
    
    guard let inputImage = CIImage(image: image) else { return image }
    
    // Create filter chain
    guard let photoFilter = CIFilter(name: "CIPhotoEffectInstant",
                                     parameters: ["inputImage" : inputImage]),
        let photoOutput = photoFilter.outputImage,
        let vignetteFilter = CIFilter(name: "CIVignette",
                                      parameters: ["inputRadius" : 1.75, "inputIntensity" : 1.0, "inputImage": photoOutput]),
        let filterOutput = vignetteFilter.outputImage else { return image }
    
    let ciContext = CIContext(options: nil)
    
    let cgImage = ciContext.createCGImage(filterOutput, from: inputImage.extent)
    return UIImage(cgImage: cgImage!)
}
