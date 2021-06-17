//
//  HomeVC.swift
//  Yassy
//
//  Created by Didar Bakhitzhanov on 03.05.2021.
//

import UIKit
import Mapbox
import FloatingPanel

protocol HomeVCDelegate: AnyObject {
    func didTapMenuButton()
}

struct AddressInformation {
    static var s_lat = Double()
    static var s_lon = Double()
    static var d_lat = Double()
    static var d_lon = Double()
    static var s_address = String()
    static var d_address = String()
    static var distance = String()
}

class HomeVC: BaseViewController, MGLMapViewDelegate {
    
    // MARK: - Tanirbergen Properties
   
    var mapView: MGLMapView!
    let marker = UIImageView(image: #imageLiteral(resourceName: "ic_pin").withRenderingMode(.alwaysOriginal))
    weak var delegate: HomeVCDelegate?
    let addressViewModel: MainViewModel!
    var userlocationLon: ((Double) -> ())?
    var userlocationLat: ((Double) -> ())?
    var userAddressValue = String()
    var checkMap = false
    var checkSearchTextField: ((Bool) -> ())?
    
    var fpc: FloatingPanelController!
    let appearance = SurfaceAppearance()
    lazy var contentVC = SOSFloatingContainerVC()
    
//    let menuButton = UIButton(type: .system)
    
    enum CardState {
        case expanded
        case collapsed
    }
    
    //MARK: Bottom Sheet
    var cardViewController: HomeBottomSheetVC!
    lazy var cardHeight: CGFloat = UIScreen.main.bounds.height - self.topbarHeight
    let showCardHandleAreaHeight: CGFloat = UIScreen.main.bounds.height/3 - 50
    var cardVisible = false
    var runningAnimations: [UIViewPropertyAnimator] = []
    var animationProgressWhenInterrupted: CGFloat = 0
    var nextState: CardState {
        return cardVisible ? .collapsed : .expanded
    }
    
    var viewModel: HomeViewModel
    var lat: Double
    var lng: Double
    var latt = Double()
    var lott = Double()
    
    lazy var firstAddress = String()
    lazy var secondAddress = String()
    lazy var userLat = String()
    lazy var userLot = String()
    lazy var destinationLat = String()
    lazy var destinationLot = String()
    
    init(viewModel: HomeViewModel, addressViewModel: MainViewModel, lat: Double, lng: Double){
        self.viewModel = viewModel
        self.addressViewModel = addressViewModel
        self.lat = lat
        self.lng = lng
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSideMenu()
//        view.isUserInteractionEnabled = false
//        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [self] in
//            view.isUserInteractionEnabled = true
//        }
        showMapBox()
        setupViews()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if mapView != nil {
            mapView.removeFromSuperview()
            mapView = nil
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        showDetail()
        cardViewController.userLocationButton.addTarget(self, action: #selector(handleShowUserLocation), for: .touchUpInside)
        
        cardViewController.check = { [self] value in
            if value {
                let vc = ChooseAddressViewController(viewModel: MainViewModel(dataManager: DataManager()))
                let navigationController = UINavigationController(rootViewController: vc)
                navigationController.modalTransitionStyle = .coverVertical
                navigationController.modalPresentationStyle = .fullScreen
                self.view.isUserInteractionEnabled = true
                self.present(navigationController, animated: true, completion: nil)
            }
        }
        
        UIView.animate(withDuration: 0.1) { [weak self] in
                        guard self == self else { return }
                        self!.marker.frame.origin.y -= 20
            } completion: { (_) in
                        UIView.animateKeyframes(withDuration: 1, delay: 0.5, options: [.autoreverse, .repeat], animations: {
                            self.marker.frame.origin.y += 20
            }, completion: nil)
        }
    }
    
    @objc fileprivate func handleShowUserLocation() {
        if let userLocation = mapView.userLocation?.location?.coordinate {
            let coordinate = CLLocationCoordinate2D(latitude: userLocation.latitude, longitude: userLocation.longitude)
            mapView.setCenter(coordinate, zoomLevel: 15, animated: false)
        } else {
            showAlert(alertString: "Включите геолокацию")
        }
    }
    
    fileprivate func setupViews(){
        view.backgroundColor = .white
        setupBottomSheet()
    }
    
    
    @objc func didTapMenuButton(){
        delegate?.didTapMenuButton()
    }
    
    private func setupBottomSheet(){
        cardViewController = HomeBottomSheetVC(viewModel: HomeBottomSheetViewModel(dataManager: DataManager()))
        cardViewController.hideDelegate = self
        addChild(cardViewController)
        view.addSubview(cardViewController.view)
        cardViewController.view.frame = CGRect(x: 0,
                                               y: self.view.frame.height - showCardHandleAreaHeight,
                                               width: view.frame.width,
                                               height: cardHeight)
        cardViewController.view.clipsToBounds = true
        cardViewController.view.layer.cornerRadius = 20.0
        cardViewController.minusButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCardTapGesture(recognizer:))))
        cardViewController.sosButton.addTarget(self, action: #selector(sosButtonTapped), for: .touchUpInside)
        cardViewController.searchTextField.addTarget(self, action: #selector(textDidBeginEditing(_:)), for: .editingDidBegin)
        cardViewController.userLocationTextField.addTarget(self, action: #selector(textDidBeginEditing(_:)), for: .editingDidBegin)
//        cardViewController.searchTextField.addTarget(self, action: #selector(textEditingChanged(_:)), for: .editingChanged)
        cardViewController.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleCardPanGesture(recognizer:))))
    }
    
