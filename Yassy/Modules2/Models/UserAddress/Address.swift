//
//  Address.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 13.04.2021.
//

import Foundation
struct UserAddress : Codable {
    let name : String?
    enum CodingKeys: String, CodingKey {
        case name = "name"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
}
