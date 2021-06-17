//
//  Result.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 26.04.2021.
//

import Foundation
struct Result : Codable {
    let relevance : Double?
    let distance : Double?
    let direction : Double?
    let matchLevel : String?
    let matchQuality : MatchQuality?
    let location : Location?

    enum CodingKeys: String, CodingKey {

        case relevance = "Relevance"
        case distance = "Distance"
        case direction = "Direction"
        case matchLevel = "MatchLevel"
        case matchQuality = "MatchQuality"
        case location = "Location"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        relevance = try values.decodeIfPresent(Double.self, forKey: .relevance)
        distance = try values.decodeIfPresent(Double.self, forKey: .distance)
        direction = try values.decodeIfPresent(Double.self, forKey: .direction)
        matchLevel = try values.decodeIfPresent(String.self, forKey: .matchLevel)
        matchQuality = try values.decodeIfPresent(MatchQuality.self, forKey: .matchQuality)
        location = try values.decodeIfPresent(Location.self, forKey: .location)
    }

}
