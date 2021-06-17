//
//  MetaInfo.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 26.04.2021.
//

import Foundation
struct MetaInfo : Codable {
    let timestamp : String?

    enum CodingKeys: String, CodingKey {

        case timestamp = "Timestamp"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        timestamp = try values.decodeIfPresent(String.self, forKey: .timestamp)
    }

}
