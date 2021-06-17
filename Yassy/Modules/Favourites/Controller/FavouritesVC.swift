//
//  FavouritesVC.swift
//  Yassy
//
//  Created by Didar Bakhitzhanov on 03.05.2021.
//

import UIKit

protocol PassAddressTypeDelegate: AnyObject {
    func passAddressType(type: String)
}

protocol FavouritesListViewModelInput: AnyObject {
    func reloadFavourites()
}

class FavouritesVC: BaseViewController {
    
    //MARK: Bottom Sheet
    var cardViewController: FavouritesBottomSheetVC!
    lazy var cardHeight: CGFloat = UIScreen.main.bounds.height - self.topbarHeight
    let showCardHandleAreaHeight: CGFloat = 0
    var cardVisible = false
    var runningAnimations: [UIViewPropertyAnimator] = []
    var animationProgressWhenInterrupted: CGFloat = 0
    enum CardState {
        case expanded
        case collapsed
    }
    var nextState: CardState {
        return cardVisible ? .collapsed : .expanded
    }
    
    lazy var tableView = UITableView(frame: .zero)
    
    
    var viewModel: FavouritesViewModel
    
    weak var viewModelInput: FavouritesListViewModelInput?
    
    weak var passAddressTypeDelegate: PassAddressTypeDelegate?
    
    init(viewModel: FavouritesViewModel){
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
        callToViewModelForHomeAddressUpdate()
        callToViewModelForWorkAddressUpdate()
        callToViewModelForUIUpdate()
    }
    
  
    fileprivate func setupViews(){
        title = "Избранные адреса"
        view.backgroundColor = .white
        setupTableView()
        setupBottomSheet()
    }
    
   
    
  
    
    private func setupTableView(){
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        view.addSubview(tableView)
        tableView.setAnchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor,
                            bottom: view.bottomAnchor, right: view.rightAnchor,
                            paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        [HomeFavouriteCell.self, WorkFavouriteCell.self, OtherFavouriteCell.self, AddFavouriteCell.self].forEach { (cell) in
            tableView.register(cell, forCellReuseIdentifier: cell.description())
        }
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupBottomSheet(){
        cardViewController = FavouritesBottomSheetVC(viewModel: FavouritesBottomSheetViewModel(dataManager: FavouritesDataManager()))
        self.passAddressTypeDelegate = cardViewController.viewModel
        cardViewController.addressAddedSuccessDelegate = viewModel
        cardViewController.delegate = self
        cardViewController.addressAddedCompletion = { [weak self]
            (isSuccess) in
            self?.animateTransitionIfNeeded(state: self!.nextState, duration: 0.4)
        }
        addChild(cardViewController)
        view.addSubview(cardViewController.view)
        cardViewController.view.frame = CGRect(x: 0,
                                               y: self.view.frame.height - showCardHandleAreaHeight,
                                               width: view.frame.width,
                                               height: cardHeight)
        cardViewController.view.clipsToBounds = true
        cardViewController.view.layer.cornerRadius = 20.0
        cardViewController.view.addShadow(location: .top)
        cardViewController.view.isHidden = true
        cardViewController.minusButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCardTapGesture(recognizer:))))
        cardViewController.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleCardPanGesture(recognizer:))))
        
     
    }
    
    private func callToViewModelForUIUpdate(){
        viewModel.bindOtherAddressesToController = {
            DispatchQueue.main.async {
                self.tableView.reloadSections(IndexSet(integer: 2), with: .fade)
            }
        }
    }
    
    private func callToViewModelForHomeAddressUpdate(){
        viewModel.bindHomeAddressToController = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func callToViewModelForWorkAddressUpdate(){
        viewModel.bindWorkAddressToController = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}

extension FavouritesVC: AddAddressSuccessDelegateSecond {
    
    func addressAddedSuccessfullySecond() {
        print("self.animateTransitionIfNeeded(state: nextState, duration: 0.4)")
        view.endEditing(true)
        self.animateTransitionIfNeeded(state: nextState, duration: 0.4)
    }
    
    
}

extension FavouritesVC: FavouritesAndHomeBottomSheetProtocol {
    
  
    
    func presentHome() {
        print("Add Home")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            print("Add Home")
            self.showBottomSheet(type: "home")
        }
    }
    
    func presentWork() {
        print("Add Work")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            print("Add Work")
            self.showBottomSheet(type: "work")
        }
    }
    
    
}

