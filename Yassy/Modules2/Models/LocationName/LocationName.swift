//
//  LocationName.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 26.04.2021.
//

import Foundation
struct LocationName : Codable {
    let response : Response?

    enum CodingKeys: String, CodingKey {

        case response = "Response"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        response = try values.decodeIfPresent(Response.self, forKey: .response)
    }

}
