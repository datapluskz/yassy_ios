////
////  StartedViewController.swift
////  OrangeTaxi
////
////  Created by Tanirbergen Kaldibai on 30.05.2021.
////
//
//import UIKit
//import FloatingPanel
//import Mapbox
//
//class StartedViewController: UIViewController, FloatingPanelControllerDelegate, MGLMapViewDelegate {
//    
//    var viewModel: MainViewModel!
//    
//    lazy var mapView = MGLMapView(frame: view.bounds)
//    var timer = Timer()
//    private(set) var lat: ((Double) -> ())?
//    var lon: ((Double) -> ())?
//    
//    init(viewModel: MainViewModel) {
//        self.viewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(cycle), userInfo: nil, repeats: true)
//        showMap()
//        configureVC()
//        configureFloatingPanel()
//    }
//    
//    @objc fileprivate func cycle() {
//        print("PROVIDER_LAT\(RequestID.provider_lat)")
//    }
//    
//    private func configureVC() {
//        view.backgroundColor = .white
//        configureNavigationBar(isHidden: true, backgroundColor: .clear, title: "")
//    }
//    
//    private func showMap() {
//        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        mapView.delegate = self
//        mapView.setCenter(CLLocationCoordinate2D(latitude: AddressInformation.s_lat, longitude: AddressInformation.s_lon), zoomLevel: 16, animated: false)
//        view.addSubview(mapView)
//    }
//    
//    private func getProviderAddress() {
//        
//    }
//    
//    func configureFloatingPanel() {
//        fpc = FloatingPanelController()
//        fpc.delegate = self
//        fpc.set(contentViewController: contentVC)
//        fpc.addPanel(toParent: self)
//        fpc.layout = SearchFpcLayout()
//        fpc.hide()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    deinit {
//        print("DeInitIsTrue")
//    }
//}
