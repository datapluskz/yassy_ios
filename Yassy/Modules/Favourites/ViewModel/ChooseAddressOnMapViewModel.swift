//
//  ChooseAddressOnMapViewModel.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 10.05.2021.
//

import Foundation

class ChooseAddressOnMapViewModel: NSObject {
    
    private var dataManager: FavouritesDataManager
    
    private(set) var addressStringData : UserAddress? {
        didSet {
            self.bindAddressStringToController()
        }
    }
    
    var bindAddressStringToController : (() -> ()) = {}
    
    init(dataManager: FavouritesDataManager) {
        self.dataManager = dataManager
        super.init()
    }
    
    func callToDataManagerForGetLocationString(lat: Double, lon: Double){
        dataManager.searchAddressByCoordinates(lat: lat, lon: lon) { [weak self]
            (addressString) in
            self?.addressStringData = addressString
        }
    }
}

extension ChooseAddressOnMapViewModel: ChooseAddressOnMapViewModelInput {
    func searchAddressByCoordinates(lat: Double, lon: Double) {
//        var latitude = String(lat)
//        var longitude = String(lon)
        callToDataManagerForGetLocationString(lat: lat, lon: lon)
    }
}
