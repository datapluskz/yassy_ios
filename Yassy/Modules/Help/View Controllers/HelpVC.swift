//
//  HelpVC.swift
//  Yassy
//
//  Created by Didar Bakhitzhanov on 03.05.2021.
//

import UIKit

class HelpVC: BaseViewController {
    
    let tableView = UITableView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSideMenu()
        setupViews()
    }
    
    fileprivate func setupViews(){
        title = "Помощь"
        view.backgroundColor = .white
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        tableView.setAnchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor,
                            bottom: view.bottomAnchor, right: view.rightAnchor,
                            paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        tableView.register(HelpCell.self, forCellReuseIdentifier: HelpCell.description())
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    

}

extension HelpVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TextConstants.helpArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HelpCell.description(), for: indexPath) as! HelpCell
        cell.generateCell(TextConstants.helpArray[indexPath.row])
        return cell
    }
    
    
}

extension HelpVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let navigationTitle = TextConstants.helpArray[indexPath.row]
        if indexPath.row == 0 {
            
            let vc = HelpDetailVC(descriptionText: TextConstants.firstDescription, navigationTitleText: navigationTitle, orangeTitle: "", id: 99, secondId: 99)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        if indexPath.row == 1 {
            let vc = HelpMoneyVC(id: 0, navigationTitle: navigationTitle, helpArray: TextConstants.moneyHelpArray)
            self.navigationController?.pushViewController(vc, animated: true)
        }

        if indexPath.row == 2 {
            let vc = HelpMoneyVC(id: 1, navigationTitle: navigationTitle, helpArray: TextConstants.complainArray)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        if indexPath.row == 3 {
            let vc = HelpMoneyVC(id: 2, navigationTitle: navigationTitle, helpArray: TextConstants.brokenArray)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
