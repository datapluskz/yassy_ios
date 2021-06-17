//
//  BottomRight.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 26.04.2021.
//

import Foundation
struct BottomRight : Codable {
    let latitude : Double?
    let longitude : Double?

    enum CodingKeys: String, CodingKey {

        case latitude = "Latitude"
        case longitude = "Longitude"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
    }

}