    func configureFloatingPanel() {
        fpc = FloatingPanelController()
        fpc.delegate = self
        fpc.isRemovalInteractionEnabled = true
        fpc.set(contentViewController: contentVC)
        fpc.addPanel(toParent: self)
        fpc.layout = SOSFloatingPanelLayout()
        appearance.cornerRadius = 20.0
        fpc.surfaceView.appearance = appearance
    }
    
    private func showMapBox() {
        mapView = MGLMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.allowsRotating = false
        mapView.logoView.isHidden = true

        mapView.compassView.isHidden = true
        view.addSubview(mapView)
        addAnnatation()
        
       
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        checkMap = true
        if let userLocation = mapView.userLocation?.location?.coordinate {
            let coordinate = CLLocationCoordinate2D(latitude: userLocation.latitude, longitude: userLocation.longitude)
            mapView.setCenter(coordinate, zoomLevel: 15, animated: false)
        } else {
            showAlert(alertString: "Включите геолокацию")
            mapView.setCenter(AppKeys.turkestanCoordinate, zoomLevel: 15, animated: false)
        }
    }
    
    private func showDetail() {
//        cardViewController.check = { [self] check in
//            if check {
//                let vc = GetLocationViewController(viewModel: MainViewModel(dataManager: DataManager()), lat: 0.0, lng: 0.0)
//                vc.latt = latt
//                vc.lott = lott
//                vc.firstAddress = userAddressValue
//                cardViewController.getAddress = { val, string in
//                    if val {
//                        vc.secondAddress = string
//                    }
//                }
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
//        }
    }
    
    private func addAnnatation() {
        mapView.addSubview(marker)
        marker.anchor(top: nil, leading: nil, bottom: nil, trailing: nil)
        marker.centerXAnchor.constraint(equalTo: mapView.centerXAnchor).isActive = true
        marker.centerYAnchor.constraint(equalTo: mapView.centerYAnchor, constant: -12).isActive = true
        marker.shadowView()
    }
    
    func mapViewRegionIsChanging(_ mapView: MGLMapView) {
        checkMap = true
    }
    
    func mapView(_ mapView: MGLMapView, regionDidChangeWith reason: MGLCameraChangeReason, animated: Bool) {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        latt = latitude
        lott = longitude
        AddressInformation.s_lat = latitude
        AddressInformation.s_lon = longitude
        if checkMap {
        addressViewModel.getUserLocation(lat: "\(latitude)", lon: "\(longitude)") { [weak self] in
            guard self == self else { return }
            guard let text = self!.addressViewModel.locationItems.name else { return }
            for char in text {
                if char != "," {
                    self!.userAddressValue.append(char)
                }
            }
            print(self!.addressViewModel.locationItems.name ?? "")
            self!.cardViewController.userLocationTextField.text = self!.userAddressValue
            AddressInformation.s_address = self!.userAddressValue
            self!.userAddressValue.removeAll()
        }
        }
    }
    
    @objc func sosButtonTapped(){
        configureFloatingPanel()
    }

}

