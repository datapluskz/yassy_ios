//
//  File.swift
//  OrangeTaxi
//
//  Created by Tanirbergen Kaldibai on 23.05.2021.
//

import Foundation

struct OrderTaxi: Decodable {
    let type: [OrderData]
}

struct OrderData: Decodable {
    let estimated_fare: Int
    let distance: Double
    let minute: Int
    let time: String
    let surge: Int
    let surge_value: String
    let tax_price: Int
    let base_price: Int
    let service_type: Int
    let wallet_balance: String?
}
