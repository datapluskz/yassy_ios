//
//  SearcTaxiFloatingPanel.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 29.04.2021.
//

import UIKit
import FloatingPanel

class SearchTaxiFloatingPanel: UIViewController {
    
    var check: ((Bool) -> ())?
    let timeLabel = UILabel()
    let carMarkLabel = UILabel()
    let callButton = UIButton(type: .system)
    lazy var stringTime = String()
    let callLabel = UILabel()
    let messageButton = SSBadgeButton()
    lazy var isgoButton = UIButton(type: .system)
    let messageLabel = UILabel()
    let addressID = "addressID"
    let showLocationID = "showLocationID"
    let paymentID = "paymentID"
    let detailID = "detailID"
    let addressString = String()
    let userAddress = UILabel()
    var waitingTime = String()
    let closeButton = UIButton(type: .system)
    let addAddressButton = UIButton(type: .system)
    var showDetailView: ((Bool) -> ())?
    
    let startedTableView: UITableView = {
        let tb = UITableView(frame: .zero, style: .plain)
        return tb
    }()
    
    lazy var stackLabel: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            timeLabel,
            carMarkLabel
        ])
        sv.axis = .vertical
        sv.spacing = 8
        return sv
    }()
    
    lazy var stackButton: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            callButton,
            messageButton,
            isgoButton
        ])
        sv.axis = .horizontal
        sv.spacing = 20
        return sv
    }()
    
    let updateData = [
        ConfigureStartedStatus(name: AddressInformation.d_address, icon: #imageLiteral(resourceName: "orange-point"), subString: ""),
        ConfigureStartedStatus(name: "Наличные", icon: #imageLiteral(resourceName: "colored"), subString: "Изменить способ оплаты"),
        ConfigureStartedStatus(name: "Детали заказа", icon: #imageLiteral(resourceName: "Group 17"), subString: "Ваш тариф 400 ₸ ")
        
    ]
    
    lazy var stackCloseButton: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            closeButton,
            addAddressButton
        ])
        sv.axis = .horizontal
        sv.spacing = 16
        sv.distribution = .fillEqually
        return sv
    }()
    //var check = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        view.backgroundColor = .white
        configureNavigationBar(isHidden: true, backgroundColor: .clear, title: "")
        setupLayouts()
    }
    
    private func setupLayouts() {
        setupView()
        setupTableView()
        configureLayoutView()
    }
    
    fileprivate func setupView() {
        [stackLabel, stackButton,startedTableView, stackCloseButton].forEach {
            view.addSubview($0)
        }
        stackLabel.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 20, left: 0, bottom: 0, right: 0))
        stackLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        stackButton.anchor(top: stackLabel.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 16, left: 0, bottom: 0, right: 0))
        stackButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        

        [callButton, messageButton, isgoButton].forEach { size in
            size.widthAnchor.constraint(equalToConstant: 50).isActive = true
        }
        
        stackCloseButton.anchor(top: startedTableView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 32, bottom: 0, right: 32))
    }
    
    fileprivate func configureLayoutView() {
        setupView()
        waitingTime = "5"
        let attributedTime = NSMutableAttributedString(string: waitingTime)
        let range = (waitingTime as NSString).range(of: "6")
        attributedTime.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.yassyOrange, range: range)
        timeLabel.configureLabel(text: "Приедет через \(waitingTime) минут", textColor: .black, textAlignment: .center, fontName: Fonts.appleFont, fontSize: 23, numberOfLines: 0)
        carMarkLabel.configureLabel(text: "", textColor: .gray, textAlignment: .center, fontName: Fonts.regular, fontSize: 18, numberOfLines: 0)
        callButton.configureButton(title: "", titleColor: .clear, isEnabled: true, cornerRadius: 8, borderWidth: 0, borderColor: UIColor.clear.cgColor, height: 50, backgroundColor: .white)
        isgoButton.configureButton(title: "", titleColor: .clear, isEnabled: false, cornerRadius: 8, borderWidth: 0, borderColor: UIColor.clear.cgColor, height: 50, backgroundColor: .white)
        messageButton.configureButton(title: "", titleColor: .clear, isEnabled: true, cornerRadius: 8, borderWidth: 0, borderColor: UIColor.clear.cgColor, height: 50, backgroundColor: .white)
        closeButton.configureButton(title: "Отменить", titleColor: .black, isEnabled: true, cornerRadius: 8, borderWidth: 0, borderColor: UIColor.clear.cgColor, height: 50, backgroundColor: .white)
        addAddressButton.configureButton(title: "Вызвать ещё", titleColor: .lightGray, isEnabled: true, cornerRadius: 8, borderWidth: 0, borderColor: UIColor.clear.cgColor, height: 50, backgroundColor: .white)
        addAddressButton.addTarget(self, action: #selector(addAddressBtnTapped), for: .touchUpInside)
        closeButton.buttonLeftImages(image: #imageLiteral(resourceName: "cancel_icon"), renderMode: .alwaysOriginal)
        addAddressButton.buttonLeftImages(image: #imageLiteral(resourceName: "ic_add_medium").withTintColor(.lightGray), renderMode: .alwaysOriginal)
        closeButton.contentHorizontalAlignment = .center
        addAddressButton.contentHorizontalAlignment = .center
        closeButton.setCellShadowTwo()
        closeButton.tintColor = .yassyLight
        addAddressButton.setCellShadowTwo()
        
        /// imageForButton
        callButton.setImage(#imageLiteral(resourceName: "ic_call").withRenderingMode(.alwaysOriginal), for: .normal)
        callButton.tintColor = .yassyOrange
        isgoButton.setImage(#imageLiteral(resourceName: "ic_walk"), for: .normal)
        messageButton.setImage(#imageLiteral(resourceName: "ic_chat").withRenderingMode(.alwaysOriginal), for: .normal)
        isgoButton.setCellShadowTwo()
        callButton.setCellShadowTwo()
        messageButton.setCellShadowTwo()
    }
    
    @objc func addAddressBtnTapped(){
        showAlert(alertString: "Этот раздел временно не доступен")
    }
    
    fileprivate func setupTableView() {
        startedTableView.backgroundColor = .white
        startedTableView.delegate = self
        startedTableView.dataSource = self
        startedTableView.register(AddressTableViewCell.self, forCellReuseIdentifier: addressID)
        startedTableView.anchor(top: stackButton.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 4, left: 0, bottom: 0, right: 0))
        startedTableView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
}
