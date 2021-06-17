//
//  FavouriteAddressVC.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 12.05.2021.
//

import UIKit

protocol FavouritesViewModelInput: AnyObject {
    func deleteFavouriteAddress()
}

class EditFavouriteAddressVC: UIViewController {
    
    var viewModel: EditAddressViewModel
    
    weak var viewModelInput: FavouritesViewModelInput?
    
    typealias completion = (Bool) -> Void
    var addressDeletedCompletion: completion!
    
    init(viewModel: EditAddressViewModel){
        self.viewModel = viewModel
        self.viewModelInput = self.viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.viewModelOutput = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var addressTextField = CustomLineTextFieldWithImage(
        placeHolder: "kkkk", imageName: viewModel.imageName)
    let saveButton = UIButton(type: .system)
    let deleteButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    fileprivate func setupViews(){
        view.backgroundColor = .white
        configureButton()
        setupNavigationBar()
        [addressTextField, saveButton].forEach { (views) in
            view.addSubview(views)
        }
        addressTextField.setAnchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor,
                                   bottom: nil, right: view.rightAnchor,
                                   paddingTop: 16, paddingLeft: 24, paddingBottom: 0, paddingRight: 24)
        saveButton.setAnchor(top: nil, left: view.leftAnchor,
                             bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,
                             paddingTop: 0, paddingLeft: 24, paddingBottom: -8, paddingRight: 24, height: 50)
        addressTextField.isUserInteractionEnabled = false
        addressTextField.text = viewModel.addressData.address
    }
    
    @objc func deleteAddressTapped() {
        viewModelInput?.deleteFavouriteAddress()
    }
    
    private func setupNavigationBar(){
        self.navigationItem.leftBarButtonItem = self.navigationController?.addBackButton()
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        let rightBarButton = UIBarButtonItem()
        rightBarButton.customView = deleteButton
        navigationItem.rightBarButtonItem = rightBarButton
        setupNavigationTitle()
    }
    
    private func setupNavigationTitle(){
        switch viewModel.addressData.type {
        case "home":
            navigationItem.title = "Дом"
        case "work":
            navigationItem.title = "Работа"
        default:
            navigationItem.title = "Новый адрес"
        }
    }
    
    private func configureButton(){
        saveButton.backgroundColor = .yassyOrange
        saveButton.layer.cornerRadius = 8
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        
        deleteButton.setTitle("Удалить", for: .normal)
        deleteButton.setTitleColor(.black, for: .normal)
        deleteButton.titleLabel?.font = .systemFont(ofSize: 14)
        deleteButton.addTarget(self, action: #selector(deleteAddressTapped), for: .touchUpInside)
    }

}

extension EditFavouriteAddressVC: FavouriteAddressViewModelOutput {
    
    func deleteFavouriteAddressSuccess() {
        addressDeletedCompletion(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    func deleteFavouriteAddressFailure() {
        showAlert(alertString: "Не получилось удалить адрес")
    }
    
    
}
