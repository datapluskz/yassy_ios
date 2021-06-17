//
//  DetailDataSource.swift
//  OrangeTaxi
//
//  Created by Tanirbergen Kaldibai on 31.05.2021.
//

import UIKit

extension DetailOrderViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .white
        tableView.allowsSelection = false
        switch indexPath.item {
        case 0:
            return tableView.dequeueReusableCell(withIdentifier: DetailKeys.DRIVER_ID, for: indexPath) as! DriverTableViewCell
        case 1:
            return tableView.dequeueReusableCell(withIdentifier: DetailKeys.ROUTE_ID, for: indexPath) as! RouteTableViewCell
        case 2:
            return tableView.dequeueReusableCell(withIdentifier: DetailKeys.TIME_ID, for: indexPath) as! TimeTableViewCell
        case 3:
            return tableView.dequeueReusableCell(withIdentifier: DetailKeys.RATE_ID, for: indexPath) as! RateTableViewCell
        case 4:
            return tableView.dequeueReusableCell(withIdentifier: DetailKeys.PAYMENT_ID, for: indexPath) as! PaymentMethodCell
        default:
            return tableView.dequeueReusableCell(withIdentifier: DetailKeys.DRIVER_ID, for: indexPath) as! DriverTableViewCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
