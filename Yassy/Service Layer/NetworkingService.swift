//
//  NetworkingService.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 12.03.2021.
//

import UIKit
import Alamofire

public protocol Network {
        
    var eknotApi: String { get set }
    var smartCityApi: String { get set }
    var port: String { get set }
    
    var url: String { get }
    
    var headers: HTTPHeaders { get }
    var token: String { get }
    var refreshToken: String { get }
    
    var firebaseToken: String { get set }
}

extension Network {
    
    public var token: String {
        get {
            return UserDefaults.standard.string(forKey: "token") ?? ""
        }
    }
    
    public var refreshToken: String {
        get {
            return UserDefaults.standard.string(forKey: "refreshToken") ?? ""
        }
    }
    
}

public class NetworkManager: Network {
    
    public enum ImageType {
        case png, jpeg
    }
    
    //MARK: - Singleton
    
    public static let shared = NetworkManager()
    
    //MARK: - Variable
    
    public var headers: HTTPHeaders {
        get {
            return ["Authorization" : "Bearer \(token)"]
        }
    }
    
    public var url: String {
        get {
            return self.smartCityApi + self.port
        }
    }
    
    public var eknotApi: String = ""
    
    public var smartCityApi: String = ""
    
    public var port: String = ""
    
    public var firebaseToken: String = ""
    
    //MARK: - Get Requests
    
    public static func getResponse(_ url: String, params: Parameters = [:], _ complition: @escaping (AFDataResponse<Any>) -> Void) {
        AF.request(url, parameters: params, headers: self.shared.headers).responseJSON { (response) in
            debugPrint("StatusCode: ", response.response?.statusCode ?? 0)
            debugPrint("Server answer: ", response.value as Any)
            if response.response?.statusCode == 401 {
                updateToken() {
                    getResponse(url, params: params) { (response) in
                        complition(response)
                    }
                }
            }else {
                complition(response)
            }
        }
    }
    
    public static func getRequestDecodable<T: Decodable>(_ url: String, model: T.Type, _ complition: @escaping (AFDataResponse<T>) -> Void) {
        AF.request(url, headers: self.shared.headers).responseDecodable(of: model) { (response) in
            debugPrint("StatusCode: ", response.response?.statusCode ?? 0)
            debugPrint("Server answer: ", response.debugDescription)
            if response.response?.statusCode == 401 {
                updateToken() {
                    getRequestDecodable(url, model: model) { (response) in
                        complition(response)
                    }
                }
            }else {
                complition(response)
            }
        }
    }
    
    public static func getData(_ url: String, params: Parameters = [:], _ complition: @escaping (Data) -> Void) {
        AF.request(url, parameters: params, headers: self.shared.headers).responseJSON { (response) in
            debugPrint("StatusCode: ", response.response?.statusCode ?? 0)
            debugPrint("Server answer: ", response.value as Any)
            if response.response?.statusCode == 401 {
                updateToken() {
                    getData(url) { (data) in
                        complition(data)
                    }
                }
            }else {
                guard let data = response.data else { return }
                complition(data)
            }
        }
    }
    
    //MARK: - Posts Requests
    
    public static func postRequest<T: Encodable>(_ url: String, model: T, _ complition: @escaping (AFDataResponse<Any>) -> Void) {
        guard let data = encodeParameters(model: model) else { return }
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpBody = data
        request.method = .post
        
        var postHeaders = self.shared.headers
        postHeaders.add(name: "Content-Type", value: "application/json")
        
        request.headers = postHeaders
        
        AF.request(request).responseJSON { (response) in
            debugPrint(response.response?.statusCode ?? 0)
            debugPrint(response.value as Any)
            if response.response?.statusCode == 401 {
                updateToken {
                    postRequest(url, model: model) { (response) in
                        complition(response)
                    }
                }
            }else {
                complition(response)
            }
        }
    }
    
