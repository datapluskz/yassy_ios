//
//  AppConstants.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 24.02.2021.
//

import UIKit
import CoreLocation

// MARK: - For More Devices
let isSmallDevice = UIScreen.main.bounds.height < 568.0

// MARK: - SpleshVC Constants
let FIRST_PAGE  = "firstID"
let SECOND_PAGE = "secondID"
let THIRD_PAGE  = "thirdID"

let count = [FirstCollectionViewCell.self,
             SecondCollectionViewCell.self,
             ThirdCollectionViewCell.self]

struct YassyFonts {
    static let regularFont = "Roboto-Regular"
    static let mediumFont = "Roboto-Medium"
    static let boldFont = "Roboto-Bold"
}

struct AppKeys {
    struct SearchResultTableViewKeys {
        static let searchResultID = "searchResultID"
        static let heightForRowAt = 75.0
        static let numberOfRowsInSection = 15
    }
    
    static let turkestanCoordinate = CLLocationCoordinate2D(latitude: 43.303175, longitude: 68.265051)
    
    static var userAddressLan = UserDefaults.standard.string(forKey: UserAddressDefaults.lat )
    static var userAddressLon = UserDefaults.standard.string(forKey: UserAddressDefaults.lon )
   // https://my.yassy.taxi/api/user/register_otp/
    static let base_URL = "https://my.yassy.taxi"
    static let scheme = "https://"
    static let host = "my.yassy.taxi/"
    static let path = "api/user/"
    static let parametrs = "register_otp/"
    static let baseURL = "\(base_URL)/api/user/register_otp/"
    static let verifyURL = "\(base_URL)/api/user/signup/"
    static let userAddress = "\(base_URL)/ajax/search_coord.php"
    static let seachAddress = "\(base_URL)/ajax/search_address.php"
    static let orderTaxi = "\(base_URL)/api/user/calculate"
    static let deviceID = UserDefaults.standard.value(forKey: "ApplicationIdentifier")!
    static let locationName = "https://reverse.geocoder.ls.hereapi.com/6.2/reversegeocode.json"
    static let orderTaxiURL = "\(base_URL)/api/user/send/request"
    static let checkURL = "\(base_URL)/api/user/request/check"
    static let carIsComing = "\(base_URL)/api/user/trip/details"
    static let complatedURL = "\(base_URL)/api/user/rate/provider"
    static let reseonURL = "\(base_URL)/api/user/reasons"
    static let closeURL = "\(base_URL)/api/user/cancel/request"
    static let ratingURL = "\(base_URL)/api/user/rate/provider"
    static let historyURL = "\(base_URL)/api/user/trips"
    static let historyDetailURL = "\(base_URL)/api/user/trip/details"
    static let favouriteAddressesURL = "\(base_URL)/api/user/location"
    static let profileURL = "\(base_URL)/api/user/details"
    static let updateProfileURL = "\(base_URL)/api/user/update/profile"
    static let showPrivider = "\(base_URL)/api/user/show/providers"
    static let newsURL = "\(base_URL)/api/user/notifications/app"
    
}

struct ProgressValue {
    static let valid = ""
}

let parametrs: NSMutableDictionary? = [
    "country_code" : "7",
    "mobile" : ""
]

struct AddressName {
    static let lat = ""
    static let lon = ""
}

struct Tokens {
    static let token = ""
    static let device_token = ""
}


struct Fonts {
    static let appleFont = "Apple SD Gothic Neo Bold"
    static let regular = "Roboto-Regular"
}
