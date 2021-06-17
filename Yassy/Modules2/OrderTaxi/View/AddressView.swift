//
//  AddressView.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 27.02.2021.
//

import UIKit

class AddressView: UIView, SetupView {
    
    // MARK: - Properies
    lazy var userAddressTextField = UITextField()
    lazy var seachAddressTextField = UITextField()
    
    // MARK: - Stack
    lazy var stackTextField: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            userAddressTextField,
            seachAddressTextField
        ])
        sv.axis = .vertical
        sv.spacing = 8
        return sv
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    func setupView() {
        layer.cornerRadius = 12
        backgroundColor = .white
        shadowView()
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        [stackTextField].forEach {
            addSubview($0)
        }
        
        stackTextField.anchor(top: topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 8, left: 4, bottom: 0, right: 4))
        
        configureView()
        setupAction()
    }
    
    func configureView() {
        userAddressTextField.configureTextField(placeholder: "", cornerRadius: 0, textColor: .black, font: "", fontSize: 16, height: 40, textAlignment: .natural)
        seachAddressTextField.configureTextField(placeholder: "", cornerRadius: 0, textColor: .black, font: "", fontSize: 16, height: 40, textAlignment: .natural)
        userAddressTextField.setupLeftImageToTextField(imageName: "point.pdf")
        userAddressTextField.setupLeftLabelToTextField(string: "Амангелді 45/2", left: 30)
        seachAddressTextField.setupLeftImageToTextField(imageName: "orange-point.pdf")
        seachAddressTextField.setupLeftLabelToTextField(string: "Жамбыла 37", left: 30)
    }
    
    func setupAction() {
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

