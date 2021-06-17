//
//  SelectLanguageVC.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 6/4/21.
//

import UIKit

class SelectLanguageVC: UIViewController {
    
    var languagesArray: [PaymentMethods]?
    
    let tableView = UITableView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews(){
        view.backgroundColor = .white
        setupNavigationBar()
        setupTableView()
    }
    
    
    private func setupNavigationBar(){
        title = "Язык приложения"
        navigationItem.leftBarButtonItem = navigationController?.addBackButton()
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    private func setupTableView(){
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.setAnchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        tableView.register(SelectLanguageCell.self, forCellReuseIdentifier: SelectLanguageCell.description())
        tableView.dataSource = self
        tableView.delegate = self
        generateLanguagesArray()
    }
   
    private func generateLanguagesArray() {
        let languagesArray = [PaymentMethods(title: "Қазақ тілі", imageName: "KZ", isDifferent: true),
                              PaymentMethods(title: "Русский язык", imageName: "RU", isDifferent: false)]
        self.languagesArray = languagesArray
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}

extension SelectLanguageVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languagesArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectLanguageCell.description(), for: indexPath) as! SelectLanguageCell
        if let model = languagesArray?[indexPath.row]{
            cell.generateCell(model)
        }
        return cell
    }
    
    
}

extension SelectLanguageVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

