//
//  VerifySMSViewController.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 25.02.2021.
//

import UIKit

class VerifySMSViewController: UIViewController, SetupView {
    
    //MARK: - Properties
    private let logoImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subTitle = UILabel()
    private let smsCodeTextField = UITextField()
    private let verifySMSCodeButton = UIButton(type: .system)
    private let backButton = UIButton(type: .system)
    private let errorLabel = UILabel()
    lazy var otp = String()
    
    var dataManager: DataManager!
    var otps: String
    var mobile: String
    var email: String
    
    init(dataManager: DataManager, otp: String, mobile: String, email: String) {
        self.dataManager = dataManager
        self.otps = otp
        self.mobile = mobile
        self.email = email
        super.init(nibName: nil, bundle: nil)
    }
    
    
    //MARK: - StackView
    lazy var stackLabel: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            titleLabel,
            subTitle
        ])
        sv.axis = .vertical
        sv.spacing = 8
        return sv
    }()
    
    lazy var buttonStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            verifySMSCodeButton,
            backButton
        ])
        sv.axis = .vertical
        sv.spacing = 8
        return sv
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        print(Tokens.token)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupAction()
    }
    
    func setupView() {
        [logoImageView, stackLabel, smsCodeTextField, buttonStack, errorLabel].forEach {
            view.addSubview($0)
        }

        logoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 123, left: 0, bottom: 0, right: 0))
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        stackLabel.anchor(top: logoImageView.safeAreaLayoutGuide.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 80, left: 0, bottom: 0, right: 0))
        stackLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        smsCodeTextField.anchor(top: stackLabel.safeAreaLayoutGuide.bottomAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 75, left: 89, bottom: 0, right: 89))
        smsCodeTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonStack.anchor(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 40, bottom: 74, right: 40))
        errorLabel.anchor(top: smsCodeTextField.safeAreaLayoutGuide.bottomAnchor, leading: nil, bottom: nil, trailing: nil)
        errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        configureView()
        configureView()
    }
    
    func configureView() {
        smsCodeTextField.keyboardType = .numberPad
        configureNavigationBar(isHidden: true, backgroundColor: .clear, title: "")
        view.backgroundColor = .white
        logoImageView.configureImageView(image: #imageLiteral(resourceName: "logo").withRenderingMode(.alwaysOriginal), cornerRadius: 0, contentMode: .scaleAspectFill)
        logoImageView.configureSizeView(height: 80, width: 80)
        
        titleLabel.configureLabel(text: VERIFY_SMS_CODE_TITLE, textColor: .black, textAlignment: .center, fontName: "", fontSize: 24, numberOfLines: 0)
        subTitle.configureLabel(text: VERIFY_SMS_CODE_SUBTITLE, textColor: .black, textAlignment: .center, fontName: "", fontSize: 16, numberOfLines: 0)
        
        smsCodeTextField.configureTextField(placeholder: "XXXXX", cornerRadius: 0, textColor: .gray, font: Fonts.appleFont, fontSize: 24, height: 40, textAlignment: .center)
        verifySMSCodeButton.configureButton(title: VERIFY_SMS_CODE_BUTTON_STRING, titleColor: .white, isEnabled: false, cornerRadius: 10, borderWidth: 0, borderColor: UIColor.clear.cgColor, height: 50, backgroundColor: .yassyLight)
        backButton.configureButton(title: VERIFY_SMS_CODE_BACK_BUTTON_STR, titleColor: .white, isEnabled: true, cornerRadius: 10, borderWidth: 0, borderColor: UIColor.clear.cgColor, height: 50, backgroundColor: .yassyOrange)
        errorLabel.configureLabel(text: SMSCODE_ERROR_LABEL, textColor: .red, textAlignment: .center, fontName: Fonts.appleFont, fontSize: 16, numberOfLines: 0)
        errorLabel.alpha = 0
    }
    
    func setupAction() {
        verifySMSCodeButton.addTarget(self, action: #selector(handleSendSMS), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(handleBackToPhonePage), for: .touchUpInside)
        smsCodeTextField.addTarget(self, action: #selector(handleEnableButton), for: .allEditingEvents)
    }
    
//    @objc fileprivate func handleSendSMS() {
//        if smsCodeTextField.text != otp {
//            errorLabel.alpha = 1
//
//        } else {
//            let vc = ContainerVC()
//            dataManager.verifySMSCode(otp: otps, mobile: mobile, email: email) { (data) in
//                print(data.access_token ?? "")
//            }
//
//            self.dataManager.callingProfileData { (profileModel) in
//                ProfileDataDefaults.save(name: profileModel.first_name, phone: profileModel.mobile, image: profileModel.picture ?? "")
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
//            UserDefaults.standard.setValue(result.access_token, forKey: Tokens.token)
//        }
//    }
    
    @objc fileprivate func handleSendSMS() {
        if smsCodeTextField.text != otp {
            errorLabel.alpha = 1
        } else {
            let navigationController = UINavigationController(rootViewController: HomeVC(viewModel: HomeViewModel(dataManager: DataManager()), addressViewModel: MainViewModel(dataManager: DataManager()), lat: 0, lng: 0))
            navigationController.modalPresentationStyle = .fullScreen
            dataManager.verifySMSCode(otp: otps, mobile: mobile, email: email) { (data, isSuccess) in
                if isSuccess {
                    UserDefaults.standard.setValue(data.access_token, forKey: Tokens.token)
                    DispatchQueue.global().asyncAfter(deadline: .now() + 0.3) {
                        self.dataManager.callingProfileData { (profileModel) in
                            ProfileDataDefaults.save(name: profileModel.first_name, phone: profileModel.mobile, image: profileModel.picture ?? "")
                   
                            BusinessAccountDefaults.save(isBusiness: profileModel.is_business ?? "", businessName: profileModel.business_name ?? "", businessPosition: profileModel.business_position ?? "", businessUrl: profileModel.business_url ?? "")
                          
                            self.dataManager.callingFavouriteAddresses { (addresses) in
                                if addresses.home.isEmpty {
                                    HomeAddressDefaults.saveHomeAddress(address: "", latitude: "", longitude: "")
                                } else {
                                    let address = addresses.home.first?.address
                                    let latitude = String(addresses.home.first?.latitude ?? 0.0)
                                    let longitude = String(addresses.home.first?.longitude ?? 0.0)
                                    HomeAddressDefaults.saveHomeAddress(address: address ?? "", latitude: latitude, longitude: longitude)
                                }
                                
                                if addresses.work.isEmpty {
                                    print("Нету рабочего адреса")
                                    WorkAddressDefaults.saveWorkAddress(address: "", latitude: "", longitude: "")
                                } else {
                                    let address = addresses.work.first?.address
                                    let latitude = String(addresses.work.first?.latitude ?? 0.0)
                                    let longitude = String(addresses.work.first?.longitude ?? 0.0)
                                    WorkAddressDefaults.saveWorkAddress(address: address ?? "", latitude: latitude, longitude: longitude)
                                }
                                self.present(navigationController, animated: true, completion: nil)
                            }
                        }
                          
                    }
                }
            }
        }
    }
    
    @objc fileprivate func handleEnableButton() {
        switch smsCodeTextField.text {
        case "":
            UIView.animate(withDuration: 0.5){
                self.verifySMSCodeButton.backgroundColor = .yassyLight
                self.verifySMSCodeButton.isEnabled       = false
            }
        default:
            UIView.animate(withDuration: 0.5){
                self.verifySMSCodeButton.isEnabled       = true
                self.verifySMSCodeButton.backgroundColor = .yassyOrange
            }
        }
    }
    
    @objc fileprivate func handleBackToPhonePage() {
        if let navController = self.navigationController {
            navController.popToRootViewController(animated: true)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
