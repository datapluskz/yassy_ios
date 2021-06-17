//
//  NewsDataManager.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 6/4/21.
//

import Foundation
import Alamofire

class NewsDataManager: NSObject {
    func callingNews(completion: @escaping ([NewsModel]) -> ()) {
        
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(UserDefaults.standard.string(forKey: Tokens.token)!)"
        ]
        
        AF.request(AppKeys.newsURL, method: .get, headers: headers).response {
            response in
            debugPrint(response)
            switch response.result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode([NewsModel].self, from: data!)
                    completion(result)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
