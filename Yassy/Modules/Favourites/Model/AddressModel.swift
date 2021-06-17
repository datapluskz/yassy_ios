//
//  Address.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 10.05.2021.
//

import Foundation

struct AddressModel: Decodable {
    let id: Int
    let user_id: Int
    let address: String
    let latitude: Double
    let longitude: Double
    let type: String
}

struct NewAddressModel: Encodable {
    let address: String
    let latitude: Double
    let longitude: Double
    let type: String
}

struct AllAddressModel: Decodable {
    let home: [AddressModel]
    let work: [AddressModel]
    let others: [AddressModel]
}
