//
//  CardViewController.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 01.03.2021.
//

import UIKit

class CardViewController: UIViewController, SetupView {
    // MARK: - Properties
    private let backButton = UIButton(type: .system)
    private let pageLabel = UILabel()
    private let cardNumberTextField = UITextField()
    private let userNameTextField = UITextField()
    private let validityCardNumberTextField = UITextField()
    private let cvvTextField = UITextField()
    private let addCardButton = UIButton(type: .system)
    
    // MARK: - Stack View
    lazy var userDataStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            cardNumberTextField,
            userNameTextField
        ])
        sv.axis = .vertical
        sv.spacing  = 36
        return sv
    }()
    
    lazy var validityStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            validityCardNumberTextField,
            cvvTextField
        ])
        sv.axis = .horizontal
        sv.spacing = 16
        sv.distribution = .fillEqually
        return sv
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupView()
        addCardButton.addTarget(self, action: #selector(handleShowMainPage), for: .touchUpInside)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
    }
    
    // MARK: - Methods
    func setupView() {
        [backButton, pageLabel, userDataStackView, validityStackView, addCardButton].forEach {
            view.addSubview($0)
        }
        
        /// button position
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 30, left: 25, bottom: 0, right: 0))
        addCardButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 36, right: 16))
        
        /// configure Label position
        pageLabel.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        pageLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor).isActive = true
        pageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        /// configureTextField
        userDataStackView.anchor(top: pageLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 60, left: 16, bottom: 0, right: 16))
        validityStackView.anchor(top: userDataStackView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 36, left: 16, bottom: 0, right: 16))
        /// setupMethods()
        configureView()
        setupAction()
    }
    
    func configureView() {
        configureNavigationBar(isHidden: true, backgroundColor: .clear, title: "")
        view.backgroundColor = .white
        
        /// configure button
        backButton.configureButton(title: "", titleColor: .clear, isEnabled: true, cornerRadius: 9, borderWidth: 0, borderColor: UIColor.clear.cgColor, height: 40, backgroundColor: .white)
        backButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.setImage(#imageLiteral(resourceName: "ic_back").withRenderingMode(.alwaysOriginal), for: .normal)
        backButton.shadowView()
        addCardButton.configureButton(title: ADD_CARD_TEXT, titleColor: .white, isEnabled: true, cornerRadius: 12, borderWidth: 0, borderColor: UIColor.clear.cgColor, height: 50, backgroundColor: .yassyOrange)
        addCardButton.alpha = 0
        /// configure label
        pageLabel.configureLabel(text: CARDVIEW_LABEL_STRING, textColor: .black, textAlignment: .center, fontName: "", fontSize: 20, numberOfLines: 0)
        cardNumberTextField.configureCardTextField(backgroundColor: UIColor.white, placeholderText: CARDNUMBER_TEXT, placeholderColor: UIColor.lightGray, textColor: UIColor.black)
        userNameTextField.configureCardTextField(backgroundColor: UIColor.white, placeholderText: CARD_USER_NAME, placeholderColor: UIColor.lightGray, textColor: UIColor.black)
        validityCardNumberTextField.configureCardTextField(backgroundColor: UIColor.white, placeholderText: CARD_VALIDATE_DATA, placeholderColor: UIColor.lightGray, textColor: UIColor.black)
        cvvTextField.configureCardTextField(backgroundColor: UIColor.white, placeholderText: CARD_CVV, placeholderColor: UIColor.lightGray, textColor: UIColor.black)
        cvvTextField.isSecureTextEntry = true
        cardNumberTextField.addBottomBorder(.yassyLight, height: 1.5)
        userNameTextField.addBottomBorder(.yassyLight, height: 1.5)
        validityCardNumberTextField.addBottomBorder(.yassyLight, height: 1.5)
        cvvTextField.addBottomBorder(.yassyLight, height: 1.5)
        
    }

    func setupAction() {
        cardNumberTextField.addTarget(self, action: #selector(handleChangeValue), for: .editingChanged)
        userNameTextField.addTarget(self, action: #selector(handleChangeValue), for: .editingChanged)
        validityCardNumberTextField.addTarget(self, action: #selector(handleChangeValue), for: .editingChanged)
        cvvTextField.addTarget(self, action: #selector(handleChangeValue), for: .editingChanged)
        backButton.addTarget(self, action: #selector(hanldeBackToOrderPage), for: .touchUpInside)
        cardNumberTextField.addTarget(self, action: #selector(handleCardNumberChangeBottom), for: .editingDidBegin)
        userNameTextField.addTarget(self, action: #selector(handleChaneCardUserBottom), for: .editingDidBegin)
        validityCardNumberTextField.addTarget(self, action: #selector(handleChangeValidityBottom), for: .editingDidBegin)
        cvvTextField.addTarget(self, action: #selector(handleChangeCVVBottom), for: .editingDidBegin)
    }
    
    /// configure change bottom line Card textFields
    @objc fileprivate func handleCardNumberChangeBottom() {
        UIView.animate(withDuration: 0.01) { [self] in
            cardNumberTextField.addBottomBorder(.yassyOrange, height: 1.5)
            userNameTextField.addBottomBorder(.yassyLight, height: 1.5)
            validityCardNumberTextField.addBottomBorder(.yassyLight, height: 1.5)
            cvvTextField.addBottomBorder(.yassyLight, height: 1.5)
            cardNumberTextField.layoutIfNeeded()
        }
    }
    
    @objc fileprivate func handleChaneCardUserBottom() {
        UIView.animate(withDuration: 0.01) { [self] in
            cardNumberTextField.addBottomBorder(.yassyLight, height: 1.5)
            userNameTextField.addBottomBorder(.yassyOrange, height: 1.5)
            validityCardNumberTextField.addBottomBorder(.yassyLight, height: 1.5)
            cvvTextField.addBottomBorder(.yassyLight, height: 1.5)
            userNameTextField.layoutIfNeeded()
        }
    }
    
    @objc fileprivate func handleChangeValidityBottom() {
        UIView.animate(withDuration: 0.01) { [self] in
            cardNumberTextField.addBottomBorder(.yassyLight, height: 1.5)
            userNameTextField.addBottomBorder(.yassyLight, height: 1.5)
            validityCardNumberTextField.addBottomBorder(.yassyOrange, height: 1.5)
            cvvTextField.addBottomBorder(.yassyLight, height: 1.5)
            validityCardNumberTextField.layoutIfNeeded()
        }
    }
    
    @objc fileprivate func handleChangeCVVBottom() {
        UIView.animate(withDuration: 0.01) { [self] in
            cardNumberTextField.addBottomBorder(.yassyLight, height: 1.5)
            userNameTextField.addBottomBorder(.yassyLight, height: 1.5)
            validityCardNumberTextField.addBottomBorder(.yassyLight, height: 1.5)
            cvvTextField.addBottomBorder(.yassyOrange, height: 1.5)
            cvvTextField.layoutIfNeeded()
        }
    }
    
    /// validation card TextFields
    @objc fileprivate func handleChangeValue() {
        let validate = ((cardNumberTextField.text!.count != 0) && (userNameTextField.text!.count != 0) && (validityCardNumberTextField.text!.count != 0) && (cvvTextField.text!.count != 0))
        switch validate {
        case (0 != 0):
            addCardButton.alpha = 0
        default:
            addCardButton.alpha = 1
        }
    }
    
    /// showMainPage
    @objc fileprivate func handleShowMainPage() {
        let vc =  OrderTaxiViewController(viewModel: MainViewModel(dataManager: DataManager()), isTaxiEmty: false)
        let view = FooterOrderView()
        view.completionHandler = { [self] text in
            cardNumberTextField.text = text
        }
        self.navigationController?.pushViewController(vc, animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func hanldeBackToOrderPage() {
        self.navigationController?.popViewController(animated: true)
    }
}
