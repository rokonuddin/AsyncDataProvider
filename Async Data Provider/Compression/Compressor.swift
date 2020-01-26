//
//  Compressor.swift
//  Asynchronous Data Provider
//
//  Created by Rokon Uddin on 1/26/20.
//  Copyright © 2020 Rokon Uddin. All rights reserved.
//

import Foundation

public struct Compressor {
    public static func loadCompressedFile(_ path: String) -> Data? {
        return Data(contentsOfArchive: path, usedCompression: .lzma)
    }
    
    public static func decompressData(_ data: Data) -> Data? {
        return data.uncompressed(using: .lzma)
    }
    
    public static func saveDataAsCompressedFile(_ data: Data, path: String) -> Bool {
        guard let compressedData = data.compressed(using: .lzma) else { return false }
        return ((try? compressedData.write(to: URL(fileURLWithPath: path), options: [.atomic])) != nil)
    }
}

