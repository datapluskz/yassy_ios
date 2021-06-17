//
//  Address.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 26.04.2021.
//

import Foundation
struct AddressUser : Codable {
    let label : String?
    let country : String?
    let county : String?
    let city : String?
    let district : String?
    let postalCode : String?
    let additionalData : [AdditionalData]?

    enum CodingKeys: String, CodingKey {

        case label = "Label"
        case country = "Country"
        case county = "County"
        case city = "City"
        case district = "District"
        case postalCode = "PostalCode"
        case additionalData = "AdditionalData"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decodeIfPresent(String.self, forKey: .label)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        county = try values.decodeIfPresent(String.self, forKey: .county)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        district = try values.decodeIfPresent(String.self, forKey: .district)
        postalCode = try values.decodeIfPresent(String.self, forKey: .postalCode)
        additionalData = try values.decodeIfPresent([AdditionalData].self, forKey: .additionalData)
    }

}
