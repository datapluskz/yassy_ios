//
//  BusinessAccountFloatingPanel.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 6/12/21.
//

import UIKit
import SafariServices


class BusinessAccountFloatingPanel: UIViewController {
    
    let titleLabel = UILabel()
    let tableView = UITableView(frame: .zero)
    let createButton = UIButton(type: .system)
    var paymentMethodsArray: [PaymentMethods]?
    
    var isBusiness: Bool
    
    init(isBusiness: Bool){
        self.isBusiness = isBusiness
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews(){
        configureView()
        view.addSubview(titleLabel)
        
        
        titleLabel.setAnchor(top: view.topAnchor, left: view.leftAnchor,
                             bottom: nil, right: view.rightAnchor,
                             paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        if isBusiness {
            let business = BusinessAccountDefaults.getBusinessAccountData()
            let name = business.businessName
            let position = business.businessPosition
            let paymentMethodsArray = [PaymentMethods(title: name, imageName: "ic_work", isDifferent: false),
                                       PaymentMethods(title: position, imageName: "ic_profile", isDifferent: false)]
            self.paymentMethodsArray = paymentMethodsArray
            view.addSubview(tableView)
            tableView.setAnchor(top: titleLabel.bottomAnchor, left: view.leftAnchor,
                                bottom: view.bottomAnchor, right: view.rightAnchor,
                                paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
            setupTableView()
        } else {
            view.addSubview(createButton)
            createButton.setAnchor(top: titleLabel.bottomAnchor, left: view.leftAnchor,
                                   bottom: nil, right: view.rightAnchor, paddingTop: 40,
                                   paddingLeft: 24, paddingBottom: 0, paddingRight: 24, height: 50)
            createButton.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        }
        
    }
    
    private func configureView(){
        view.backgroundColor = .white
        titleLabel.text = "Бизнес аккаунт"
        titleLabel.font = .boldSystemFont(ofSize: 17)
        titleLabel.textAlignment = .center
        
        createButton.backgroundColor = .yassyOrange
        createButton.setTitle("Создать компанию", for: .normal)
        createButton.setTitleColor(.white, for: .normal)
        createButton.layer.cornerRadius = 8
        
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
    }
    
    
    private func setupTableView(){
        tableView.register(BussinesAccountCell.self, forCellReuseIdentifier: BussinesAccountCell.description())
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc func createButtonTapped(){
        let business_url = BusinessAccountDefaults.getBusinessAccountData().businessUrl
        if let url = URL(string: business_url) {
            let config = SFSafariViewController.Configuration()
            
            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
    
}

extension BusinessAccountFloatingPanel: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentMethodsArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: BussinesAccountCell.description(), for: indexPath) as! BussinesAccountCell
        if let model = paymentMethodsArray?[indexPath.row] {
            cell.generateCell(model)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
