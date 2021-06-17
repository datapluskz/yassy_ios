//
//  Data.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 30.04.2021.
//

import Foundation
struct DataStatus : Codable {
    let id : Int?
    let booking_id : String?
    let current_provider_id : Int?
    let service_type_id : Int?
    let status : String?
    let s_address : String?
    let d_address : String?
    let s_longitude : Double?
    let s_latitude : Double?
    let d_longitude : Double?
    let d_latitude : Double?
    let cancelled_by : String?
    let provider_last_name : String?
    let provider_first_name : String?
    let provider_number : String?
    let provider_longitude : Double?
    let provider_latitude : Double?
    let provider_avatar : String?
    let provider_service_number : String?
    let provider_service_car : String?
    let provider_service_color : String?
    let provider_service_year : String?
    let provider_service_model : String?
    let service_type_name : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case booking_id = "booking_id"
        case current_provider_id = "current_provider_id"
        case service_type_id = "service_type_id"
        case status = "status"
        case s_address = "s_address"
        case d_address = "d_address"
        case s_longitude = "s_longitude"
        case s_latitude = "s_latitude"
        case d_longitude = "d_longitude"
        case d_latitude = "d_latitude"
        case cancelled_by = "cancelled_by"
        case provider_last_name = "provider_last_name"
        case provider_first_name = "provider_first_name"
        case provider_number = "provider_number"
        case provider_longitude = "provider_longitude"
        case provider_latitude = "provider_latitude"
        case provider_avatar = "provider_avatar"
        case provider_service_number = "provider_service_number"
        case provider_service_car = "provider_service_car"
        case provider_service_color = "provider_service_color"
        case provider_service_year = "provider_service_year"
        case provider_service_model = "provider_service_model"
        case service_type_name = "service_type_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        booking_id = try values.decodeIfPresent(String.self, forKey: .booking_id)
        current_provider_id = try values.decodeIfPresent(Int.self, forKey: .current_provider_id)
        service_type_id = try values.decodeIfPresent(Int.self, forKey: .service_type_id)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        s_address = try values.decodeIfPresent(String.self, forKey: .s_address)
        d_address = try values.decodeIfPresent(String.self, forKey: .d_address)
        s_longitude = try values.decodeIfPresent(Double.self, forKey: .s_longitude)
        s_latitude = try values.decodeIfPresent(Double.self, forKey: .s_latitude)
        d_longitude = try values.decodeIfPresent(Double.self, forKey: .d_longitude)
        d_latitude = try values.decodeIfPresent(Double.self, forKey: .d_latitude)
        cancelled_by = try values.decodeIfPresent(String.self, forKey: .cancelled_by)
        provider_last_name = try values.decodeIfPresent(String.self, forKey: .provider_last_name)
        provider_first_name = try values.decodeIfPresent(String.self, forKey: .provider_first_name)
        provider_number = try values.decodeIfPresent(String.self, forKey: .provider_number)
        provider_longitude = try values.decodeIfPresent(Double.self, forKey: .provider_longitude)
        provider_latitude = try values.decodeIfPresent(Double.self, forKey: .provider_latitude)
        provider_avatar = try values.decodeIfPresent(String.self, forKey: .provider_avatar)
        provider_service_number = try values.decodeIfPresent(String.self, forKey: .provider_service_number)
        provider_service_car = try values.decodeIfPresent(String.self, forKey: .provider_service_car)
        provider_service_color = try values.decodeIfPresent(String.self, forKey: .provider_service_color)
        provider_service_year = try values.decodeIfPresent(String.self, forKey: .provider_service_year)
        provider_service_model = try values.decodeIfPresent(String.self, forKey: .provider_service_model)
        service_type_name = try values.decodeIfPresent(String.self, forKey: .service_type_name)
    }

}

