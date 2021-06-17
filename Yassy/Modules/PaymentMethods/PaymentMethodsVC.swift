//
//  PaymentMethodsVC.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 6/3/21.
//

import UIKit
import FloatingPanel

class PaymentMethodsVC: BaseViewController {
    
    var paymentMethodsArray: [PaymentMethods]?
    
    let tableView = UITableView(frame: .zero)
    
    var fpc: FloatingPanelController!
    
    var contentVC: BusinessAccountFloatingPanel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSideMenu()
        setupViews()
    }
    
    private func setupViews(){
        view.backgroundColor = .white
        title = "Способы оплаты"
        setupTableView()
    }

    private func setupTableView(){
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.setAnchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor,
                            bottom: view.bottomAnchor, right: view.rightAnchor,
                            paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        [PaymentMethodsTVCell.self, AddCardCell.self].forEach { (cell) in
            tableView.register(cell, forCellReuseIdentifier: cell.description())
        }
        tableView.dataSource = self
        tableView.delegate = self
        generatePaymentMethodsArray()
        configureFloatingPanel()
    }
   
    private func generatePaymentMethodsArray() {
        let paymentMethodsArray = [PaymentMethods(title: "Наличные", imageName: "ic_payment", isDifferent: false),
                                   PaymentMethods(title: "Бизнес аккаунт", imageName: "ic_work", isDifferent: true)]
        self.paymentMethodsArray = paymentMethodsArray
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func configureFloatingPanel() {
        let business = BusinessAccountDefaults.getBusinessAccountData().isBusiness
        if business == "0" {
            contentVC = BusinessAccountFloatingPanel(isBusiness: false)
        } else {
            contentVC = BusinessAccountFloatingPanel(isBusiness: true)
        }
        fpc = FloatingPanelController()
        fpc.delegate = self
        fpc.isRemovalInteractionEnabled = true
        fpc.layout = CustomFloatingPanelLayout()
        let appearance = SurfaceAppearance()
        appearance.cornerRadius = 20.0
        fpc.surfaceView.appearance = appearance
    }
    
    func setupFloatingPanel(){
        fpc.set(contentViewController: contentVC)
        fpc.addPanel(toParent: self)
        fpc.backdropView.dismissalTapGestureRecognizer.isEnabled = true
    }

}

extension PaymentMethodsVC: FloatingPanelControllerDelegate {
    
}

extension PaymentMethodsVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return paymentMethodsArray?.count ?? 0
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: PaymentMethodsTVCell.description(), for: indexPath) as! PaymentMethodsTVCell
            if let payment = paymentMethodsArray?[indexPath.row] {
                cell.generateCell(paymentMethods: payment)
            }
            
            let business = BusinessAccountDefaults.getBusinessAccountData().isBusiness
            
            print("Business is", business)
            if business == "0" {
                if indexPath.row == 0 {
                    cell.tickImageView.isHidden = false
                    cell.titleLabel.textColor = .black
                }
                if indexPath.row == 1 {
                    cell.tickImageView.isHidden = true
                    cell.titleLabel.textColor = .lightGray
                }
            } else {
                if indexPath.row == 0 {
                    cell.tickImageView.isHidden = true
                    cell.titleLabel.textColor = .lightGray
                }
                if indexPath.row == 1 {
                    cell.tickImageView.isHidden = false
                    cell.titleLabel.textColor = .black
                }
            }
           
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: AddCardCell.description(), for: indexPath) as! AddCardCell
            return cell
        }
    }
    
    
}

extension PaymentMethodsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            setupFloatingPanel()
        }
    }
}
