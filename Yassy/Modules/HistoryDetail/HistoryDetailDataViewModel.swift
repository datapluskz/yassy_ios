//
//  HistoryDetailDataViewModel.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 09.05.2021.
//

import Foundation

class HistoryDetailDataViewModel: NSObject {
    public let historyModel: HistoryDetailModel
    
    public init(historyModel: HistoryDetailModel) {
        self.historyModel = historyModel
    }
    
    public var cancelledBy: String {
        if historyModel.status == "CANCELLED" {
            switch historyModel.cancelled_by {
            case "USER":
                return "ВЫ ОТМЕНИЛИ"
            case "PROVIDER":
                return "ВОДИТЕЛЬ ОТМЕНИЛ"
            default:
                return " "
            }
        } else {
            return "ЗАВЕРШЕН"
        }
     
    }
    
    public var firstAddress: String {
        return historyModel.s_address ?? "---"
    }
    
    public var secondAddress: String {
        return historyModel.d_address ?? "---"
    }
    
    public var driverName: String {
        return "\(historyModel.provider_first_name ?? "---") \(historyModel.provider_last_name ?? "---")"
    }
    
    public var driverCarName: String {
        return "\(historyModel.provider_service_color ?? "---") \(historyModel.provider_service_car ?? "---") \(historyModel.provider_service_model ?? "---") \(historyModel.provider_service_number ?? "---")"
    }
    
    public var paymentMethod: String {
        if historyModel.payment_mode == "CASH" {
            return "Наличными"
        } else {
            return "Картой"
        }
    }
    
    public var tripTotalPrice: String {
        return "\(historyModel.total ?? "---") ₸"
    }
    
    public var serviceType: String {
        return historyModel.service_type_name ?? "---"
    }
    
    public var driverPhoneNumber: String {
        return "+7 \(historyModel.provider_number ?? "---")"
    }
    
    public var orderDate: String {
        return getDateFunc()
    }
    
    func getDateFunc() -> String{
        if historyModel.assigned_at != nil {
            var finalDate = "---"
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.locale = Locale(identifier: "ru")
            dateFormatterPrint.dateFormat = "EEEE HH:mm"
            let finished = historyModel.assigned_at?.date
            let date: NSDate? = dateFormatterGet.date(from: finished!) as NSDate?
            if let date = date {
                finalDate = dateFormatterPrint.string(from: date as Date)
            }
            return finalDate
        } else {
            return "---"
        }
    }
}
