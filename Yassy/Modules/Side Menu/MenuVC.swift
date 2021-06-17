//
//  MenuVC.swift
//  Yassy
//
//  Created by Didar Bakhitzhanov on 03.05.2021.
//

import UIKit

protocol MenuVCDelegate: AnyObject {
    func didSelect(menuItem: MenuOptions)
    func didSelectLogout()
}

class MenuVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    weak var delegate: MenuVCDelegate?
    
   
    
    private let tableView: UITableView = {
        let tb = UITableView()
        tb.backgroundColor = nil
        tb.separatorStyle = .none
        return tb
    }()
    
    private let logOutButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .systemTeal
        btn.setTitle("Выйти", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    fileprivate func setupTableView(){
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(logOutButton)
        [MenuHeaderCell.self, MenuItemsCell.self, LogoutCell.self].forEach{
            tableView.register($0, forCellReuseIdentifier: $0.description())
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "EmptyCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.bounds.size.width, height: view.bounds.size.height)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return MenuOptions.allCases.count
        case 2:
            return 5
        default:
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: MenuHeaderCell.description(), for: indexPath) as! MenuHeaderCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: MenuItemsCell.description(), for: indexPath) as! MenuItemsCell
            cell.itemTitleLabel.text = MenuOptions.allCases[indexPath.row].rawValue
            cell.itemImageView.image = UIImage(named: MenuOptions.allCases[indexPath.row].imageName)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyCell", for: indexPath)
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: LogoutCell.description(), for: indexPath) as! LogoutCell
            return cell
        }
    }
    
    func addAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Вы действительно хотите выйти из приложения?", message: "", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Да, выйти", style: UIAlertAction.Style.default ) { _ in
            self.delegate?.didSelectLogout()
        })
        
        alert.addAction(UIAlertAction(title: "Нет", style: UIAlertAction.Style.cancel, handler: nil))
        return alert
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1{
            let item = MenuOptions.allCases[indexPath.row]
            print("Selected item is ", item)
            delegate?.didSelect(menuItem: item)
        }
        
        if indexPath.section == 3 {
            let alert = addAlert()
            self.present(alert, animated: true, completion: nil)
        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 2:
            return 50
        default:
            return UITableView.automaticDimension
        }
        
    }
  

}
