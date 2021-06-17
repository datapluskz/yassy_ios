//
//  ChoosAddressViewController.swift
//  OrangeTaxi
//
//  Created by Tanirbergen Kaldibai on 13.05.2021.
//

import UIKit
import Mapbox

struct UserLocationConstants {
    static var lat = Double()
    static var lon = Double()
}

struct FinishLocationCoordinate {
    static var lat = Double()
    static var lon = Double()
    static var address = String()
}

class ChooseAddressViewController: UIViewController {
    
    // MARK: - PROPERTIES
    let button = UIButton(type: .system)
    lazy var showAddressView = ShowAddressView()
    let mapView = MGLMapView()
    let viewModel: MainViewModel
   // let userInformation: ((FinishLocationCoordinate) -> ())?
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ic_back").withRenderingMode(.alwaysOriginal), for: .normal)
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.layer.cornerRadius = 8
        button.backgroundColor = .white
        return button
    }()
    
    lazy var showUserLocationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ic_main-3").withRenderingMode(.alwaysOriginal), for: .normal)
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.layer.cornerRadius = 8
        button.backgroundColor = .white
        return button
    }()
    
    // MARK: - Init
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapBox()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("USERAddres\(UserLocationConstants.lat)")
        print(UserLocationConstants.lon)
        configureView()
    }
    
    // MARK: - CONFIGURE VIEW
    private func configureView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        setupLoading(timer: 1, centerY: 0)
        setupView()
    }
    
    private func setupView() {
        /// bottom View
        [showAddressView, backButton, showUserLocationButton].forEach {
            view.addSubview($0)
        }
        
        /// configureView
        showAddressView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
        /// button configure
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 12, left: 12, bottom: 0, right: 0))
        backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        backButton.shadowView()
        
        showUserLocationButton.anchor(top: nil, leading: nil, bottom: showAddressView.topAnchor, trailing: showAddressView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 12, right: 4))
        showUserLocationButton.addTarget(self, action: #selector(handleShowUserLocation), for: .touchUpInside)
        showUserLocationButton.shadowView()
        
        showAddressView.addressButton.addTarget(self, action: #selector(handleOrderTaxi), for: .touchUpInside)
        /// setupMarker
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.setupMarker(marker: #imageLiteral(resourceName: "ic_pin-1"))
            self.view.layoutIfNeeded()
        }
        
    }
    
    // MARK: - CONFIGURE MAPBOX
    private func setupMapBox() {
        view.addSubview(mapView)
        mapView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        mapView.delegate = self
        mapView.setCenter(CLLocationCoordinate2D(latitude: AddressInformation.s_lat, longitude: AddressInformation.s_lon), zoomLevel: 16, animated: false)
    }
    
    // MARK: - ACTIONS
    @objc fileprivate func handleBack() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func handleShowUserLocation() {
        guard let location = mapView.userLocation?.location?.coordinate else {
            return
        }
        mapView.setCenter(CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude),animated: true)
    }
    
    @objc fileprivate func handleOrderTaxi() {
        let vc = OrderTaxiViewController(viewModel: MainViewModel(dataManager: DataManager()), isTaxiEmty: false)
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalTransitionStyle = .crossDissolve
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChooseAddressViewController: MGLMapViewDelegate {
    func mapView(_ mapView: MGLMapView, regionDidChangeWith reason: MGLCameraChangeReason, animated: Bool) {
        let location = mapView.centerCoordinate
        print(location.latitude)
        AddressInformation.d_lat = location.latitude
        AddressInformation.d_lon = location.longitude
        viewModel.getUserLocation(lat: "\(location.latitude)", lon: "\(location.longitude)") { [weak self] in
            guard let self = self else { return }
            self.showAddressView.addressLabel.text = self.viewModel.locationItems.name
            AddressInformation.d_address = self.viewModel.locationItems.name ?? ""
        }
    }
}



