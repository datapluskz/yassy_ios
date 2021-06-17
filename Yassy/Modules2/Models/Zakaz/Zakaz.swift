//
//  Zakaz.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 26.04.2021.
//

import Foundation
struct Zakaz : Codable {
    let message : String?
    let request_id : Int?
    let current_provider : Int?

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case request_id = "request_id"
        case current_provider = "current_provider"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        request_id = try values.decodeIfPresent(Int.self, forKey: .request_id)
        current_provider = try values.decodeIfPresent(Int.self, forKey: .current_provider)
    }

}
