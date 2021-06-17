//
//  HistoryModel.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 08.05.2021.
//

import Foundation

struct HistoryDetailModel: Decodable {
    let id: Int?
    let cancelled_by: String? //
    let s_address: String? //
    let d_address: String? //
    let s_longitude: Double? //
    let s_latitude: Double? //
    let d_longitude: Double? //
    let d_latitude: Double? //
    let assigned_at: AssignedTime? //
    let finished_at: AssignedTime? //
    let payment_mode: String? //
    let estimated_fare: Int?
    let status: String?
    let total: String? //
    let provider_last_name: String? //
    let provider_first_name: String? //
    let provider_number: String? //
    let provider_service_number: String? //
    let provider_service_car: String? //
    let provider_service_color: String? //
    let provider_service_year: String? //
    let provider_service_model: String? //
    let service_type_name: String? //
}

struct AssignedTime: Decodable {
    let date: String?
    let timezone_type: Int?
    let timezone: String?
}

struct HistoryModel: Decodable {
    let s_address: String?
    let d_address: String?
    let id: Int?
    let cancelled_by: String?
    let assigned_at: String?
    let arrived_at: String?
    let picked_up_at: String?
    let finished_at: String?
    let status: String?
}
