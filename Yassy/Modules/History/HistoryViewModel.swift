//
//  HistoryViewModel.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 08.05.2021.
//

import Foundation

class HistoryViewModel: NSObject {
    private var apiService: HistoryDataManager
    
    private(set) var historyData : [HistoryModel]? {
        didSet {
            self.bindHistoryArrayDataToController()
        }
    }
    
    
    var bindHistoryArrayDataToController : (() -> ()) = {}
    
    init(apiService: HistoryDataManager) {
        self.apiService = apiService
        super.init()
        callingApiForGetHistoryData()
    }
    
    func callingApiForGetHistoryData(){
        apiService.callingHistoryFromApi { [weak self]
            (historyData) in
            self?.historyData = historyData
        }
    }
    
    
    
}
