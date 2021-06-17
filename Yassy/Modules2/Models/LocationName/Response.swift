//
//  Response.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 26.04.2021.
//

import Foundation
struct Response : Codable {
    let metaInfo : MetaInfo?
    let view : [View]?

    enum CodingKeys: String, CodingKey {

        case metaInfo = "MetaInfo"
        case view = "View"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        metaInfo = try values.decodeIfPresent(MetaInfo.self, forKey: .metaInfo)
        view = try values.decodeIfPresent([View].self, forKey: .view)
    }

}
