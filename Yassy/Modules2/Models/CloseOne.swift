//
//  CloseOne.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 06.05.2021.
//

import Foundation
struct CloseOne : Codable {
    let id : Int?
    let type : String?
    let reason : String?
    let status : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case type = "type"
        case reason = "reason"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        reason = try values.decodeIfPresent(String.self, forKey: .reason)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }

}
