//
//  NetworkSimulator.swift
//  Asynchronous Data Provider
//
//  Created by Rokon Uddin on 1/26/20.
//  Copyright © 2020 Rokon Uddin. All rights reserved.
//

import Foundation

struct NetworkSimulator {
    static func asyncLoadDataAtURL(_ url: URL, completion: @escaping ((_ data: Data?) -> ())) {
        DispatchQueue.global(qos: .default).async {
            let data = syncLoadDataAtURL(url)
            DispatchQueue.main.async {
                completion(data)
            }
        }
    }
    
    static func syncLoadDataAtURL(_ url: URL) -> Data? {
        // Wait somewhere between 0 and 3 seconds
        let time = Int.random(in: 0...3)
        usleep(UInt32(time))
        return (try? Data(contentsOf: url))
    }
}
