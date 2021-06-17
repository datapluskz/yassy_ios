//
//  CloseModel.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 06.05.2021.
//

import Foundation
struct CloseModel : Codable {
    let error : String?

    enum CodingKeys: String, CodingKey {

        case error = "error"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        error = try values.decodeIfPresent(String.self, forKey: .error)
    }

}
