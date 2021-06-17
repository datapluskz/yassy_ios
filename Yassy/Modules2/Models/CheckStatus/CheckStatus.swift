//
//  CheckStatus.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 30.04.2021.
//

import Foundation

// MARK: - CheckStatusModel
struct CheckStatusModel: Codable {
    let data : DataStatus?
    let sos : String?
    let cash : Int?
    let online : Int?
    let rental : Int?
    let outstation : Int?
    let waitingStatus : Int?
    let waitingTime : Int?
    let debit_machine : Int?
    let voucher : Int?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case sos = "sos"
        case cash = "cash"
        case online = "online"
        case rental = "rental"
        case outstation = "outstation"
        case waitingStatus = "waitingStatus"
        case waitingTime = "waitingTime"
        case debit_machine = "debit_machine"
        case voucher = "voucher"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(DataStatus.self, forKey: .data)
        sos = try values.decodeIfPresent(String.self, forKey: .sos)
        cash = try values.decodeIfPresent(Int.self, forKey: .cash)
        online = try values.decodeIfPresent(Int.self, forKey: .online)
        rental = try values.decodeIfPresent(Int.self, forKey: .rental)
        outstation = try values.decodeIfPresent(Int.self, forKey: .outstation)
        waitingStatus = try values.decodeIfPresent(Int.self, forKey: .waitingStatus)
        waitingTime = try values.decodeIfPresent(Int.self, forKey: .waitingTime)
        debit_machine = try values.decodeIfPresent(Int.self, forKey: .debit_machine)
        voucher = try values.decodeIfPresent(Int.self, forKey: .voucher)
    }

}
