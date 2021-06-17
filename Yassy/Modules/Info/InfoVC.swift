//
//  InfoVC.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 6/3/21.
//

import UIKit

class InfoVC: BaseViewController {
    
    let tableView = UITableView(frame: .zero)
    
    var infoArray: [String]?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSideMenu()
        setupViews()
    }
    

    private func setupViews(){
        view.backgroundColor = .white
        title = "Информация"
        setupTableView()
    }
    
    private func setupTableView(){
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.setAnchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor,
                            bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        [InfoLogoCell.self, InfoCell.self, InfoFooterCell.self].forEach { (cell) in
            tableView.register(cell, forCellReuseIdentifier: cell.description())
        }
        tableView.dataSource = self
        tableView.delegate = self
        generateInfoArray()
    }
    
    private func generateInfoArray(){
        let infoArray = ["О Приложении","Пользовательское соглашения","Политика конфеденциальности"]
        self.infoArray = infoArray
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}

extension InfoVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            return infoArray?.count ?? 0
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: InfoLogoCell.description(), for: indexPath) as! InfoLogoCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: InfoCell.description(), for: indexPath) as! InfoCell
            if let model = infoArray?[indexPath.row]{
                cell.generateCell(model)
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: InfoFooterCell.description(), for: indexPath) as! InfoFooterCell
            return cell
        }
    }
    
    
}

extension InfoVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1{
            if let title = infoArray?[indexPath.row] {
                let vc = InfoDetailVC(navigationTitle: title)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
