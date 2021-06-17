//
//  AdditionalData.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 26.04.2021.
//

import Foundation
struct AdditionalData : Codable {
    let value : String?
    let key : String?

    enum CodingKeys: String, CodingKey {

        case value = "value"
        case key = "key"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        value = try values.decodeIfPresent(String.self, forKey: .value)
        key = try values.decodeIfPresent(String.self, forKey: .key)
    }

}
