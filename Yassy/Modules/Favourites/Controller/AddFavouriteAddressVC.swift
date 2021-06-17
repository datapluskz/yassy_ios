//
//  NewFavouriteAddressVC.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 14.05.2021.
//

import UIKit

protocol AddAddressViewModelInput: AnyObject {
    func addAddressTapped()
}

class AddFavouriteAddressVC: UIViewController {
    
    lazy var addressTextField = CustomLineTextFieldWithImage(
        placeHolder: "", imageName: viewModel.imageName)
    let saveButton = UIButton(type: .system)
    
    var viewModel: AddAddressViewModel
    
    weak var viewModelInput: AddAddressViewModelInput?
    
    typealias completion = (Bool) -> Void
    var addressAddedCompletion: completion!
    
    init(viewModel: AddAddressViewModel){
        self.viewModel = viewModel
        self.viewModelInput = self.viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.viewModelOutput = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        addressTextField.text = viewModel.newAddressData.address
    }
    
    private func setupNavigationBar(){
        self.navigationItem.leftBarButtonItem = self.navigationController?.addBackButton()
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        navigationItem.title = "Новый адрес"
    }
    
    private func configureButton(){
        saveButton.backgroundColor = .yassyOrange
        saveButton.layer.cornerRadius = 8
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.addTarget(self, action: #selector(saveAddressTapped), for: .touchUpInside)
    }
    
    @objc func saveAddressTapped(){
        viewModelInput?.addAddressTapped()
    }

}

extension AddFavouriteAddressVC: AddAddressViewModelOutput {
    
    func addAddressSuccess() {
        addressAddedCompletion(true)
        self.navigationController?.popViewController(animated: false)
    }
    
    func addAddressFailure() {
        showAlert(alertString: "Адрес не добавился!")
    }
    
    
}
