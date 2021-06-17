//
//  EditAddressViewModel.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 12.05.2021.
//

import Foundation

protocol FavouriteAddressViewModelOutput: AnyObject {
    func deleteFavouriteAddressSuccess()
    func deleteFavouriteAddressFailure()
}

class EditAddressViewModel: NSObject {
    private var dataManager : FavouritesDataManager
    
    weak var viewModelOutput: FavouriteAddressViewModelOutput?
    
    var addressData : AddressModel
    
    var imageName : String
    
    init(dataManager: FavouritesDataManager,
         addressData: AddressModel, imageName: String) {
        self.dataManager = dataManager
        self.addressData = addressData
        self.imageName = imageName
        super.init()
    }
    
}

extension EditAddressViewModel: FavouritesViewModelInput {
    
    func deleteFavouriteAddress() {
        dataManager.callingDeleteFavouriteAddress(addressId: addressData.id) { [weak self]
            (isSuccess) in
            if isSuccess {
                if self?.addressData.type == "home" {
                    HomeAddressDefaults.clearHomeAddressData()
                }
                
                if self?.addressData.type == "work" {
                    WorkAddressDefaults.clearworkAddressData()
                }
                
                self?.viewModelOutput?.deleteFavouriteAddressSuccess()
            } else {
                self?.viewModelOutput?.deleteFavouriteAddressFailure()
            }
        }
    }
    
    
}
