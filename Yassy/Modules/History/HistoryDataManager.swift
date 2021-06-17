//
//  HistoryDataManager.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 08.05.2021.
//

import Foundation
import Alamofire

class HistoryDataManager: NSObject {
    func callingHistoryFromApi(onCompletion: @escaping([HistoryModel]) -> ()){
        
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(UserDefaults.standard.string(forKey: Tokens.token)!)"
        ]
        
        AF.request(AppKeys.historyURL, method: .get, headers: headers).response {
            response in
            
            debugPrint(response)
            
            switch response.result{
            case .success(let data):
                do {
                    let tasks = try JSONDecoder().decode([HistoryModel].self, from: data!)
                    if response.response?.statusCode == 200{
                        onCompletion(tasks)
                    }
                } catch{
                    print(error)
                }
            case .failure(let err):
                print(err.localizedDescription)
                
            }
            
        }
    }
    
    func callingHistoryDetail(requestId: Int, onCompletion: @escaping(HistoryDetailModel) -> ()){
        
        let parameters = [
            "request_id" : requestId
        ]
        
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(UserDefaults.standard.string(forKey: Tokens.token)!)",
            "X-Requested-With" : "XMLHttpRequest"
        ]
        
        AF.request(AppKeys.historyDetailURL, method: .get, parameters: parameters ,headers: headers).response {
            response in
            
            debugPrint(response)
            
            switch response.result{
            case .success(let data):
                do {
                    let model = try JSONDecoder().decode(HistoryDetailModel.self, from: data!)
                    if response.response?.statusCode == 200{
                        onCompletion(model)
                    } else {
                        onCompletion(model)
                    }
                } catch{
                    print(error)
                }
            case .failure(let err):
                print(err.localizedDescription)
                
            }
            
        }
    }
}
