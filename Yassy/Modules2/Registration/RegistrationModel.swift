//
//  RegistrationModel.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 03.04.2021.
//

import Foundation

struct RegistrationModel: Codable {
    static let mobile = ""
    static let otp = ""
}

struct RegistrationData: Codable {
    let otp : String?
    let mobile : String?
    let registered : String?

    enum CodingKeys: String, CodingKey {

        case otp = "otp"
        case mobile = "mobile"
        case registered = "registered"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        otp = try values.decodeIfPresent(String.self, forKey: .otp)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        registered = try values.decodeIfPresent(String.self, forKey: .registered)
    }

}

struct VerifySMSCode: Codable {
    let id : Int?
    let first_name : String?
    let last_name : String?
    let payment_mode : String?
    let user_type : String?
    let email : String?
    let gender : String?
    let country_code : String?
    let mobile : String?
    let emergency_contact1 : String?
    let emergency_contact2 : String?
    let password : String?
    let picture : String?
    let device_token : String?
    let device_id : String?
    let device_type : String?
    let login_by : String?
    let social_unique_id : String?
    let latitude : String?
    let longitude : String?
    let stripe_cust_id : String?
    let wallet_balance : Int?
    let rating : String?
    let otp : Int?
    let language : String?
    let qrcode_url : String?
    let referral_unique_id : String?
    let referal_count : Int?
    let updated_at : String?
    let access_token : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case first_name = "first_name"
        case last_name = "last_name"
        case payment_mode = "payment_mode"
        case user_type = "user_type"
        case email = "email"
        case gender = "gender"
        case country_code = "country_code"
        case mobile = "mobile"
        case emergency_contact1 = "emergency_contact1"
        case emergency_contact2 = "emergency_contact2"
        case password = "password"
        case picture = "picture"
        case device_token = "device_token"
        case device_id = "device_id"
        case device_type = "device_type"
        case login_by = "login_by"
        case social_unique_id = "social_unique_id"
        case latitude = "latitude"
        case longitude = "longitude"
        case stripe_cust_id = "stripe_cust_id"
        case wallet_balance = "wallet_balance"
        case rating = "rating"
        case otp = "otp"
        case language = "language"
        case qrcode_url = "qrcode_url"
        case referral_unique_id = "referral_unique_id"
        case referal_count = "referal_count"
        case updated_at = "updated_at"
        case access_token = "access_token"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        payment_mode = try values.decodeIfPresent(String.self, forKey: .payment_mode)
        user_type = try values.decodeIfPresent(String.self, forKey: .user_type)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        country_code = try values.decodeIfPresent(String.self, forKey: .country_code)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        emergency_contact1 = try values.decodeIfPresent(String.self, forKey: .emergency_contact1)
        emergency_contact2 = try values.decodeIfPresent(String.self, forKey: .emergency_contact2)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        picture = try values.decodeIfPresent(String.self, forKey: .picture)
        device_token = try values.decodeIfPresent(String.self, forKey: .device_token)
        device_id = try values.decodeIfPresent(String.self, forKey: .device_id)
        device_type = try values.decodeIfPresent(String.self, forKey: .device_type)
        login_by = try values.decodeIfPresent(String.self, forKey: .login_by)
        social_unique_id = try values.decodeIfPresent(String.self, forKey: .social_unique_id)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        stripe_cust_id = try values.decodeIfPresent(String.self, forKey: .stripe_cust_id)
        wallet_balance = try values.decodeIfPresent(Int.self, forKey: .wallet_balance)
        rating = try values.decodeIfPresent(String.self, forKey: .rating)
        otp = try values.decodeIfPresent(Int.self, forKey: .otp)
        language = try values.decodeIfPresent(String.self, forKey: .language)
        qrcode_url = try values.decodeIfPresent(String.self, forKey: .qrcode_url)
        referral_unique_id = try values.decodeIfPresent(String.self, forKey: .referral_unique_id)
        referal_count = try values.decodeIfPresent(Int.self, forKey: .referal_count)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        access_token = try values.decodeIfPresent(String.self, forKey: .access_token)
    }

}
