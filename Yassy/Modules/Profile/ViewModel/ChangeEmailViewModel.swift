//
//  ChangeEmailViewModel.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 5/29/21.
//

import Foundation

protocol ChangeEmailViewModelOutput: AnyObject {
    func changeEmailSuccess()
    func changeEmailFailure()
}

class ChangeEmailViewModel: NSObject, ChangeEmailViewModelInput {
    private var apiService: ProfileDataManager
    
    
    weak var viewModelOutput: ChangeEmailViewModelOutput?
    init(apiService: ProfileDataManager) {
        self.apiService = apiService
        super.init()
    }
    
    func changeEmail(name: String) {
        let parameters = ["email": name]
        apiService.updateProfileData(parameters: parameters) { [weak self]
            (isSuccess, profileModel) in
            if isSuccess {
                self?.viewModelOutput?.changeEmailSuccess()
            } else {
                self?.viewModelOutput?.changeEmailFailure()
            }
        }
    }
}
