//
//  ProfileDataManager.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 5/23/21.
//

import Foundation
import Alamofire
import UIKit

class ProfileDataManager: NSObject {
    func callingProfileData(onCompletion: @escaping(ProfileModel) -> ()){
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(UserDefaults.standard.string(forKey: Tokens.token)!)"
        ]
        
        AF.request(AppKeys.profileURL, method: .get, headers: headers).response {
            response in
            
            debugPrint(response)
            
            switch response.result{
            case .success(let data):
                do {
                    let profile = try JSONDecoder().decode(ProfileModel.self, from: data!)
                    if response.response?.statusCode == 200{
                        onCompletion(profile)
                    }
                } catch{
                    print(error)
                }
            case .failure(let err):
                print(err.localizedDescription)
                
            }
            
        }
    }
    
    func updateProfileData(parameters: [String : Any], onCompletion: @escaping (Bool, ProfileModel) -> () ){
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(UserDefaults.standard.string(forKey: Tokens.token)!)",
            "X-Requested-With" : "XMLHttpRequest"
        ]
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                if let temp = value as? String {
                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                }
                if let temp = value as? UIImage{
                    multipartFormData.append(temp.jpegData(compressionQuality: 0.5)!, withName: key, fileName: "file.png", mimeType: "image/png")
                }
                if let temp = value as? Int {
                    multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
                }
            }
        }, to: AppKeys.updateProfileURL, method: .post , headers: headers).response { response in
            debugPrint(response)
            
            switch response.result{
            case .success(let data):
                do {
                    let profile = try JSONDecoder().decode(ProfileModel.self, from: data!)
                    if response.response?.statusCode == 200{
                        onCompletion(true,profile)
                    } else {
                        onCompletion(false,profile)
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

