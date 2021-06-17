//
//  MainViewModel.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 13.04.2021.
//

import Foundation

class MainViewModel {
    var bindData: (() -> ()) = {}
    var items: [SearchAddress] = []
    var locationItems: UserAddress!
    var locationName: AddressUser?
    var searchTaxi: Zakaz?
    var dataStatus: CheckStatusModel?
    var checked = Bool()
    var closeOne = [CloseOne]()
    private(set) var priceData = [OrderData]()
    private(set) var providerItems = [ShowProvider]()
    // MARK: - Injection
    private var dataManager: DataManager!
    
    init(dataManager: DataManager!) {
        self.dataManager = dataManager
    }
    
    private(set) var tastData: [SearchAddress]? {
        didSet {
            self.bindData()
        }
    }
    
    func getUserLocation(lat: String, lon: String, comp: @escaping() -> ()) {
        self.dataManager.getUserLocationName(lat: lat, lon: lon) { [weak self] (items) in
            guard let strong = self else { return }
            DispatchQueue.main.async {
                strong.locationItems = items
                comp()
            }
        }
    }
    
    func getPriceTaxi(comp: @escaping() -> ()) {
        self.dataManager.priceTaxi { [weak self] items in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.priceData = items
                comp()
            }
        }
    }
    
    func getCoordinateLocations(address: String, comp: @escaping() -> ()) {
        self.dataManager.searchPlaces(address: address) { [weak self] (data) in
            guard let stroing = self else { return }
            stroing.items = data
            comp()
        }
    }
    
    func searchTaxi(s_lat: String, s_lot: String, d_lat: String, d_lot: String, d_address: String, s_address: String, distance: String, comp: @escaping(_ check: Bool) -> ()) {
        self.dataManager.getOrderData(s_lat: s_lat, s_lon: s_lot, d_lat: d_lat, d_lon: d_lot, d_address: d_address, s_address: s_address, distance: distance) { [weak self] (items, check) in
            guard let self = self else { return }
            self.searchTaxi = items
            self.checked = check
            print("\(self.checked)" + "YEEEEEEEE")
            comp(check)
        }
    }
    
    func statusCheck(comp: @escaping(Bool) -> ()) {
        self.dataManager.checkStatusTaxi {  [weak self]  (data, check) in
            guard let self = self else { return }
            self.dataStatus = data
            comp(check)
        }
    }
    
    func closeOne(comp: @escaping() -> ()) {
        self.dataManager.closeOne { [weak self] (data) in
            guard let self = self else { return }
            self.closeOne = data
            comp()
        }
    }
    
    func closeEnd(id: String, reseon: String, comp: @escaping() -> ()) {
        self.dataManager.closeTaxi(reseon: reseon, id: id) {
            comp()
        }
    }
    
    func raiting(requestID: String, comp: @escaping(()->())) {
        dataManager.ratingCheck(request_id: requestID) {
            comp()
        }
    }
    
    func showProvider(comp: @escaping(()->())) {
        self.dataManager.showProvider { [weak self] item in
            guard let self = self else { return }
            self.providerItems = item
            comp()
        }
    }
}
