//
//  ShowPrivider.swift
//  OrangeTaxi
//
//  Created by Tanirbergen Kaldibai on 27.05.2021.
//

import Foundation

struct ShowProvider: Codable {
    let id : Int?
    let bort_number : String?
    let first_name : String?
    let last_name : String?
    let middle_name : String?
    let email : String?
    let gender : String?
    let country_code : String?
    let mobile : String?
    let card_number : String?
    let card_service : String?
    let emergency_contact1 : String?
    let emergency_contact2 : String?
    let avatar : String?
    let rating : String?
    let status : String?
    let cpf : String?
    let fleet : Int?
    let latitude : Double?
    let longitude : Double?
    let stripe_acc_id : String?
    let stripe_cust_id : String?
    let paypal_email : String?
    let login_by : String?
    let social_unique_id : String?
    let otp : Int?
    let wallet_balance : Int?
    let referral_unique_id : String?
    let qrcode_url : String?
    let created_at : String?
    let updated_at : String?
    let service : CarService?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case bort_number = "bort_number"
        case first_name = "first_name"
        case last_name = "last_name"
        case middle_name = "middle_name"
        case email = "email"
        case gender = "gender"
        case country_code = "country_code"
        case mobile = "mobile"
        case card_number = "card_number"
        case card_service = "card_service"
        case emergency_contact1 = "emergency_contact1"
        case emergency_contact2 = "emergency_contact2"
        case avatar = "avatar"
        case rating = "rating"
        case status = "status"
        case cpf = "cpf"
        case fleet = "fleet"
        case latitude = "latitude"
        case longitude = "longitude"
        case stripe_acc_id = "stripe_acc_id"
        case stripe_cust_id = "stripe_cust_id"
        case paypal_email = "paypal_email"
        case login_by = "login_by"
        case social_unique_id = "social_unique_id"
        case otp = "otp"
        case wallet_balance = "wallet_balance"
        case referral_unique_id = "referral_unique_id"
        case qrcode_url = "qrcode_url"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case service = "service"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        bort_number = try values.decodeIfPresent(String.self, forKey: .bort_number)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        middle_name = try values.decodeIfPresent(String.self, forKey: .middle_name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        country_code = try values.decodeIfPresent(String.self, forKey: .country_code)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        card_number = try values.decodeIfPresent(String.self, forKey: .card_number)
        card_service = try values.decodeIfPresent(String.self, forKey: .card_service)
        emergency_contact1 = try values.decodeIfPresent(String.self, forKey: .emergency_contact1)
        emergency_contact2 = try values.decodeIfPresent(String.self, forKey: .emergency_contact2)
        avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
        rating = try values.decodeIfPresent(String.self, forKey: .rating)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        cpf = try values.decodeIfPresent(String.self, forKey: .cpf)
        fleet = try values.decodeIfPresent(Int.self, forKey: .fleet)
        latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
        stripe_acc_id = try values.decodeIfPresent(String.self, forKey: .stripe_acc_id)
        stripe_cust_id = try values.decodeIfPresent(String.self, forKey: .stripe_cust_id)
        paypal_email = try values.decodeIfPresent(String.self, forKey: .paypal_email)
        login_by = try values.decodeIfPresent(String.self, forKey: .login_by)
        social_unique_id = try values.decodeIfPresent(String.self, forKey: .social_unique_id)
        otp = try values.decodeIfPresent(Int.self, forKey: .otp)
        wallet_balance = try values.decodeIfPresent(Int.self, forKey: .wallet_balance)
        referral_unique_id = try values.decodeIfPresent(String.self, forKey: .referral_unique_id)
        qrcode_url = try values.decodeIfPresent(String.self, forKey: .qrcode_url)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        service = try values.decodeIfPresent(CarService.self, forKey: .service)
    }

}
