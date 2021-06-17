//
//  DataManager.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 03.04.2021.
//

import Alamofire
import Foundation
import FirebaseMessaging



protocol NetworkingService {
    func getSMSCode(mobile: String, country: String, complation: @escaping(_ data: RegistrationData) -> ())
    func verifySMSCode(otp: String, mobile: String, email: String, complation: @escaping(_ data: VerifySMSCode, Bool) -> ())
    func getUserLocationName(lat: String, lon: String, complation: @escaping(_ data: UserAddress) -> ())
    func searchPlaces(address: String, complation: @escaping(_ data: [SearchAddress]) -> ())
    func priceTaxi(comp: @escaping(_ data: [OrderData]) -> ())
   // func getLocationName(lat: String, lon: String, complation: @escaping(_ data: AddressUser) -> ())
    func getOrderData(s_lat: String, s_lon: String, d_lat: String, d_lon: String, d_address: String, s_address: String, distance: String, comp: @escaping(_ data: Zakaz, Bool) -> ())
    func checkStatusTaxi(comp: @escaping(_ data: CheckStatusModel, Bool) -> ())
    func closeOne(comp: @escaping(_ data: [CloseOne]) ->())
    func closeTaxi(reseon: String, id: String, comp: @escaping () -> ())
    func showProvider(comp: @escaping(_ data: [ShowProvider]) -> ())
    func callingFavouriteAddresses(completion: @escaping (AllAddressModel) -> ())
    func callingProfileData(onCompletion: @escaping(ProfileModel) -> ())
}

struct Test {
    let s_lat = ""
}

final class DataManager: NetworkingService {
    
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
    
