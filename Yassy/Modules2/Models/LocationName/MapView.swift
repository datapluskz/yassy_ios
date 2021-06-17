//
//  MapView.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 26.04.2021.
//

import Foundation
struct MapView : Codable {
    let topLeft : TopLeft?
    let bottomRight : BottomRight?

    enum CodingKeys: String, CodingKey {

        case topLeft = "TopLeft"
        case bottomRight = "BottomRight"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        topLeft = try values.decodeIfPresent(TopLeft.self, forKey: .topLeft)
        bottomRight = try values.decodeIfPresent(BottomRight.self, forKey: .bottomRight)
    }

}
