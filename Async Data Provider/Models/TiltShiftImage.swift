//
//  TiltShiftImage.swift
//  Asynchronous Data Provider
//
//  Created by Rokon Uddin on 1/26/20.
//  Copyright © 2020 Rokon Uddin. All rights reserved.
//

struct TiltShiftImage {
    let imageName: String
    let title: String
}

extension TiltShiftImage {
    static func loadDefaultData() -> [TiltShiftImage] {
        return [
            TiltShiftImage(imageName: "sample_01_small", title: "Camels"),
            TiltShiftImage(imageName: "sample_02_small", title: "Desert Camp"),
            TiltShiftImage(imageName: "sample_03_small", title: "Sky Train at Night"),
            TiltShiftImage(imageName: "sample_04_small", title: "Sky Train at Dusk"),
            TiltShiftImage(imageName: "sample_05_small", title: "Cityscape"),
            TiltShiftImage(imageName: "sample_06_small", title: "Daytime Sky Train"),
            TiltShiftImage(imageName: "sample_07_small", title: "Golden Arches"),
            TiltShiftImage(imageName: "sample_08_small", title: "Aeroplane"),
            TiltShiftImage(imageName: "sample_09_small", title: "Traffic at Night")
        ]
    }
}

extension TiltShiftImage: Equatable { }

func ==(lhs: TiltShiftImage, rhs: TiltShiftImage) -> Bool {
    return lhs.imageName == rhs.imageName && lhs.title == rhs.title
}
