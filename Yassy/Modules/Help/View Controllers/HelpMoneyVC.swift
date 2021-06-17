//
//  HelpMoneyVC.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 15.05.2021.
//

import UIKit

class HelpMoneyVC: UIViewController {

    let tableView = UITableView(frame: .zero)
    
    var id: Int
    
    var navigationTitle: String
    
    var helpArray: [String]
    
    init(id: Int, navigationTitle: String, helpArray: [String]){
        self.id = id
        self.navigationTitle = navigationTitle
        self.helpArray = helpArray
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    fileprivate func setupViews(){
        view.backgroundColor = .white
        setupNavigationBar()
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        tableView.setAnchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor,
                            bottom: view.bottomAnchor, right: view.rightAnchor,
                            paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        tableView.register(HelpCell.self, forCellReuseIdentifier: HelpCell.description())
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupNavigationBar(){
        navigationItem.title = navigationTitle
        navigationItem.leftBarButtonItem = self.navigationController?.addBackButton()
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }

}

extension HelpMoneyVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return helpArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HelpCell.description(), for: indexPath) as! HelpCell
        cell.generateCell(helpArray[indexPath.row])
        return cell
    }
    
    
}

extension HelpMoneyVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        
        if id == 0 {
            let navigationTitle = TextConstants.moneyHelpArray[indexPath.row]
            if indexPath.row == 0 {
                let vc = HelpDetailVC(descriptionText: TextConstants.moneyFirstDescription, navigationTitleText: navigationTitle, orangeTitle: "", id: id, secondId: 99)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            if indexPath.row == 1 {
                let vc = HelpDetailVC(descriptionText: TextConstants.moneySecondDescription, navigationTitleText: navigationTitle, orangeTitle: "", id: id, secondId: 99)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            if indexPath.row == 2 {
                let vc = HelpDetailVC(descriptionText: TextConstants.moneyThirdDescription, navigationTitleText: navigationTitle, orangeTitle: "", id: id, secondId: 99)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            if indexPath.row == 3 {
                let vc = HelpDetailVC(descriptionText: TextConstants.moneyFourthDescription, navigationTitleText: navigationTitle, orangeTitle: "", id: id, secondId: 99)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            if indexPath.row == 4 {
                let vc = HelpDetailVC(descriptionText: TextConstants.moneyFifthDescription, navigationTitleText: navigationTitle, orangeTitle: "", id: id, secondId: 99)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        if id == 1 {
            let navigationTitle = TextConstants.complainArray[indexPath.row]
            if indexPath.row == 0 {
                let vc = HelpDetailVC(descriptionText: TextConstants.complainFirstDescription, navigationTitleText: navigationTitle, orangeTitle: "", id: id, secondId: 99)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.row == 1 {
                let vc = HelpDetailVC(descriptionText: TextConstants.complainSecondDescription, navigationTitleText: navigationTitle, orangeTitle: "", id: id, secondId: 99)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.row == 2 {
                let vc = HelpDetailVC(descriptionText: TextConstants.complainThirdDescription, navigationTitleText: navigationTitle, orangeTitle: "", id: id, secondId: 99)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        if id == 2 {
            let navigationTitle = TextConstants.brokenArray[indexPath.row]
            if indexPath.row == 0 {
                let vc = HelpDetailVC(descriptionText: TextConstants.brokenFirstDescription, navigationTitleText: navigationTitle, orangeTitle: TextConstants.brokenFirstTitle, id: id, secondId: 0)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            if indexPath.row == 1 {
                let vc = HelpDetailVC(descriptionText: TextConstants.brokenSecondDescription, navigationTitleText: navigationTitle, orangeTitle: TextConstants.brokenSecondTitle, id: id, secondId: 1)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            if indexPath.row == 2 {
                let vc = HelpDetailVC(descriptionText: TextConstants.brokenThirdDescription, navigationTitleText: navigationTitle, orangeTitle: TextConstants.brokenThirdTitle, id: id, secondId: 2)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            if indexPath.row == 3 {
                let vc = HelpDetailVC(descriptionText: TextConstants.brokenFourthDescription, navigationTitleText: navigationTitle, orangeTitle: "", id: id, secondId: 99)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
      
    }
}

