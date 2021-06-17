//
//  UiNavigationController.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 24.02.2021.
//

import UIKit

extension UIViewController {
    func configureNavigationBar(isHidden: Bool, backgroundColor: UIColor,title: String) {
        self.navigationController?.navigationBar.isHidden = isHidden
        self.navigationController?.navigationBar.backgroundColor = backgroundColor
        self.navigationController?.navigationItem.title = title
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboardView")
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func showAlert(alertString: String) {
        let alert = UIAlertController(title: "", message: alertString, preferredStyle: .alert)
            present(alert, animated: true, completion: nil)
        let when = DispatchTime.now() + 2.8
            DispatchQueue.main.asyncAfter(deadline: when){
              alert.dismiss(animated: true, completion: nil)
            }
    }
    
    func closeAlert(string: String) {
        let alertController = UIAlertController(title: "", message: "Вы действительно хотите\n отменить заказ?", preferredStyle: .alert)// Create the actions
        let okAction = UIAlertAction(title: "Да", style: UIAlertAction.Style.default) {
                        UIAlertAction in
            self.setupLoading(timer: 2, centerY: 0)
            let vc = CloseViewController(viewModel: MainViewModel(dataManager: DataManager()))
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            vc.requestID = string
            self.present(vc, animated: true, completion: nil)
            
        }
        let cancelAction = UIAlertAction(title: "Нет", style: UIAlertAction.Style.cancel) {
                        UIAlertAction in
                        NSLog("Cancel Pressed")
                    }
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    func closeAlertWhenSearch() {
        let alertController = UIAlertController(title: "", message: "Вы действительно хотите\n отменить поиск?", preferredStyle: .alert)// Create the actions
        let okAction = UIAlertAction(title: "Да", style: UIAlertAction.Style.default) {
                        UIAlertAction in
            
            
            let vc = CloseViewWhenSearchTaxiVC(viewModel: MainViewModel(dataManager: DataManager()))
            let thisView = SearchViewController(dataManager: DataManager(), viewmodel: MainViewModel(dataManager: DataManager()), pulseCheck: false)
            thisView.dismiss(animated: false) {
                thisView.timer.invalidate()
                print("deinit True")
            }
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            
        }
        let cancelAction = UIAlertAction(title: "Нет", style: UIAlertAction.Style.cancel) {
                        UIAlertAction in
                        NSLog("Cancel Pressed")
                    }
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }

    func dismissKeyboardView() {
        view.endEditing(true)
    }
}