extension FavouritesVC {
    @objc func handleCardTapGesture(recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended: self.animateTransitionIfNeeded(state: nextState, duration: 0.9)
            view.endEditing(true)
        default: break
        }
    }
    
    @objc func handleCardPanGesture(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startInteractiveTransition(state: self.nextState, duration: 0.7)
        case .changed:
            let translation = recognizer.translation(in: self.cardViewController.minusButton)
            var fractionCompleted = translation.y / cardHeight
            fractionCompleted = cardVisible ? fractionCompleted : -fractionCompleted
            updateInteractiveTransition(fractionCompleted: fractionCompleted)
            view.endEditing(true)
        case .ended: continueInteractiveTransition()
            view.endEditing(true)
        default: break
        }
    }
    
    func animateTransitionIfNeeded(state: CardState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .collapsed:
                    print("Sommmm")
                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.showCardHandleAreaHeight
                case .expanded:
                    print("Sllllmmm")
                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHeight
                }
            }
            
            frameAnimator.addCompletion { (_) in
                self.cardVisible = !self.cardVisible
                self.runningAnimations.removeAll()
            }
            
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
        }
    }
    
    func startInteractiveTransition(state: CardState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        
        runningAnimations.forEach { (animator) in
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    
    func updateInteractiveTransition(fractionCompleted: CGFloat) {
        runningAnimations.forEach { (animator) in
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }
    
    func continueInteractiveTransition() {
        runningAnimations.forEach { (animator) in
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
}

extension FavouritesVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 2:
            return viewModel.otherAddressesData?.count ?? 0
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: HomeFavouriteCell.description(), for: indexPath) as! HomeFavouriteCell
            if let addressModel = viewModel.homeAddressData {
                cell.generateCell(addressModel)
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: WorkFavouriteCell.description(), for: indexPath) as! WorkFavouriteCell
            if let addressModel = viewModel.workAddressData {
                cell.generateCell(addressModel)
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: OtherFavouriteCell.description(), for: indexPath) as! OtherFavouriteCell
            if let addressModel = viewModel.otherAddressesData?[indexPath.row] {
                cell.generateCell(addressModel)
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: AddFavouriteCell.description(), for: indexPath) as! AddFavouriteCell
            return cell
        }
    }
    
    
    
    
}

extension FavouritesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            if let data = viewModel.homeAddressData {
                showFavouriteAddressVC(adressData: data, imageName: "ic_home")
            } else {
                showBottomSheet(type: "home")
            }
        case 1:
            if let data = viewModel.workAddressData {
                showFavouriteAddressVC(adressData: data, imageName: "ic_work")
            } else {
               showBottomSheet(type: "work")
            }
        case 2:
            if let data = viewModel.otherAddressesData?[indexPath.row] {
                showFavouriteAddressVC(adressData: data, imageName: "ic_pin-2")
            }
        default:
            showBottomSheet(type: "others")
            break
        }
    }
    
    private func showBottomSheet(type: String){
        passAddressTypeDelegate?.passAddressType(type: type)
        cardViewController.view.isHidden = false
        self.animateTransitionIfNeeded(state: nextState, duration: 0.9)
    }
    
    private func showFavouriteAddressVC(adressData: AddressModel, imageName: String ){
        let vc = EditFavouriteAddressVC(viewModel: EditAddressViewModel(dataManager: FavouritesDataManager(),
                                                                         addressData: adressData, imageName: imageName))
        vc.addressDeletedCompletion = { [weak self]
            (isSuccess) in
            self?.viewModelInput?.reloadFavourites()
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension UIView {
    
    enum VerticalLocation: String {
        case bottom
        case top
    }
    
    func addShadow(location: VerticalLocation, color: UIColor = .black, opacity: Float = 0.1, radius: CGFloat = 1.0) {
        switch location {
        case .bottom:
            addShadow(offset: CGSize(width: 0, height: 4), color: color, opacity: opacity, radius: radius)
        case .top:
            addShadow(offset: CGSize(width: 0, height: -4), color: color, opacity: opacity, radius: radius)
        }
    }
    
    func addShadow(offset: CGSize, color: UIColor = .black, opacity: Float = 0.1, radius: CGFloat = 1.0) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
}
