//
//  HomeAddressDefaults.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 6/1/21.
//

import Foundation

struct HomeAddressDefaults {
    static let (homeAddressKey, homeLatitudeKey, homeLongitudeKey) = ("homeAddress","homeLatitude","homeLongitude")
    static let homeAddressSessionKey = "com.homeaddress.usersession"
    private static let userDefault = UserDefaults.standard
    
    struct HomeAddressDetails {
        let homeAddress: String
        let homeLatitude: String
        let homeLongitude: String
        
        init(_ json: [String: String]) {
            self.homeAddress = json[homeAddressKey] ?? ""
            self.homeLatitude = json[homeLatitudeKey] ?? ""
            self.homeLongitude = json[homeLongitudeKey] ?? ""
        }
    }
    
    static func saveHomeAddress(address: String, latitude: String, longitude: String){
        userDefault.set([homeAddressKey:address, homeLatitudeKey: latitude, homeLongitudeKey: longitude], forKey: homeAddressSessionKey)
        print("Home address saved")
    }
    
    static func getHomeAddressData() -> HomeAddressDetails {
        return HomeAddressDetails((userDefault.value(forKey: homeAddressSessionKey) as? [String: String]) ?? [:])
    }
    
    static func clearHomeAddressData(){
        userDefault.removeObject(forKey: homeAddressSessionKey)
        print("Home address deleted")
    }

}
