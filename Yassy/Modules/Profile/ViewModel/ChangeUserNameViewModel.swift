//
//  ChangeUserNameViewModel.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 5/27/21.
//

import Foundation

protocol ChangeUserNameViewModelOutput: AnyObject {
    func changeNameSuccess()
    func changeNameFailure()
}

class ChangeUserNameViewModel: NSObject, ChangeUserNameViewModelInput {
    private var apiService: ProfileDataManager
    
    
    weak var viewModelOutput: ChangeUserNameViewModelOutput?
    init(apiService: ProfileDataManager) {
        self.apiService = apiService
        super.init()
    }
    
    func changeName(name: String) {
        let parameters = ["first_name": name]
        apiService.updateProfileData(parameters: parameters) { [weak self]
            (isSuccess, profileModel)  in
            if isSuccess {
                ProfileDataDefaults.clearProfileData()
                ProfileDataDefaults.save(name: profileModel.first_name, phone: profileModel.mobile, image: profileModel.picture ?? "")
                self?.viewModelOutput?.changeNameSuccess()
            } else {
                self?.viewModelOutput?.changeNameFailure()
            }
        }
    }
}

