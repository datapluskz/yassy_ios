//
//  Location.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 26.04.2021.
//

import Foundation
struct Location : Codable {
    let locationId : String?
    let locationType : String?
    let displayPosition : DisplayPosition?
    let mapView : MapView?
    let address : AddressUser?
    let mapReference : MapReference?

    enum CodingKeys: String, CodingKey {

        case locationId = "LocationId"
        case locationType = "LocationType"
        case displayPosition = "DisplayPosition"
        case mapView = "MapView"
        case address = "Address"
        case mapReference = "MapReference"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        locationId = try values.decodeIfPresent(String.self, forKey: .locationId)
        locationType = try values.decodeIfPresent(String.self, forKey: .locationType)
        displayPosition = try values.decodeIfPresent(DisplayPosition.self, forKey: .displayPosition)
        mapView = try values.decodeIfPresent(MapView.self, forKey: .mapView)
        address = try values.decodeIfPresent(AddressUser.self, forKey: .address)
        mapReference = try values.decodeIfPresent(MapReference.self, forKey: .mapReference)
    }

}
