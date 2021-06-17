//
//  Menu.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 5/22/21.
//

import Foundation

enum MenuOptions: String, CaseIterable {
    case home = "Главная"
    case favourites = "Избранные адреса"
    case paymentMethods = "Способы оплаты"
    case history = "История заказов"
    case help = "Помощь"
    case settings = "Настройки"
    case news = "Новости"
    case info = "Информация"
    
    var imageName: String {
        switch self {
        case .home:
            return "ic_main-1"
        case .favourites:
            return "ic_bookmark"
        case .paymentMethods:
            return "ic_payment"
        case .history:
            return "ic_history"
        case .help:
            return "ic_support"
        case .settings:
            return "ic_settings"
        case .news:
            return "iv_news"
        case .info:
            return "ic_info"
        
        }
    }
}
