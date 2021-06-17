//
//  ContainerVC.swift
//  Yassy
//
//  Created by Didar Bakhitzhanov on 03.05.2021.
//

import UIKit

enum MenuState {
    case opened
    case closed
}

class ContainerVC: UIViewController {
    
    private var menuState: MenuState = .closed
    
    let menuVC = MenuVC()
    let homeVC = HomeVC(viewModel: HomeViewModel(dataManager: DataManager()), addressViewModel: MainViewModel(dataManager: DataManager()), lat: 0, lng: 0)
    var navVC: UINavigationController?
    lazy var selectedVC = UIViewController()
    lazy var helpsVC = HelpVC()
    lazy var profileVC = ProfileVC(viewModel: ProfileViewModel(apiService: ProfileDataManager()))
    lazy var favouritesVC = FavouritesVC(viewModel: FavouritesViewModel(dataManager: FavouritesDataManager()))
    lazy var historyVC = HistoryVC(viewModel: HistoryViewModel(apiService: HistoryDataManager()))
    
    
    let darkeningView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.5
        return view
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVCs()
    }
    

    private func addChildVCs(){
        menuVC.delegate = self
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        homeVC.delegate = self
        let nav = UINavigationController(rootViewController: homeVC)
        addChild(nav)
        view.addSubview(nav.view)
        nav.didMove(toParent: self)
        self.navVC = nav
    }

}

extension ContainerVC: HomeVCDelegate {
    func didTapMenuButton() {
        toggleMenu(completion: nil)
    }
    
    func toggleMenu(completion: (() -> Void)?) {
        switch menuState {
        case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = self.homeVC.view.frame.size.width - 100
                self.navVC?.view.addSubview(self.darkeningView)
                self.darkeningView.frame = CGRect(x: 0, y: 0, width: (self.navVC!.view.bounds.size.width), height: (self.navVC!.view.bounds.size.height))
            } completion: { [weak self] (done) in
                if done {
                    self?.menuState = .opened
                }
            }
            

        case .opened:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = 0
                self.darkeningView.removeFromSuperview()
            } completion: { [weak self] (done) in
                if done {
                    self?.menuState = .closed
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
            }
        }
    }
}

extension ContainerVC: MenuVCDelegate {
    func didSelectLogout() {
        UserDefaults.standard.removeObject(forKey: Tokens.token)
        let vc = UINavigationController(rootViewController: SplashScreenViewController())
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func didSelect(menuItem: MenuOptions) {
        toggleMenu { [weak self] in
            switch menuItem {
            case .home:
                self?.resetToHome()
            case .favourites:
                self?.addFavourites()
            case .paymentMethods:
                break
            case .history:
                self?.addHistory()
            case .help:
                self?.addHelp()
            case .settings:
                break
            case .news:
                break
            case .info:
                break
            }
        }
    }
    
    func addFavourites(){
        selectedVC.removeFromParent()
        selectedVC.view.removeFromSuperview()
        selectedVC.didMove(toParent: nil)
        let vc = favouritesVC
        homeVC.addChild(vc)
        homeVC.view.addSubview(vc.view)
        vc.view.frame = view.frame
        vc.didMove(toParent: homeVC)
        homeVC.title = vc.title
        selectedVC = favouritesVC
    }
    
    func addHistory(){
        selectedVC.removeFromParent()
        selectedVC.view.removeFromSuperview()
        selectedVC.didMove(toParent: nil)
        let vc = historyVC
        homeVC.addChild(vc)
        homeVC.view.addSubview(vc.view)
        vc.view.frame = view.frame
        vc.didMove(toParent: homeVC)
        homeVC.title = vc.title
        selectedVC = historyVC
    }
    
    func addProfile(){
        selectedVC.removeFromParent()
        selectedVC.view.removeFromSuperview()
        selectedVC.didMove(toParent: nil)
        let vc = profileVC
        homeVC.addChild(vc)
        homeVC.view.addSubview(vc.view)
        vc.view.frame = view.frame
        vc.didMove(toParent: homeVC)
        homeVC.title = vc.title
        selectedVC = profileVC
    }
    
    func addHelp(){
        selectedVC.removeFromParent()
        selectedVC.view.removeFromSuperview()
        selectedVC.didMove(toParent: nil)
        let vc = helpsVC
        homeVC.addChild(vc)
        homeVC.view.addSubview(vc.view)
        vc.view.frame = view.frame
        vc.didMove(toParent: homeVC)
        homeVC.title = vc.title
        selectedVC = helpsVC
    }
    
    func resetToHome(){
        selectedVC.view.removeFromSuperview()
        selectedVC.didMove(toParent: nil)
        homeVC.title = nil
    }
    
}
