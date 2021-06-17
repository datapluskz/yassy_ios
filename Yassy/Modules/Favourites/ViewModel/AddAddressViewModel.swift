//
//  AddAddressViewModel.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 14.05.2021.
//

import Foundation

protocol AddAddressViewModelOutput: AnyObject {
    func addAddressSuccess()
    func addAddressFailure()
}

class AddAddressViewModel: NSObject {
    private var dataManager : FavouritesDataManager
    private(set) var newAddressData : NewAddressModel
    var imageName : String
    
    weak var viewModelOutput: AddAddressViewModelOutput?
    
    init(dataManager: FavouritesDataManager,
         newAddressData: NewAddressModel,
         imageName: String) {
        self.dataManager = dataManager
        self.newAddressData = newAddressData
        self.imageName = imageName
        super.init()
    }
}

extension AddAddressViewModel: AddAddressViewModelInput {
    
    func addAddressTapped() {
        dataManager.callingAddAddress(addressModel: newAddressData) { [weak self]
            (isSuccess) in
            if isSuccess {
                if self?.newAddressData.type == "home" {
                    HomeAddressDefaults.clearHomeAddressData()
                    HomeAddressDefaults.saveHomeAddress(address: self?.newAddressData.address ?? "", latitude: String(self?.newAddressData.latitude ?? 0.0), longitude: String(self?.newAddressData.longitude ?? 0.0))
                }
                
                if self?.newAddressData.type == "work" {
                    WorkAddressDefaults.clearworkAddressData()
                    WorkAddressDefaults.saveWorkAddress(address: self?.newAddressData.address ?? "", latitude: String(self?.newAddressData.latitude ?? 0.0), longitude: String(self?.newAddressData.longitude ?? 0.0))
                }
                
                self?.viewModelOutput?.addAddressSuccess()
            } else {
                self?.viewModelOutput?.addAddressFailure()
            }
        }
    }
    
    
}
