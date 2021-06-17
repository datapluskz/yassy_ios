//
//  HomeBottomSheetViewModel.swift
//  Yassy
//
//  Created by Didar Bakhitzhanov on 05.05.2021.
//

import Foundation

class HomeBottomSheetViewModel: NSObject {
    
    private var dataManager: DataManager
    
    var searchResponseData : [SearchAddress]? {
        didSet {
            self.bindAddressDataToController()
        }
    }
    
    var bindAddressDataToController : (() -> ()) = {}
    
    
    init(dataManager: DataManager) {
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

extension HomeBottomSheetViewModel: HomeBottomSheetViewModelInput {
    
    func searchAddress(address: String) {
        callToDataManagerForGetLocations(address: address)
    }
    
    
}
