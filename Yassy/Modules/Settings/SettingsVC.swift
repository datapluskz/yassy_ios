//
//  SettingsVC.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 5/23/21.
//

import UIKit

class SettingsVC: BaseViewController {
    
    let tableView = UITableView(frame: .zero)
    
    var settingsArray: [SettingsModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSideMenu()
        setupViews()
    }
    
    
    private func setupViews(){
        view.backgroundColor = .white
        title = "Настройки"
        setupTableView()
    }
    
    private func setupTableView(){
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.setAnchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        tableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.description())
        tableView.dataSource = self
        tableView.delegate = self
        generateSettingsArray()
    }
    
    private func generateSettingsArray(){
        let settingsArray = [SettingsModel(title: "Очистить кэш", isDifferent: true),
                             SettingsModel(title: "Язык приложения", isDifferent: false)]
        self.settingsArray = settingsArray
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension SettingsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.description(), for: indexPath) as! SettingsCell
        if let settings = settingsArray?[indexPath.row] {
            cell.generateCell(settings)
        }
        return cell
    }
    
    
}

extension SettingsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let alert = UIAlertController(title: "", message: "Загруженные фрагменты, карты будут удалены. При следующем использовании карта будет загружена заново", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Очистить", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Назад", style: .cancel, handler: nil))

            self.present(alert, animated: true)
        }
        if indexPath.row == 1 {
            let vc = SelectLanguageVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
