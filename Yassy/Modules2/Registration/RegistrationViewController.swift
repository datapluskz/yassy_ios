//
//  RegistrationViewController.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 25.02.2021.
//

import UIKit
import CountryPickerView

class RegistrationViewController: UIViewController, SetupView {
  
    
     
    // MARK: - Properties
    private let logoImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subTitle = UILabel()
    private let phoneNumberTextFeild = CustomPhoneTextField(placeHolder: "XXX XXX XX XX")
    private let sendSMSButton = UIButton(type: .system)
    lazy var countryCode = String()
    lazy var phoneNumber = String()
    let countryPickerView = CountryPickerView(frame: .zero)
    
    // MARK: - StackView
    lazy var stackLabel: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            titleLabel,
            subTitle
        ])
        sv.axis = .vertical
        sv.spacing = 8
        return sv
    }()
    
    // injection
    var dataManager: DataManager!
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar(isHidden: true, backgroundColor: .clear, title: "")
    }
    
    // MARK: - Methods
    func setupView() {
        
        configureView()
        setupAction()
        
        [logoImageView, stackLabel, phoneNumberTextFeild, sendSMSButton, countryPickerView].forEach {
            view.addSubview($0)
        }

        logoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 123, left: 0, bottom: 0, right: 0))
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        stackLabel.anchor(top: logoImageView.safeAreaLayoutGuide.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 80, left: 0, bottom: 0, right: 0))
        stackLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        countryPickerView.setAnchor(top: stackLabel.safeAreaLayoutGuide.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 75, paddingLeft: 52, paddingBottom: 0, paddingRight: 0, width: 90 ,height: 50)
        phoneNumberTextFeild.setAnchor(top: stackLabel.safeAreaLayoutGuide.bottomAnchor, left: countryPickerView.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 75, paddingLeft: 0, paddingBottom: 0, paddingRight: 52)
       

        sendSMSButton.anchor(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 40, bottom: 74, right: 40))
      
       
    }
    
    func configureView() {
        view.backgroundColor = .white
        logoImageView.configureImageView(image: #imageLiteral(resourceName: "logo-1").withRenderingMode(.alwaysOriginal), cornerRadius: 0, contentMode: .scaleAspectFill)
        logoImageView.configureSizeView(height: 80, width: 80)
        
        titleLabel.configureLabel(text: REGISTRATION_PAGE_TITLE, textColor: .black, textAlignment: .center, fontName: "", fontSize: 24, numberOfLines: 0)
        subTitle.configureLabel(text: REGISTRATION_PAGE_SUBTITLE, textColor: .black, textAlignment: .center, fontName: "", fontSize: 16, numberOfLines: 0)
        
        phoneNumberTextFeild.keyboardType = .numberPad

        countryPickerView.showCountryCodeInView = false
        countryPickerView.delegate = self
        countryPickerView.dataSource = self
        countryPickerView.font = .systemFont(ofSize: 24)
        countryPickerView.setCountryByCode("KZ")
        sendSMSButton.configureButton(title: REGISTRATION_PAGE_BUTTON_STRING, titleColor: .white, isEnabled: true, cornerRadius: 10, borderWidth: 0, borderColor: UIColor.clear.cgColor, height: 50, backgroundColor: .yassyOrange)
        
      
    }
    
    func setupAction() {
        sendSMSButton.addTarget(self, action: #selector(handleSendSMS), for: .touchUpInside)
    }
    
    @objc fileprivate func handleSendSMS() {
        
        var countryCode = countryPickerView.selectedCountry.phoneCode

        guard let phoneNumber = phoneNumberTextFeild.text else { return }
        
        if phoneNumber.isEmpty {
            showAlert(alertString: "Введите пожалуйста номер телефона")
        } else {
            countryCode.removeFirst()
            dataManager.getSMSCode(mobile: phoneNumber, country: countryCode) { data in
                let vc = VerifySMSViewController(dataManager: DataManager(), otp: data.otp!, mobile: data.mobile!, email: data.mobile!)
                vc.otp = data.otp ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
                self.setupLoading(timer: 2, centerY: 0)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension RegistrationViewController: CountryPickerViewDelegate, CountryPickerViewDataSource {
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        print(country)
    }
    
    func countryPickerView(_ countryPickerView: CountryPickerView, willShow viewController: CountryPickerViewController){
        configureNavigationBar(isHidden: false, backgroundColor: .clear, title: "")
    }
    
    func localeForCountryNameInList(in countryPickerView: CountryPickerView) -> Locale {
        return Locale(identifier: Locale.current.languageCode ?? "ru")
    }

}

//        phoneNumberTextFeild.anchor(top: stackLabel.safeAreaLayoutGuide.bottomAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 75, left: 89, bottom: 0, right: 89))
//
//        phoneNumberTextFeild.textAlignment = .center
//        phoneNumberTextFeild.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        countryPickerView.setAnchor(top: stackLabel.safeAreaLayoutGuide.bottomAnchor, left: nil, bottom: nil, right: phoneNumberTextFeild.leftAnchor, paddingTop: 75, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 80, height: 50)


//        phoneNumberTextFeild.configureTextField(placeholder: "+7 XXX XXX XXX", cornerRadius: 0, textColor: .gray, font: Fonts.appleFont, fontSize: 24, height: 40, textAlignment: .center)
//
//        phoneNumberTextFeild.backgroundColor = .systemTeal
