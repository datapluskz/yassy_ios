//
//  SearchAddress.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 16.04.2021.
//

import Foundation

struct SearchAddress : Codable {
    let map : String?
    let value : String?
    let type : String?
    let coords : String?
    let lat: String?
    let lon: String?
    let check : String?
 

    enum CodingKeys: String, CodingKey {

        case map = "map"
        case value = "value"
        case type = "type"
        case coords = "coords"
        case lat = "lat"
        case lon = "lon"
        case check = "check"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        map = try values.decodeIfPresent(String.self, forKey: .map)
        value = try values.decodeIfPresent(String.self, forKey: .value)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        coords = try values.decodeIfPresent(String.self, forKey: .coords)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lon = try values.decodeIfPresent(String.self, forKey: .lon)
        check = try values.decodeIfPresent(String.self, forKey: .check)
    }

}
