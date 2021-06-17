//
//  ProfileDataDefaults.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 5/27/21.
//

import Foundation

struct ProfileDataDefaults {
    static let (nameKey, phoneKey, imageKey) = ("name", "phone", "image")
    static let profileSessionKey = "com.profile.usersession"
    private static let userDefault = UserDefaults.standard
    
    struct ProfileDetails {
        let name: String
        let phone: String
        let image: String
        
        init(_ json: [String: String]) {
            self.name = json[nameKey] ?? ""
            self.phone = json[phoneKey] ?? ""
            self.image = json[imageKey] ?? ""
        }
    }
    
    static func save(name: String, phone: String, image: String){
        userDefault.set([nameKey: name, phoneKey: phone, imageKey: image], forKey: profileSessionKey)
        print("Profile data saved in user defaults")
    }
    
   
    
    static func getProfileData() -> ProfileDetails {
        return ProfileDetails((userDefault.value(forKey: profileSessionKey) as? [String: String]) ?? [:])
    }
    
    static func clearProfileData(){
        userDefault.removeObject(forKey: profileSessionKey)
        print("Profile data deleted from user defaults")
    }
    
}