    public static func postRequest(_ url: String, params: Parameters, _ complition: @escaping (AFDataResponse<Any>) -> Void) {
        guard let data = jsonSerialization(object: params) else { return }
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpBody = data
        request.method = .post
        
        var postHeaders = self.shared.headers
        postHeaders.add(name: "Content-Type", value: "application/json")
        
        request.headers = postHeaders
        
        AF.request(request).responseJSON { (response) in
            debugPrint(response.response?.statusCode ?? 0)
            debugPrint(response.value as Any)
            if response.response?.statusCode == 401 {
                updateToken {
                    postRequest(url, params: params) { (response) in
                        complition(response)
                    }
                }
            }else {
                complition(response)
            }
        }
    }
    
    //MARK: - Put/Patch Requests
    
    public static func putRequest(_ url: String, params: Parameters = [:], _ complition: @escaping (AFDataResponse<Any>) -> Void) {
        AF.request(url, method: .put, parameters: params, headers: self.shared.headers).responseJSON { (response) in
            if response.response?.statusCode == 401 {
                updateToken {
                    putRequest(url, params: params) { (response) in
                        complition(response)
                    }
                }
            }else {
                complition(response)
            }
        }
    }
    
    public static func patchRequest(_ url: String, params: Parameters = [:], _ complition: @escaping (AFDataResponse<Any>) -> Void) {
        AF.request(url, method: .patch, parameters: params, encoding: JSONEncoding.default, headers: self.shared.headers).responseJSON { (response) in
            if response.response?.statusCode == 401 {
                updateToken {
                    putRequest(url, params: params) { (response) in
                        complition(response)
                    }
                }
            }else {
                complition(response)
            }
        }
    }
    
    //MARK: - Delete Requests
    
    public static func deleteRequest(_ url: String, params: Parameters = [:], _ complition: @escaping (AFDataResponse<Any>) -> Void) {
        AF.request(url, method: .delete, parameters: params, encoding: JSONEncoding.default, headers: self.shared.headers).responseJSON { (response) in
            if response.response?.statusCode == 401 {
                updateToken {
                    putRequest(url, params: params) { (response) in
                        complition(response)
                    }
                }
            }else {
                complition(response)
            }
        }
    }
    
    //MARK: - Upload Requests
    
