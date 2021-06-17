//
//  WorkAddressDefaults.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 6/1/21.
//

import Foundation

struct WorkAddressDefaults {
    static let (workAddressKey, workLatitudeKey, workLongitudeKey) = ("workAddress","workLatitude","workLongitude")
    static let workAddressSessionKey = "com.workaddress.usersession"
    private static let userDefault = UserDefaults.standard
    
    struct WorkAddressDetails {
        let workAddress: String
        let workLatitude: String
        let workLongitude: String
        
        init(_ json: [String: String]) {
            self.workAddress = json[workAddressKey] ?? ""
            self.workLatitude = json[workLatitudeKey] ?? ""
            self.workLongitude = json[workLongitudeKey] ?? ""
        }
    }
    
    static func saveWorkAddress(address: String, latitude: String, longitude: String){
        userDefault.set([workAddressKey:address, workLatitudeKey: latitude, workLongitudeKey: longitude], forKey: workAddressSessionKey)
        print("work address saved")
    }
    
    static func getWorkAddressData() -> WorkAddressDetails {
        return WorkAddressDetails((userDefault.value(forKey: workAddressSessionKey) as? [String: String]) ?? [:])
    }
    
    static func clearworkAddressData(){
        userDefault.removeObject(forKey: workAddressSessionKey)
        print("work address deleted")
    }

}
