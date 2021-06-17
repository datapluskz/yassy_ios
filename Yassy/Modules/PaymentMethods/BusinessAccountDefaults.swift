//
//  BusinessAccountDefaults.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 6/12/21.
//

import Foundation

struct BusinessAccountDefaults {
    static let (isBusinessKey, businessNameKey, businessPositionKey, businessUrlKey) = ("isBusiness", "businessName", "businessPosition", "businessUrl")
    static let businessaccountSessionKey = "com.businessaccount.usersession"
    private static let userDefault = UserDefaults.standard
    
    struct BusinessAccountDetails {
        let isBusiness: String
        let businessName: String
        let businessPosition: String
        let businessUrl: String
        
        init(_ json: [String: String]) {
            self.isBusiness = json[isBusinessKey] ?? ""
            self.businessName = json[businessNameKey] ?? ""
            self.businessPosition = json[businessPositionKey] ?? ""
            self.businessUrl = json[businessUrlKey] ?? ""
        }
    }
    
    static func save(isBusiness: String, businessName: String, businessPosition: String, businessUrl: String){
        userDefault.set([isBusinessKey: isBusiness, businessNameKey: businessName, businessPositionKey: businessPosition, businessUrlKey: businessUrl], forKey: businessaccountSessionKey)
        print("BusinessAccount data saved in user defaults")
    }
    
   
    
    static func getBusinessAccountData() -> BusinessAccountDetails {
        return BusinessAccountDetails((userDefault.value(forKey: businessaccountSessionKey) as? [String: String]) ?? [:])
    }
    
    static func clearBusinessAccountData(){
        userDefault.removeObject(forKey: businessaccountSessionKey)
        print("BusinessAccount data deleted from user defaults")
    }
    
}
