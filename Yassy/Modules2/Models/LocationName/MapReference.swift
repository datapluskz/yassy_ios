//
//  MapReference.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 26.04.2021.
//

import Foundation
struct MapReference : Codable {
    let referenceId : String?
    let mapId : String?
    let mapVersion : String?
    let mapReleaseDate : String?
    let sideOfStreet : String?
    let countryId : String?
    let countyId : String?
    let cityId : String?
    let districtId : String?

    enum CodingKeys: String, CodingKey {

        case referenceId = "ReferenceId"
        case mapId = "MapId"
        case mapVersion = "MapVersion"
        case mapReleaseDate = "MapReleaseDate"
        case sideOfStreet = "SideOfStreet"
        case countryId = "CountryId"
        case countyId = "CountyId"
        case cityId = "CityId"
        case districtId = "DistrictId"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        referenceId = try values.decodeIfPresent(String.self, forKey: .referenceId)
        mapId = try values.decodeIfPresent(String.self, forKey: .mapId)
        mapVersion = try values.decodeIfPresent(String.self, forKey: .mapVersion)
        mapReleaseDate = try values.decodeIfPresent(String.self, forKey: .mapReleaseDate)
        sideOfStreet = try values.decodeIfPresent(String.self, forKey: .sideOfStreet)
        countryId = try values.decodeIfPresent(String.self, forKey: .countryId)
        countyId = try values.decodeIfPresent(String.self, forKey: .countyId)
        cityId = try values.decodeIfPresent(String.self, forKey: .cityId)
        districtId = try values.decodeIfPresent(String.self, forKey: .districtId)
    }

}
