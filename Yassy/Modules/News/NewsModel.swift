//
//  NewsModel.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 6/4/21.
//

import Foundation

struct NewsModel: Decodable {
    let id: Int
    let notify_type: String
    let image: String
    let title: String
    let description: String
    let expiry_date: String
    let status: String
    let viewed_users_json: String
}
