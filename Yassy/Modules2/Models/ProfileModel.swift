import Foundation

struct ProfileModel: Decodable {
    let id: Int
    let first_name: String
    let last_name: String
    let email: String
    let mobile: String
    let picture: String?
    let business_url: String?
    let business_name: String?
    let business_position: String?
    let is_business: String?
}
