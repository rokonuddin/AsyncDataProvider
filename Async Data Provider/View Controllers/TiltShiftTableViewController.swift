//
//  TiltShiftTableViewController.swift
//  Asynchronous Data Provider
//
//  Created by Rokon Uddin on 1/26/20.
//  Copyright © 2020 Rokon Uddin. All rights reserved.
//

import UIKit

class TiltShiftTableViewController: UITableViewController {
    
    let imageList = TiltShiftImage.loadDefaultData()
    var imageProviders = [IndexPath: TiltShiftImageProvider]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.prefetchDataSource = self
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TiltShiftCell", for: indexPath) as? ImageTableViewCell else {
            fatalError("TiltShiftCell not found")
        }
        cell.updateImageViewWithImage(nil)
        return cell
    }
    
    private func configureCell(_ cell: ImageTableViewCell, at indexPath: IndexPath) {
        cell.tiltShiftImage = imageList[indexPath.row]
        if let image = imageProviders[indexPath]?.image {
            OperationQueue.main.addOperation {
                cell.updateImageViewWithImage(image)
            }
        } else {
            let imageProvider = TiltShiftImageProvider(tiltShiftImage: imageList[indexPath.row]) {
                image in
                OperationQueue.main.addOperation {
                    cell.updateImageViewWithImage(image)
                }
            }
            
            imageProviders[indexPath] = imageProvider
        }
        
    }
}

extension TiltShiftTableViewController {
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? ImageTableViewCell else { return }
        configureCell(cell, at: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let _ = cell as? ImageTableViewCell else { return }
        if let provider = imageProviders[indexPath] {
            provider.cancel()
            imageProviders.removeValue(forKey: indexPath)
        }
    }
}

// MARK: - Table view prefetching data source
extension TiltShiftTableViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            let imageProvider = TiltShiftImageProvider(tiltShiftImage: imageList[indexPath.row]) { _ in }
            imageProviders[indexPath] = imageProvider
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if let imageProvider = imageProviders[indexPath] {
                imageProvider.cancel()
                imageProviders.removeValue(forKey: indexPath)
            }
        }
    }
}