    func showProvider(comp: @escaping ([ShowProvider]) -> ()) {
        
        let header: HTTPHeaders = [
            "Authorization" : "Bearer \(UserDefaults.standard.string(forKey: Tokens.token)!)",
            "X-Requested-With": "XMLHttpRequest",
        ]
        
        let parameters = [
            "latitude": AddressInformation.s_lat,
            "longitude": AddressInformation.s_lon
        ]
        
        AF.request(AppKeys.showPrivider, method: .get, parameters: parameters, headers: header).response {
            result in
            
            debugPrint(result)
            
            switch result.result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode([ShowProvider].self, from: data!)
                    comp(result)
                } catch {
                    print(error.localizedDescription)
                }
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    
    func priceTaxi(comp: @escaping ([OrderData]) -> ()) {
        let header: HTTPHeaders = [
            "Authorization" : "Bearer \(UserDefaults.standard.string(forKey: Tokens.token)!)",
            "X-Requested-With": "XMLHttpRequest",
        ]
        
        
        let parameters = [
            "service_type" : "1",
            "d_longitude"  : AddressInformation.d_lon,
            "s_latitude"   : AddressInformation.s_lat,
            "d_latitude"   : AddressInformation.d_lat,
            "s_longitude"  : AddressInformation.s_lon
        ] as [String : Any]
        
        
        AF.request(AppKeys.orderTaxi, method: .post, parameters: parameters, headers: header).response {
            result in
            debugPrint(result)
            switch result.result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(OrderTaxi.self, from: data!)
                    comp(result.type)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func closeTaxi(reseon: String, id: String, comp: @escaping () -> ()) {
        
        let handler: HTTPHeaders = [
            "Authorization" : "Bearer \(UserDefaults.standard.string(forKey: Tokens.token)!)"
        ]
        
        let parameters = [
            "cancel_reason": reseon,
            "request_id": id
        ]
        AF.request(AppKeys.closeURL, method: .post,parameters: parameters, headers: handler).response { result in
            debugPrint(result)
            switch result.result {
            case .success:
                comp()
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    
    func closeOne(comp: @escaping ([CloseOne]) -> ()) {
        let handler: HTTPHeaders = [
            "Authorization" : "Bearer \(UserDefaults.standard.string(forKey: Tokens.token)!)"
        ]
        
        AF.request(AppKeys.reseonURL, method: .get, headers: handler).response {
            result in
            switch result.result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode([CloseOne].self, from: data!)
                    comp(result)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func getSMSCode(mobile: String, country: String, complation: @escaping (RegistrationData) -> ()) {
        let registrationParametrs = [
            "country_code" : country,
            "mobile" : mobile
        ]
        
        print("PARRRAMMM\(registrationParametrs)")
        
        AF.request(AppKeys.baseURL, method: .post, parameters: registrationParametrs).response {
            result in
            debugPrint(result)
            switch result.result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(RegistrationData.self, from: data!)
                    complation(result)
                } catch {
                    print(error.localizedDescription)
                }
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
   
    
    func verifySMSCode(otp: String, mobile: String, email: String, complation: @escaping (VerifySMSCode, Bool) -> ()) {
        
        let verifyParametrs = [
            "device_token" : Messaging.messaging().fcmToken ?? "",
            "device_id"    : AppKeys.deviceID,
            "mobile"       : mobile,
            "otp"          : otp,
            "email"        : email,
            "device_type"  : "ios",
            "login_by"     : "whatsapp",
            "first_name"   : "No",
            "last_name"    : "Name",
            "country_code" : "7",
            "client_secret": "jDdpGm2ctXRnQbJepHrCBJu4HAr5amTMIEbgNQhp",
            "client_id"    : "2"
        ]
        
        AF.request(AppKeys.verifyURL, method: .post, parameters: verifyParametrs).response {
            response in
            debugPrint(response)
            switch response.result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(VerifySMSCode.self, from: data!)
                    if response.response?.statusCode == 200 {
                        complation(result,true)
                    } else {
                        complation(result,false)
                    }
                    
                } catch {
                    
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func getUserLocationName(lat: String, lon: String, complation: @escaping (UserAddress) -> ()) {
        let parameters = [
            "q" : "\(lat),\(lon)"
        ]
    
        AF.request(AppKeys.userAddress, method: .post, parameters: parameters).response {
            results in
           // results.request?.httpBody = parameters
            switch results.result {
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
            print(Thread.current)
        AF.request(AppKeys.seachAddress, method: .get, parameters: parameters).response {
            result in
            switch result.result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode([SearchAddress].self, from: data!)
                    complation(result)
                    print(parameters)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
          }
        }
      }
    
    func orderTaxi() {
         
    }
    
//    func getLocationName(lat: String, lon: String, complation: @escaping(_ data: AddressUser) -> ()) {
//        let parameters = [
//            "prox" : "\(lat),\(lon)",
//            "mode" : "retrieveAll",
//            "gen"  : "9",
//            "apiKey" : "52viDnD8Ei5DicF_kEHRHUSlM4G5Op6vMI1niZORPuM"
//        ]
//
//        print(parameters)
//        DispatchQueue.global(qos: .utility).async {
//        AF.request(AppKeys.locationName, method: .get, parameters: parameters).response {
//            result in
//            debugPrint(result)
//            switch result.result {
//            case .success(let data):
//                do {
//                    let result = try JSONDecoder().decode(LocationName.self, from: data!)
//                    complation((result.response?.view?.first?.result?.first?.location?.address)!)
//                } catch {
//                    print(error.localizedDescription)
//                }
//            case .failure(let err):
//                print(err.localizedDescription)
//            }
//        }
//        }
//    }
    
    func getOrderData(s_lat: String, s_lon: String, d_lat: String, d_lon: String, d_address: String, s_address: String, distance: String, comp: @escaping(_ data: Zakaz, Bool) -> ()) {
        
        var payment_mode = String()
        
        let business = BusinessAccountDefaults.getBusinessAccountData().isBusiness
        
        if business == "0" {
           payment_mode = "CASH"
        } else {
            payment_mode = "COMPANY"
        }
        
        let parameters = [
            "payment_mode" : payment_mode,
            "d_longitude"  : d_lon,
            "service_type" : "1",
            "distance"     : distance,
            "s_latitude"   : s_lat,
            "s_longitude"  : s_lon,
            "d_latitude"   : d_lat,
            "service_required":"none",
            "use_wallet" : "0",
            "promocode_id" : "0",
            "d_address" : d_address,
            "s_address" : s_address
        ]
        
        let header: HTTPHeaders = [
            "Authorization" : "Bearer \((UserDefaults.standard.string(forKey: Tokens.token)!))" ,
            "X-Requested-With": "XMLHttpRequest",
            "Accept" : "application/json"
        ]
        
        
        AF.request(AppKeys.orderTaxiURL, method: .post, parameters: parameters, headers: header).response {
            result in
            debugPrint(result)
                switch result.result {
                case .success(let data):
                    do {
                        if result.response?.statusCode == 200 {
                        let result = try JSONDecoder().decode(Zakaz.self, from: data!)
                            let a = true
                            comp(result, a)
                            print(a)
                        } else {
                            let result = try JSONDecoder().decode(Zakaz.self, from: data!)
                            let b = false
                            comp(result, b)
                            print(b)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let err):
                    print(err.localizedDescription)
            }
        }
    }
    
    func checkStatusTaxi(comp: @escaping(_ data: CheckStatusModel, Bool) -> ()) {
        let handler: HTTPHeaders = [
            "Authorization" : "Bearer \(UserDefaults.standard.string(forKey: Tokens.token)!)"
        ]
        AF.request(AppKeys.checkURL, method: .get, headers: handler).response {
            result in
            debugPrint(result)
            switch result.result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(CheckStatusModel.self, from: data!)
                    if result.data == nil || result.data?.status == "" {
                        let test = false
                        comp(result, test)
                    }
                    else {
                        let test = true
                        comp(result, test)
                    }

                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func ratingCheck(request_id: String, comp: @escaping() -> ()) {
        let handler: HTTPHeaders = [
            "Authorization" : "Bearer \(UserDefaults.standard.string(forKey: Tokens.token)!)",
            "X-Requested-With": "XMLHttpRequest"
        ]
        
        let parameters = [
            "request_id": request_id,
            "comment": "test",
            "rating": "4"
        ]
        
        AF.request(AppKeys.ratingURL, method: .post, parameters: parameters, headers: handler).response {
            result in
                switch result.result {
                case .success:
                        comp()
                case .failure(let err):
                    print(err)
            }
        }
    }
}

