//
//  HistoryDetailViewModel.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 09.05.2021.
//

import Foundation

class HistoryDetailViewModel: NSObject {
    private var apiService: HistoryDataManager
    
    private(set) var historyData : HistoryDetailDataViewModel? {
        didSet {
            self.bindHistoryDataToController()
        }
    }
    
    
    var bindHistoryDataToController : (() -> ()) = {}
    
    init(apiService: HistoryDataManager, requestId: Int) {
        self.apiService = apiService
        super.init()
        callingApiForGetHistoryData(requestId: requestId)
    }
    
    func callingApiForGetHistoryData(requestId: Int){ 
        apiService.callingHistoryDetail(requestId: requestId) { [weak self]
            (historyData) in
            self?.historyData = HistoryDetailDataViewModel(historyModel: historyData)
        }
    }
    
    
    
}

