//
//  MatchQuality.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 26.04.2021.
//

import Foundation
struct MatchQuality : Codable {
    let country : Double?
    let county : Double?
    let city : Double?
    let district : Double?
    let postalCode : Double?

    enum CodingKeys: String, CodingKey {

        case country = "Country"
        case county = "County"
        case city = "City"
        case district = "District"
        case postalCode = "PostalCode"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        country = try values.decodeIfPresent(Double.self, forKey: .country)
        county = try values.decodeIfPresent(Double.self, forKey: .county)
        city = try values.decodeIfPresent(Double.self, forKey: .city)
        district = try values.decodeIfPresent(Double.self, forKey: .district)
        postalCode = try values.decodeIfPresent(Double.self, forKey: .postalCode)
    }

}
