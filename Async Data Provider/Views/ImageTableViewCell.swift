//
//  ImageTableViewCell.swift
//  Asynchronous Data Provider
//
//  Created by Rokon Uddin on 1/26/20.
//  Copyright © 2020 Rokon Uddin. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    var tiltShiftImage: TiltShiftImage? {
        didSet {
            if let tiltShiftImage = tiltShiftImage {
                titleLabel.text = tiltShiftImage.title
                updateImageViewWithImage(nil)
            }
        }
    }
    
    @IBOutlet weak var tsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func updateImageViewWithImage(_ image: UIImage?) {
        if let image = image {
            tsImageView.image = image
            tsImageView.alpha = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.tsImageView.alpha = 1.0
                self.activityIndicator.alpha = 0
            }, completion: {
                _ in
                self.activityIndicator.stopAnimating()
            })
            
        } else {
            tsImageView.image = nil
            tsImageView.alpha = 0
            activityIndicator.alpha = 1.0
            activityIndicator.startAnimating()
        }
    }
}
