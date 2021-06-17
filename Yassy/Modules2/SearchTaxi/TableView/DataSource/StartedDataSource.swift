//
//  StartedDataSource.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 04.05.2021.
//

import UIKit

extension SearchTaxiFloatingPanel: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.backgroundColor = .white
        let cell = tableView.dequeueReusableCell(withIdentifier: addressID, for: indexPath) as! AddressTableViewCell
        switch indexPath.item {
        case 1:
            let business = BusinessAccountDefaults.getBusinessAccountData().isBusiness
            if business == "0" {
                cell.addressLabel.text = "Наличные"
                cell.addressIcon.image = #imageLiteral(resourceName: "Group 239").withRenderingMode(.alwaysOriginal)
            } else {
                cell.addressLabel.text = "Бизнес аккаунт"
                cell.addressIcon.image = #imageLiteral(resourceName: "ic_work").withTintColor(.yassyLight, renderingMode: .alwaysOriginal)
            }
           
        case 2:
            cell.addressLabel.text = "Детали заказа"
            cell.addressIcon.image = #imageLiteral(resourceName: "Group 17").withRenderingMode(.alwaysOriginal)
        default:
            cell.addressLabel.text = AddressInformation.d_address
            cell.addressIcon.image = #imageLiteral(resourceName: "orange-point").withRenderingMode(.alwaysOriginal)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.item == 2 {
            let vc = UINavigationController(rootViewController: DetailOrderViewController())
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            check?(true)
        }
    }
}
