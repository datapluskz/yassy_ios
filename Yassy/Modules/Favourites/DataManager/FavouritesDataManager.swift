//
//  FavouritesDataManager.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 10.05.2021.
//

import Foundation
import Alamofire

class FavouritesDataManager: NSObject {
    
    func callingAddAddress(addressModel: NewAddressModel, completion: @escaping (Bool) -> ()) {
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(UserDefaults.standard.string(forKey: Tokens.token)!)",
            "X-Requested-With" : "XMLHttpRequest"
        ]
        
        AF.request(AppKeys.favouriteAddressesURL, method: .post, parameters: addressModel, encoder: JSONParameterEncoder.default, headers: headers).response {
            response in
            debugPrint(response)
            switch response.result {
            case .success( _):
                do {
                    if response.response?.statusCode == 200 {
                        completion(true)
                    } else {
                        completion(false)
                    }
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func callingFavouriteAddresses(completion: @escaping (AllAddressModel) -> ()) {
        
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(UserDefaults.standard.string(forKey: Tokens.token)!)"
        ]
        
        AF.request(AppKeys.favouriteAddressesURL, method: .get, headers: headers).response {
            response in
            debugPrint(response)
            switch response.result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(AllAddressModel.self, from: data!)
                    completion(result)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func callingDeleteFavouriteAddress(addressId: Int, completion: @escaping (Bool) -> ()) {
        
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(UserDefaults.standard.string(forKey: Tokens.token)!)" ,
            "X-Requested-With" : "XMLHttpRequest"
        ]
        
        let url = "https://my.yassy.taxi/api/user/location/\(addressId)"
        
        AF.request(url, method: .delete, headers: headers).response {
            response in
            debugPrint(response)
            switch response.result {
            case .success( _):
                do {
                    if response.response?.statusCode == 200 {
                        completion(true)
                    } else {
                        completion(false)
                    }
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
        
    }
    
    func searchAddressByCoordinates(lat: Double, lon: Double, complation: @escaping (UserAddress) -> ()) {
        let parameters = [
            "q" : "\(lat),\(lon)"
        ]
        
        AF.request(AppKeys.userAddress, method: .post, parameters: parameters).response {
            response in
            print("Параметры --- ", parameters)
            debugPrint(response)
            switch response.result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(UserAddress.self, from: data!)
                    complation(result)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func searchPlaces(address: String, complation: @escaping (([SearchAddress]) -> ())) {
        DispatchQueue.global(qos: .utility).async {
            let parameters = [
                "q" : address
            ]
            
            AF.request(AppKeys.seachAddress, method: .get, parameters: parameters).response {
                result in
                debugPrint(result)
                switch result.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode([SearchAddress].self, from: data!)
                        print("Result is \(result) \n")
                        print("-----------------------")
                        complation(result)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
        }
    }
}
