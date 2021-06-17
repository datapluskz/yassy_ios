//
//  ProfileViewModel.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 5/26/21.
//

import Foundation
import UIKit


class ProfileViewModel: NSObject {
    private var apiService: ProfileDataManager
    
    private(set) var profileData : [Model]? {
        didSet {
            self.bindProfileDataToController()
        }
    }
    
    private(set) var profileImage : URL? {
        didSet {
            self.bindProfileImageToController()
        }
    }
    
    var bindProfileDataToController : (() -> ()) = {}
    var bindProfileImageToController : (() -> ()) = {}
    
    init(apiService: ProfileDataManager) {
        self.apiService = apiService
        super.init()
        callToApiForGetProfileData()
    }
    
    private func callToApiForGetProfileData(){
        apiService.callingProfileData { [weak self]
            (profileModel) in
            self?.profileData = [Model(title: profileModel.first_name, imageName: "ic_profile"),
                                 Model(title: profileModel.mobile, imageName: "ic_call_small"),
                                 Model(title: profileModel.email, imageName: "ic_mail")]
            if let picture = profileModel.picture {
                self?.profileImage = URL(string: "https://my.yassy.taxi/storage/" + picture)
            }
        }
    }
}

extension ProfileViewModel: ProfileViewModelInput {
    
    func updateProfileImage(image: UIImage) {
        let parameters = ["picture": image]
        apiService.updateProfileData(parameters: parameters) { (isSuccess, profileModel)  in
            if isSuccess {
                ProfileDataDefaults.clearProfileData()
                ProfileDataDefaults.save(name: profileModel.first_name, phone: profileModel.mobile, image: profileModel.picture ?? "")
                print("Profile is ", profileModel)
                print("Успешно")
            } else {
                print("Не совсем")
            }
        }
    }
    
    func reloadProfileData() {
        callToApiForGetProfileData()
    }
}
