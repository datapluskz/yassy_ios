//
//  ProfileVC.swift
//  Yassy
//
//  Created by Didar Bakhitzhanov on 03.05.2021.
//

import UIKit

protocol ProfileViewModelInput: AnyObject {
    func updateProfileImage(image: UIImage)
    func reloadProfileData()
}

class ProfileVC: BaseViewController {
    
    lazy var tableView = UITableView(frame: .zero)
    
    let logoutButton = UIButton(type: .system)
    
    var viewModel: ProfileViewModel
    
    weak var viewModelInput: ProfileViewModelInput?
    
    init(viewModel: ProfileViewModel){
        self.viewModel = viewModel
        self.viewModelInput = self.viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSideMenu()
        setupViews()
        callingViewModelForUIUpdate()
        callingViewModelForProfileUIUpdate()
    }
    
    fileprivate func setupViews(){
        title = "Профиль"
        view.backgroundColor = .white
        configureViews()
        view.addSubview(tableView)
        view.addSubview(logoutButton)
        tableView.setAnchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor,
                            bottom: view.bottomAnchor, right: view.rightAnchor,
                            paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        logoutButton.setAnchor(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 50)
        [ProfilePhotoCell.self, ProfileInfoCell.self].forEach { (cell) in
            tableView.register(cell, forCellReuseIdentifier: cell.description())
        }
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    private func configureViews(){
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        logoutButton.setTitle("Выйти из аккаунта", for: .normal)
        logoutButton.titleLabel?.font = .systemFont(ofSize: 16)
        logoutButton.titleLabel?.textAlignment = .left
        logoutButton.setTitleColor(.black, for: .normal)
        logoutButton.buttonLeftImagee(image: UIImage(named: "ic_logout")!, renderMode: .alwaysOriginal)
        logoutButton.buttonTitlePadding(top: 0, left: 40, bottom: 0, right: 0)
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }
    
    func callingViewModelForUIUpdate(){
        viewModel.bindProfileDataToController = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func callingViewModelForProfileUIUpdate(){
        viewModel.bindProfileImageToController = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func addAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Вы действительно хотите выйти из приложения?", message: "", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Да, выйти", style: UIAlertAction.Style.default ) { _ in
            UserDefaults.standard.removeObject(forKey: Tokens.token)
            ProfileDataDefaults.clearProfileData()
            let vc = UINavigationController(rootViewController: SplashScreenViewController())
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        })
        
        alert.addAction(UIAlertAction(title: "Нет", style: UIAlertAction.Style.cancel, handler: nil))
        return alert
    }
    
    @objc func logoutButtonTapped(){
        let alert = addAlert()
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension ProfileVC: UploadProfileImageProtocol {
    
    func updateProfileImage(image: UIImage) {
        viewModelInput?.updateProfileImage(image: image)
    }
    
    
}

extension ProfileVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return viewModel.profileData?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ProfilePhotoCell.description(), for: indexPath) as! ProfilePhotoCell
            cell.viewController = self
            cell.delegate = self
            if let image = viewModel.profileImage {
                cell.generateCell(imageURL: image)
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ProfileInfoCell.description(), for: indexPath) as! ProfileInfoCell
            if let profileData = viewModel.profileData?[indexPath.row]{
                cell.generateCell(profileData)
            }
            return cell
        }
        
    }
    
    
}

extension ProfileVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                let vc = ChangeUserNameVC(viewModel: ChangeUserNameViewModel(apiService: ProfileDataManager()))
                vc.changeCompletion = { (isSuccess) in
                    if isSuccess {
                        self.viewModelInput?.reloadProfileData()
                    }
                }
                self.navigationController?.pushViewController(vc, animated: true)
            case 1:
                break
            default:
                let vc = ChangeEmailVC(viewModel: ChangeEmailViewModel(apiService: ProfileDataManager()))
                vc.changeCompletion = { (isSuccess) in
                    if isSuccess {
                        self.viewModelInput?.reloadProfileData()
                    }
                }
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
