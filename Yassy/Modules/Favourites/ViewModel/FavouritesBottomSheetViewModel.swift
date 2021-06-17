//
//  FavouritesBottomSheetViewModel.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 10.05.2021.
//

import Foundation

class FavouritesBottomSheetViewModel: NSObject {
    
    private var dataManager: FavouritesDataManager
    
    var addressType = String()
    
    private(set) var searchResponseData : [SearchAddress]? {
        didSet {
            self.bindAddressDataToController()
        }
    }
    
    var bindAddressDataToController : (() -> ()) = {}
    
    
    init(dataManager: FavouritesDataManager) {
        self.dataManager = dataManager
        super.init()
    }
    
    func callToDataManagerForGetLocations(address: String){
        dataManager.searchPlaces(address: address) { [weak self]
            (addressData) in
            self?.searchResponseData = addressData
        }
    }
    
}

extension FavouritesBottomSheetViewModel: PassAddressTypeDelegate {
    
    func passAddressType(type: String) {
        addressType = type
    }
    
    
}

extension FavouritesBottomSheetViewModel: FavouritesBottomSheetViewModelInput {
    func searchAddress(address: String) {
        callToDataManagerForGetLocations(address: address)
    }
}
