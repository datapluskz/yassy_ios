//
//  View.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 26.04.2021.
//

import Foundation
struct View : Codable {
    let _type : String?
    let viewId : Int?
    let result : [Result]?

    enum CodingKeys: String, CodingKey {

        case _type = "_type"
        case viewId = "ViewId"
        case result = "Result"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _type = try values.decodeIfPresent(String.self, forKey: ._type)
        viewId = try values.decodeIfPresent(Int.self, forKey: .viewId)
        result = try values.decodeIfPresent([Result].self, forKey: .result)
    }

}