extension HomeVC: BottomSheetHideProtocol {
    
    
    func addHomeTapped() {
        self.animateTransitionIfNeeded(state: nextState, duration: 0.3)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let vc = OrderTaxiViewController(viewModel: MainViewModel(dataManager: DataManager()), isTaxiEmty: false)
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            nav.modalTransitionStyle = .crossDissolve
            self.present(nav, animated: true, completion: nil)
        }

    }
    
    func addWorkTapped() {
        self.animateTransitionIfNeeded(state: nextState, duration: 0.3)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let vc = OrderTaxiViewController(viewModel: MainViewModel(dataManager: DataManager()), isTaxiEmty: false)
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            nav.modalTransitionStyle = .crossDissolve
            self.present(nav, animated: true, completion: nil)
        }
    }
    
    //MARK: - Тут вся магия
    
    func hideBottomSheet(tag: Int, address: String, latitude: String, longitude: String) {
        
        self.animateTransitionIfNeeded(state: nextState, duration: 0.9)
        view.endEditing(true)
        
        if tag == 1 {
            AddressInformation.s_address = address
            AddressInformation.s_lat = Double(latitude) ?? 0.0
            AddressInformation.s_lon = Double(longitude) ?? 0.0
        }
        
        if tag == 2{
            AddressInformation.d_address = address
            AddressInformation.d_lat = Double(latitude) ?? 0.0
            AddressInformation.d_lon = Double(longitude) ?? 0.0
            let vc = OrderTaxiViewController(viewModel: MainViewModel(dataManager: DataManager()), isTaxiEmty: false)
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            nav.modalTransitionStyle = .crossDissolve
            present(nav, animated: true, completion: nil)
//            self.setupLoading(timer: 1, centerY: 0)
//            self.secondAddress = address
//            self.destinationLat = latitude
//            self.destinationLot = longitude
//            print(address)
//            print(latitude)
//            print(longitude)
//            let vc = OrderTaxiViewController(viewModel: MainViewModel(dataManager: DataManager()), isTaxiEmty: false)
//            let navController = UINavigationController(rootViewController: vc)
//            navController.modalTransitionStyle = .crossDissolve
//            navController.modalPresentationStyle = .fullScreen
//            if "\(AddressInformation.s_lat)".isEmpty || "\(AddressInformation.s_lat)".count == 0 {
//                AddressInformation.s_lat = latt
//            }
//            else {
//                AddressInformation.s_lat = Double(userLat) ?? 0.0
//            }
//
//            if "\(AddressInformation.s_lon)".isEmpty || "\(AddressInformation.s_lon)".count == 0 {
//                AddressInformation.s_lon = Double(lott)
//            }
//            else {
//                AddressInformation.s_lon = Double(userLot) ?? 0.0
//            }
//
//            AddressInformation.s_address = cardViewController.userLocationTextField.text!
//
//            AddressInformation.d_lat = Double(destinationLat) ?? 0.0
//            AddressInformation.d_lon = Double(destinationLot) ?? 0.0
//            present(navController, animated: true, completion: nil)
        }
    }
    
}

extension HomeVC: FloatingPanelControllerDelegate {
 
    
//    @objc func textEditingChanged(_ sender: UITextField) {
//        viewModelInput?.searchAddress(address: sender.text!)
//    }
    
    @objc func textDidBeginEditing(_ sender:UITextField) -> Void
    {
        if cardVisible == false {
            self.animateTransitionIfNeeded(state: nextState, duration: 0.9)
        }
       
    }
    
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
                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.showCardHandleAreaHeight
                    self.cardViewController.view.backgroundColor = .clear
                    self.cardViewController.userLocationButton.isHidden = false
                    self.cardViewController.sosButton.isHidden = false
                    self.cardViewController.minusButton.isHidden = true
                    self.cardViewController.stackButton.isHidden = false
                    self.cardViewController.tableView.isHidden = true
                case .expanded:
                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHeight
                    self.cardViewController.view.backgroundColor = .white
                    self.cardViewController.userLocationButton.isHidden = true
                    self.cardViewController.sosButton.isHidden = true
                    self.cardViewController.minusButton.isHidden = false
                    self.cardViewController.stackButton.isHidden = true
                    self.cardViewController.tableView.isHidden = false
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
