//
//  EndedView.swift
//  OrangeTaxi
//
//  Created by Tanirbergen Kaldibai on 07.05.2021.
//

import UIKit

class EndedView: UIView {
    
    var sizeScreen = UIScreen.main.bounds
    var imageView = UIImageView(image: #imageLiteral(resourceName: "race-flag 1").withRenderingMode(.alwaysOriginal))
    var title = UILabel()
    var addressView = UIView()
    var firstAddressView = UIImageView()
    var infoView = UIView()
    var helperIcon = UIView()
    var endAddressIcon = UIView()
    var firstAddressIcon = UIImageView(image: #imageLiteral(resourceName: "point").withRenderingMode(.alwaysOriginal))
    var secondAddressIcon = UIImageView(image: #imageLiteral(resourceName: "orange-point").withRenderingMode(.alwaysOriginal))
    var handleMainButton = UIButton(type: .system)
    var testView = UIView()
    var footerImage = UIImageView(image: #imageLiteral(resourceName: "shape (2)").withRenderingMode(.alwaysOriginal))
    var firstAddress = UILabel()
    var secondAddress = UILabel()
    
    var price = UILabel()
    var titlePrice = UILabel()
    
    lazy var iconStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            firstAddressIcon,
            handleMainButton
        ])
        sv.axis = .vertical
        sv.spacing = 12
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .white
        configureView()
        configureAddressView()
    }
    
    private func configureView() {
        testView.backgroundColor = #colorLiteral(red: 0.5802810192, green: 0.5804046392, blue: 0.568443954, alpha: 1)
        testView.alpha = 0.65
        
        [testView, addressView, handleMainButton, footerImage].forEach {
            addSubview($0)
        }
        testView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
        addressView.layer.cornerRadius = 8
        addressView.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 32, bottom: 0, right: 32))
        addressView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        addressView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        addressView.heightAnchor.constraint(equalToConstant: sizeScreen.height / 2.5).isActive = true
        
        [imageView, title, infoView, price, titlePrice].forEach {
            addressView.addSubview($0)
        }
        
        handleMainButton.anchor(top: nil, leading: nil, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 32, bottom: 0, right: 0))
        handleMainButton.widthAnchor.constraint(equalToConstant: addressView.frame.size.width).isActive = true
        
        imageView.anchor(top: addressView.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 20, left: 0, bottom: 0, right: 0))
        imageView.centerXAnchor.constraint(equalTo: addressView.centerXAnchor).isActive = true
        
        
        title.anchor(top: imageView.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 16, left: 0, bottom: 0, right: 0))
        title.centerXAnchor.constraint(equalTo: addressView.centerXAnchor).isActive = true
        
        
        
        infoView.anchor(top: title.safeAreaLayoutGuide.bottomAnchor, leading: addressView.leadingAnchor, bottom: nil, trailing: addressView.trailingAnchor, padding: .init(top: 12, left: 20, bottom: 0, right: 20))
        infoView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        [firstAddressIcon, secondAddressIcon ,firstAddress, secondAddress].forEach {
            infoView.addSubview($0)
        }
        
        firstAddressIcon.anchor(top: infoView.topAnchor, leading: infoView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 8, left: 8, bottom: 0, right: 0))
        secondAddressIcon.anchor(top: firstAddressIcon.bottomAnchor, leading: infoView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 8, bottom: 0, right: 0))
        firstAddress.anchor(top: infoView.topAnchor, leading: firstAddressIcon.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 8, left: 12, bottom: 0, right: 0))
        secondAddress.anchor(top: firstAddressIcon.bottomAnchor, leading: secondAddressIcon.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 18, left: 8, bottom: 0, right: 0))
        
        price.anchor(top: infoView.safeAreaLayoutGuide.bottomAnchor, leading: infoView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 12, left: 4, bottom: 0, right: 0))
        titlePrice.anchor(top: infoView.safeAreaLayoutGuide.bottomAnchor, leading: nil, bottom: nil, trailing: infoView.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 4))
        
        handleMainButton.anchor(top: nil, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 32, bottom: 24, right: 32))
        footerImage.anchor(top: addressView.bottomAnchor, leading: addressView.leadingAnchor, bottom: nil, trailing: addressView.trailingAnchor, padding: .init(top: -6, left: 0, bottom: 0, right: 0))

    }
    
    private func configureAddressView() {
        title.configureLabel(text: "Ваша поездка завершена!", textColor: .black, textAlignment: .center, fontName: "", fontSize: 12, numberOfLines: 0)
        infoView.backgroundColor = #colorLiteral(red: 0.972464025, green: 0.9726033807, blue: 0.9724336267, alpha: 1)
        infoView.layer.cornerRadius = 8
        firstAddress.configureLabel(text: AddressInformation.s_address, textColor: .black, textAlignment: .natural, fontName: "", fontSize: 12, numberOfLines: 0)
        secondAddress.configureLabel(text: AddressInformation.d_address, textColor: .black, textAlignment: .natural, fontName: "", fontSize: 12, numberOfLines: 0)
        price.configureLabel(text: "За поездку", textColor: .lightGray, textAlignment: .natural, fontName: "", fontSize: 12, numberOfLines: 0)
        titlePrice.configureLabel(text: "\(DetailItems.price) ₸", textColor: .black, textAlignment: .natural, fontName: "", fontSize: 13, numberOfLines: 0)
        handleMainButton.configureButton(title: "На главную", titleColor: .white, isEnabled: true, cornerRadius: 12, borderWidth: 0, borderColor: UIColor.clear.cgColor, height: 50, backgroundColor: .yassyOrange)
        addressView.backgroundColor = .white
        shadowView()
        setupAction()
    }
    
    fileprivate func setupAction() {
        
    }
    
    @objc fileprivate func handleCloseButton() {
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
