//
//  HomeViewModel.swift
//  Yassy
//
//  Created by Didar Bakhitzhanov on 03.05.2021.
//

import Foundation

class HomeViewModel: NSObject {
    
    private var dataManager: DataManager
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        super.init()
    }
    
//    func callToDataManagerForGetLocations(address: String){
//        dataManager.searchPlaces(address: address) { [weak self]
//            (addressData) in
//            self?.viewModelOutput?.parseSuggestedAddress(
//                addressArray: addressData)
//        }
//    }
    
}
