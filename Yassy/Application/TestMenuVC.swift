//
//  TestMenuVC.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 5/22/21.
//

import UIKit

class TestMenuVC: UIViewController {
    
    
    lazy var homeVC = UINavigationController(rootViewController: HomeVC(viewModel: HomeViewModel(dataManager: DataManager()), addressViewModel: MainViewModel(dataManager: DataManager()), lat: 0, lng: 0))
    
    lazy var profileVC = UINavigationController(rootViewController: ProfileVC(viewModel: ProfileViewModel(apiService: ProfileDataManager())))
    
    lazy var favouritesVC = UINavigationController(rootViewController: FavouritesVC(viewModel: FavouritesViewModel(dataManager: FavouritesDataManager())))
    
    lazy var historyVC = UINavigationController(rootViewController: HistoryVC(viewModel: HistoryViewModel(apiService: HistoryDataManager())))
    
    lazy var helpsVC = UINavigationController(rootViewController: HelpVC())
    
    lazy var infoVC = UINavigationController(rootViewController: InfoVC())
    
    lazy var settingsVC = UINavigationController(rootViewController: SettingsVC())
    
    lazy var newsVC = UINavigationController(rootViewController: NewsVC(viewModel: NewsViewModel(dataManager: NewsDataManager())))
    
    lazy var paymentMethodsVC = UINavigationController(rootViewController: PaymentMethodsVC())
    
    var selectedVC = UIViewController()
    
    let tableView = UITableView(frame: .zero)
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.bounds.size.width, height: view.bounds.size.height)
    }

    fileprivate func setupViews(){
        view.backgroundColor = .white
        navigationController?.transparentNavigationController()
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        [MenuProfileCell.self, MenuItemsCell.self, LogoutCell.self].forEach { (cell) in
            tableView.register(cell, forCellReuseIdentifier: cell.description())
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "EmptyCell")
        tableView.dataSource = self
        tableView.delegate = self
    }

}

extension TestMenuVC: UITableViewDataSource {
    
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
            return 2
        default:
           return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: MenuProfileCell.description(), for: indexPath) as! MenuProfileCell
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
    
    
}

extension TestMenuVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
       
        if indexPath.section == 0 {
            let window = UIApplication.shared.windows[0] as UIWindow
            window.rootViewController = profileVC
            window.makeKeyAndVisible()
        }
        
        if indexPath.section == 1{
            let item = MenuOptions.allCases[indexPath.row]
            switch item {
            case .home:
                let window = UIApplication.shared.windows[0] as UIWindow
                window.rootViewController = homeVC
                window.makeKeyAndVisible()
            case .favourites:
                let window = UIApplication.shared.windows[0] as UIWindow
                window.rootViewController = favouritesVC
                window.makeKeyAndVisible()
            case .paymentMethods:
                let window = UIApplication.shared.windows[0] as UIWindow
                window.rootViewController = paymentMethodsVC
                window.makeKeyAndVisible()
            case .help:
                let window = UIApplication.shared.windows[0] as UIWindow
                window.rootViewController = helpsVC
                window.makeKeyAndVisible()
            case .history:
                let window = UIApplication.shared.windows[0] as UIWindow
                window.rootViewController = historyVC
                window.makeKeyAndVisible()
            case .settings:
                let window = UIApplication.shared.windows[0] as UIWindow
                window.rootViewController = settingsVC
                window.makeKeyAndVisible()
            case .news:
                let window = UIApplication.shared.windows[0] as UIWindow
                window.rootViewController = newsVC
                window.makeKeyAndVisible()
            case .info:
                let window = UIApplication.shared.windows[0] as UIWindow
                window.rootViewController = infoVC
                window.makeKeyAndVisible()
            }
        }
        
        if indexPath.section == 3 {
            let alert = addAlert()
            self.present(alert, animated: true, completion: nil)
        }
    }
}
