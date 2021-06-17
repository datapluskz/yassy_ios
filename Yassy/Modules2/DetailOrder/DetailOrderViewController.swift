//
//  DetailOrderViewController.swift
//  OrangeTaxi
//
//  Created by Tanirbergen Kaldibai on 31.05.2021.
//

import UIKit

class DetailOrderViewController: UIViewController {
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.setImage(#imageLiteral(resourceName: "ic_back-1").withRenderingMode(.alwaysOriginal), for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        button.setCellShadowTwo()
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Детали заказа"
        label.font = UIFont(name: Fonts.appleFont, size: 24)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    lazy var detailTableView: UITableView = {
        let tb = UITableView(frame: .zero, style: .plain)
        return tb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayouts()
        configureDetailTableView()
        setupDetailTableView()
    }
    
    private func setupLayouts() {
        [backButton, titleLabel].forEach {
            view.addSubview($0)
        }
        
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: nil, bottom: nil, trailing: nil)
        titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func configureVC() {
        configureNavigationBar(isHidden: true, backgroundColor: UIColor.clear, title: "")
        view.backgroundColor = .white
    }

    private func configureDetailTableView() {
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.register(DriverTableViewCell.self, forCellReuseIdentifier: DetailKeys.DRIVER_ID)
        detailTableView.register(RouteTableViewCell.self, forCellReuseIdentifier: DetailKeys.ROUTE_ID)
        detailTableView.register(TimeTableViewCell.self, forCellReuseIdentifier: DetailKeys.TIME_ID)
        detailTableView.register(RateTableViewCell.self, forCellReuseIdentifier: DetailKeys.RATE_ID)
        detailTableView.register(PaymentMethodCell.self, forCellReuseIdentifier: DetailKeys.PAYMENT_ID)
        detailTableView.backgroundColor = .white
    }
    
    private func setupDetailTableView() {
        view.addSubview(detailTableView)
        detailTableView.anchor(top: titleLabel.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 40, left: 20, bottom: 0, right: 20))
    }
    
    // MARK: - Targets
    @objc fileprivate func handleBack() {
        dismiss(animated: true, completion: nil)
    }
}
