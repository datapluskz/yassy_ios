//
//  NewsViewModel.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 6/4/21.
//

import Foundation

class NewsViewModel: NSObject {
    
    private var dataManager: NewsDataManager
    
    private(set) var newsData : [NewsModel]? {
        didSet {
            self.bindNewsDataToController()
        }
    }
    
    var bindNewsDataToController : (() -> ()) = {}
    
    init(dataManager: NewsDataManager){
        self.dataManager = dataManager
        super.init()
        callToDataManager()
    }
    
    private func callToDataManager(){
        dataManager.callingNews { [weak self]
            (news) in
            self?.newsData = news
        }
    }
    
    
}