    public static func uploadRequest(_ url: String, params: Parameters, fileKey: String?, documents: [NSData], _ complition: @escaping (AFDataResponse<Any>) -> Void) {
        
        AF.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in params {
                if value is [String] {
                    let arrData = try! JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    multipartFormData.append(arrData, withName: key)
                }else {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
            }
            if let fileKey = fileKey {
                for nsdata in documents {
                    if let _ = UIImage(data: Data(referencing: nsdata)) {
                        multipartFormData.append(Data(referencing: nsdata), withName: fileKey, fileName: "\(documents.count + 1)", mimeType: "image/jpeg")
                    }else {
                        multipartFormData.append(Data(referencing: nsdata), withName: fileKey, fileName: "\(documents.count + 1)", mimeType: "text/plain")
                    }
                }
                debugPrint(multipartFormData)
            }
        }, to: url, method: .post, headers: self.shared.headers).responseJSON(completionHandler: { (response) in
            debugPrint(response.value ?? "")
            debugPrint(response.debugDescription)
            debugPrint(response.response?.statusCode ?? 0)
            
            if response.response?.statusCode == 401 {
                updateToken {
                    uploadRequest(url, params: params, fileKey: fileKey, documents: documents) { (response) in
                        complition(response)
                    }
                }
            }else {
                complition(response)
            }
            
        })
        
    }
    
    public static func uploadImageRequest(_ url: String, params: Parameters = [:], method: HTTPMethod = .put, imageType: ImageType = .jpeg, withName: String?, fileName: String =  "file.jpg", mimeType: String = "image/jpg", image: UIImage?, _ complition: @escaping (AFDataResponse<Any>) -> Void) {
        AF.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in params {
                if value is [String] {
                    let arrData = try! JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    multipartFormData.append(arrData, withName: key)
                }else if value is Parameters {
                    let data = NetworkManager.jsonSerialization(object: value)
                    multipartFormData.append(data!, withName: key)
                }else if let params = value as? [Parameters] {
                    for (index, value) in params.enumerated() {
                        if let answers = value["Answers"] as? [String], let object = answers.first {
                            let data = (object as AnyObject).data(using: String.Encoding.utf8.rawValue)!
                            multipartFormData.append(data, withName: "\(key)[\(index)][Answers][\(answers.firstIndex(of: object)!)]")
                        }
                        
                        if let questionGuid = value["QuestionGuid"] as? String {
                            let data = (questionGuid as AnyObject).data(using: String.Encoding.utf8.rawValue)!
                            multipartFormData.append(data, withName: "\(key)[\(index)][QuestionGuid]")
                        }
                    }
                } else {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
            }
            
            if let withName = withName {
                guard let image = image else { return }
                switch imageType {
                case .png:
                    guard let data = image.pngData() else { return }
                    multipartFormData.append(data, withName: withName, fileName: fileName, mimeType: mimeType)
                    debugPrint(multipartFormData)
                case .jpeg:
                    guard let data = image.jpegData(compressionQuality: 0.2) else { return }
                    multipartFormData.append(data, withName: withName, fileName: fileName, mimeType: mimeType)
                    debugPrint(multipartFormData)
                }
            }
        }, to: url, method: method, headers: self.shared.headers).responseJSON(completionHandler: { (response) in
            debugPrint(response.value ?? "")
            debugPrint(response.debugDescription)
            debugPrint(response.response?.statusCode ?? 0)
            
            if response.response?.statusCode == 401 {
                updateToken {
                    uploadImageRequest(url, params: params, withName: withName, image: image) { (response) in
                        complition(response)
                    }
                }
            }else {
                complition(response)
            }
            
        })
    }
    
    
    //MARK: - Update Token
    
    public static func updateToken(_ complition: @escaping () -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "token"), let refreshToken = UserDefaults.standard.string(forKey: "refreshToken") else { return }
        guard !token.isEmpty && !refreshToken.isEmpty else { return }
        
        let params: Parameters = [
            "token" : token,
            "refreshToken": refreshToken
        ]
        
        self.postRequest("\(self.shared.eknotApi)/api/v1/users/refresh", params: params) { (response) in
            guard let data = response.data else { return }
            let json = self.jsonSerialization(data: data)
            debugPrint(json)
            
            if let token = json["token"] as? String, let refreshToken = json["refreshToken"] as? String {
                guard !token.isEmpty, !refreshToken.isEmpty else {
                    complition()
                    return
                }
                UserDefaults.standard.set(token, forKey: "token")
                UserDefaults.standard.set(refreshToken, forKey: "refreshToken")
            }
            complition()
        }
    }
    
    //MARK: - Decode, Encode and Serialization
    
    public static func encodeParameters<T: Encodable>(model: T) -> Data? {
        do {
            let data = try JSONEncoder().encode(model)
            return data
        }catch (let error) {
            debugPrint(error.localizedDescription)
        }
        return nil
    }
    
    public static func decodeModel<T: Decodable>(model: T.Type, data: Data) -> T? {
        do {
            let model = try JSONDecoder().decode(model.self, from: data)
            return model
        }catch (let error) {
            debugPrint(error.localizedDescription)
        }
        return nil
    }
    
    public static func jsonSerialization(data: Data) -> Parameters {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            guard let params = json as? Parameters else { return [:] }
            return params
        }catch (let error) {
            debugPrint(error.localizedDescription)
        }
        return [:]
    }
    
    public static func jsonSerialization(object: Any) -> Data? {
        do {
            let data = try JSONSerialization.data(withJSONObject: object, options: [])
            return data
        }catch (let error) {
            debugPrint(error.localizedDescription)
        }
        return nil
    }
    
}


