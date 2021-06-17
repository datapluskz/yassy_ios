//
//  FooterOrderView.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 27.02.2021.
//

import UIKit

class FooterOrderView: UIView, SetupView {
    
    // MARK: - Properties
//    lazy var walletImageView = UIImageView(image: #imageLiteral(resourceName: "colored").withRenderingMode(.alwaysOriginal))
    lazy var walletImageView = UIImageView()
    lazy var choseVariantsLabel = UILabel()
    lazy var choseVariantsButton = UIButton(type: .system)
    lazy var orderButton = UIButton(type: .system)
    lazy var hideChoseVariantsButton = UIButton(type: .system)
    lazy var addCardButton = UIButton(type: .system)
    lazy var cardLabel = UILabel()
    public var completionHandler: ((String?) -> Void)?
    public var progressTest = false
    
    // MARK: StackView
    lazy var stackOrderView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            choseVariantsLabel
        ])
        sv.axis = .horizontal
        sv.spacing = 6
        return sv
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        completionHandler?(cardLabel.text)
        print(cardLabel.text ?? "")
    }
    
    func setupView() {
        [walletImageView, stackOrderView, choseVariantsButton, orderButton, hideChoseVariantsButton, addCardButton, cardLabel].forEach {
            addSubview($0)
        }
        
        /// configureLabel

        /// configureImage
        walletImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20, left: 20, bottom: 0, right: 0))
        /// configureView
        stackOrderView.anchor(top: topAnchor, leading: walletImageView.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20, left: 6, bottom: 0, right: 0))
        
        /// configureButton
        choseVariantsButton.anchor(top: topAnchor, leading: stackOrderView.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20, left: 6, bottom: 0, right: 0))
        orderButton.anchor(top: stackOrderView.safeAreaLayoutGuide.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20))
        addCardButton.anchor(top: nil, leading: nil, bottom: nil, trailing: nil)
        cardLabel.anchor(top: addCardButton.safeAreaLayoutGuide.bottomAnchor, leading: addCardButton.leadingAnchor, bottom: nil, trailing: nil)
        configureView()
        setupAction()
    }
    
    func configureView() {
        backgroundColor = .white
        let business = BusinessAccountDefaults.getBusinessAccountData().isBusiness
        if business == "0" {
            choseVariantsLabel.configureLabel(text: "Оплата наличными", textColor: .black, textAlignment: .natural, fontName: "", fontSize: 16, numberOfLines: 0)
            walletImageView.image = #imageLiteral(resourceName: "colored")
        } else {
            choseVariantsLabel.configureLabel(text: "Бизнес аккаунт", textColor: .black, textAlignment: .natural, fontName: "", fontSize: 16, numberOfLines: 0)
            walletImageView.image = #imageLiteral(resourceName: "ic_work").withTintColor(.yassyLight)
        }
        orderButton.configureButton(title: "Заказать", titleColor: .white, isEnabled: true, cornerRadius: 12, borderWidth: 0, borderColor: UIColor.clear.cgColor, height: 50, backgroundColor: .yassyOrange)
        cardLabel.textColor = .black
        cardLabel.textAlignment = .natural
        cardLabel.numberOfLines = 0
        choseVariantsButton.setImage(#imageLiteral(resourceName: "ic_dropdown").withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    func setupAction() {
       // orderButton.addTarget(self, action: #selector(handleSearchTaxi), for: .touchUpInside)
    }
    
//    func configureChoseOrderButton() {
//        /// configureButton
//        addCardButton.configureButton(title: "Привязать карту", titleColor: .yassyOrange, isEnabled: true, cornerRadius: 0, borderWidth: 0, borderColor: UIColor.clear.cgColor, height: 50, backgroundColor: .white)
//    }
    
//    func hideChoseVariantsConfigure() {
//        hideChoseVariantsButton.anchor(top: topAnchor, leading: stackOrderView.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20, left: 6, bottom: 0, right: 0))
//        hideChoseVariantsButton.setImage(#imageLiteral(resourceName: "ic_dropdown").withRenderingMode(.alwaysOriginal), for: .normal)
//    }
    
    @objc func handleSearchTaxi(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let valid = "true"
            UserDefaults.standard.setValue(ProgressValue.valid, forKey: valid)
            print("1")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

