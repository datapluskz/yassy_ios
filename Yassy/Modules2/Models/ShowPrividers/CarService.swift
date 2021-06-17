//
//  CarService.swift
//  OrangeTaxi
//
//  Created by Tanirbergen Kaldibai on 27.05.2021.
//

struct CarService : Codable {
    let id : Int?
    let provider_id : Int?
    let service_type_id : Int?
    let status : String?
    let service_number : String?
    let service_car : String?
    let service_color : String?
    let service_year : String?
    let service_model : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case provider_id = "provider_id"
        case service_type_id = "service_type_id"
        case status = "status"
        case service_number = "service_number"
        case service_car = "service_car"
        case service_color = "service_color"
        case service_year = "service_year"
        case service_model = "service_model"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        provider_id = try values.decodeIfPresent(Int.self, forKey: .provider_id)
        service_type_id = try values.decodeIfPresent(Int.self, forKey: .service_type_id)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        service_number = try values.decodeIfPresent(String.self, forKey: .service_number)
        service_car = try values.decodeIfPresent(String.self, forKey: .service_car)
        service_color = try values.decodeIfPresent(String.self, forKey: .service_color)
        service_year = try values.decodeIfPresent(String.self, forKey: .service_year)
        service_model = try values.decodeIfPresent(String.self, forKey: .service_model)
    }

}
