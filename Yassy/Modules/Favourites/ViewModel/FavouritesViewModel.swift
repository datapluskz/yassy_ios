//
//  FavouritesViewModel.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 10.05.2021.
//

import Foundation

class FavouritesViewModel: NSObject {
    private var dataManager: FavouritesDataManager
    
    private(set) var homeAddressData : AddressModel? {
        didSet {
            self.bindHomeAddressToController()
        }
    }
    
    private(set) var workAddressData : AddressModel? {
        didSet {
            self.bindWorkAddressToController()
        }
    }
    
    private(set) var otherAddressesData : [AddressModel]? {
        didSet {
            self.bindOtherAddressesToController()
        }
    }
    
    var bindHomeAddressToController : (() -> ()) = {}
    var bindWorkAddressToController : (() -> ()) = {}
    var bindOtherAddressesToController : (() -> ()) = {}
    
    init(dataManager: FavouritesDataManager) {
        self.dataManager = dataManager
        super.init()
        callToDataManagerToGetFavouritesData()
    }
    
    func callToDataManagerToGetFavouritesData(){
        dataManager.callingFavouriteAddresses { [weak self]
            (allAddresses) in
            self?.homeAddressData = allAddresses.home.first
            self?.workAddressData = allAddresses.work.first
            self?.otherAddressesData = allAddresses.others
        }
    }
}

extension FavouritesViewModel: FavouritesListViewModelInput {
    func reloadFavourites() {
        callToDataManagerToGetFavouritesData()
    }
}

extension FavouritesViewModel: AddAddressSuccessDelegate {
    func addressAddedSuccessfully() {
        callToDataManagerToGetFavouritesData()
    }
}
