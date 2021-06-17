//
//  OrderTaxiViewController.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 27.02.2021.
//

import UIKit
import FloatingPanel
import Mapbox
import CoreLocation
import JGProgressHUD
import MapboxCoreNavigation
import MapboxNavigation
import MapboxDirections

protocol ParsePriceProtocol: AnyObject {
    func parsePrice(standart: String, comfort: String)
}

class OrderTaxiViewController: UIViewController, SetupView, FloatingPanelControllerDelegate, MGLMapViewDelegate, FloatingPanelBehavior, CLLocationManagerDelegate {
    // MARK: - Properties
    lazy var url = URL(string: "mapbox://styles/mapbox/streets-v11")
    let marker = UIImageView(image: #imageLiteral(resourceName: "ic_pin").withRenderingMode(.alwaysOriginal))
    private let backButton = UIButton(type: .system)
    var fpc: FloatingPanelController!
    public var completionHandler: ((String?) -> Void)?
    var locationManage = CLLocationManager()
    let footerView = FooterOrderView()
    var addressView = AddressView()
    lazy var contentVC = FloatingPanelViewController()
    let appearance = SurfaceAppearance()
    var isTaxiEmty: Bool!
    let sizeScreen = UIScreen.main.bounds.height
    var data: ((String) -> ())?
    var mapView: NavigationMapView!
    var routeOptions: NavigationRouteOptions?
    var route: Route?
    var isNotWorkingView = YassyNotWorking()
    var viewModel: MainViewModel!
    var distanceValue = String()
    
    weak var delegate: ParsePriceProtocol?
    
    var fpcSecond: FloatingPanelController!
    let appearanceSecond = SurfaceAppearance()
    lazy var contentVCSecond = CarsFloatingPanelVC()
    
    init(viewModel: MainViewModel, isTaxiEmty: Bool) {
        self.viewModel = viewModel
        self.isTaxiEmty = isTaxiEmty
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        contentVC.addressView.userAddressTextField.text = AddressInformation.s_address
        contentVC.addressView.seachAddressTextField.text = AddressInformation.d_address
        progressShow()
        showMapBox()
        handleSearchTaxi()
        updatePriceView()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if isTaxiEmty {
            fpc.hide(animated: true, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [self] in
                UIView.animate(withDuration: 0.5) {
                    isNotWorkingView.alpha = 1
                    backButton.alpha = 0
                    view.layoutIfNeeded()
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [self] in
                fpc.show(animated: true)
                UIView.animate(withDuration: 0.5) {
                    isNotWorkingView.alpha = 0
                    backButton.alpha = 1
                    view.layoutIfNeeded()
                }
            }
        }
    }
    
    func drawPolyLine(){
        let userLocation = CLLocationCoordinate2D(latitude: AddressInformation.s_lat, longitude: AddressInformation.s_lon)
        let secondLocation = CLLocationCoordinate2D(latitude: AddressInformation.d_lat, longitude: AddressInformation.d_lon)
        calculateRouteFromCustomerToShop(from: userLocation, to: secondLocation)
    }
    
    func calculateRouteFromCustomerToShop(from origin: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {
        let origin = Waypoint(coordinate: origin, coordinateAccuracy: -1, name: "Customer")
        let destination = Waypoint(coordinate: destination, coordinateAccuracy: -1, name: "Shop")
        
        let routeOptions = NavigationRouteOptions(waypoints: [origin, destination], profileIdentifier: .automobileAvoidingTraffic)
        
        Directions.shared.calculate(routeOptions) { [weak self] (session, result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let response):
                guard let route = response.routes?.first, let strongSelf = self else {
                    return
                }
                UIView.animate(withDuration: 0.5) {
                    strongSelf.route = route
                    strongSelf.routeOptions = routeOptions
                    strongSelf.drawRouteFromCustomerToShop(route: route)
                }
            }
            self!.getDistance()
        }
    }

    
    func drawRouteFromCustomerToShop(route: Route){
        guard let routeShape = route.shape, routeShape.coordinates.count > 0 else { return }
        var routeCoordinates = routeShape.coordinates
        let polyline = MGLPolylineFeature(coordinates: &routeCoordinates, count: UInt(routeCoordinates.count))
        if let source = mapView.style?.source(withIdentifier: "route-source") as? MGLShapeSource {
            source.shape = polyline
        } else {
            let source = MGLShapeSource(identifier: "route-source", features: [polyline], options: nil)
            let lineStyle = MGLLineStyleLayer(identifier: "route-style", source: source)
            //lineStyle.lineDashPattern = NSExpression(forConstantValue: [2, 1.5])
            lineStyle.lineColor = NSExpression(forConstantValue: UIColor.yassyOrange)
            lineStyle.lineWidth = NSExpression(forConstantValue: 4)
            mapView.style?.addSource(source)
            if let style = mapView.style, let last = style.layers.last {
                mapView.style?.insertLayer(lineStyle, below: last)
            }
            else {
                mapView.style?.addLayer(lineStyle)
            }
        }
    }
    
    
    func mapViewDidFinishRenderingMap(_ mapView: MGLMapView, fullyRendered: Bool) {
        mapView.updateUserLocationAnnotationViewAnimated(withDuration: 3)
        drawPolyLine()
    }
    
    // MARK: - Methods
    func setupView() {
        
        [isNotWorkingView, backButton].forEach {
            view.addSubview($0)
        }
        
        isNotWorkingView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
        /// button position
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 30, left: 25, bottom: 0, right: 0))
        
        self.delegate = contentVCSecond
        configureView()
        setupAction()
        setupMarker()
        configureFloatingPanel()
        //updateView()
    }
    
    func configureView() {
        configureNavigationBar(isHidden: true, backgroundColor: .clear, title: "")
        view.backgroundColor = .white
        
        /// configure button
        backButton.configureButton(title: "", titleColor: .clear, isEnabled: true, cornerRadius: 9, borderWidth: 0, borderColor: UIColor.clear.cgColor, height: 40, backgroundColor: .white)
        backButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.setImage(#imageLiteral(resourceName: "ic_back").withRenderingMode(.alwaysOriginal), for: .normal)
        backButton.shadowView()
    }
    
    
    @objc func standartViewTapped(){
        configureCarsFloatingPanel()
    }
    
    func configureCarsFloatingPanel() {
        fpcSecond = FloatingPanelController()
        fpcSecond.delegate = self
        fpcSecond.isRemovalInteractionEnabled = true
        fpcSecond.set(contentViewController: contentVCSecond)
        fpcSecond.addPanel(toParent: self)
        fpcSecond.move(to: .half, animated: true)
        fpcSecond.layout = CarsFloatingPanelLayout()
        appearanceSecond.cornerRadius = 20.0
        fpcSecond.surfaceView.appearance = appearanceSecond
    }
    
    func setupAction() {
        backButton.addTarget(self, action: #selector(handleMainPage), for: .touchUpInside)
        
    }
    
    func configureFloatingPanel() {
        fpc = FloatingPanelController()
        fpc.delegate = self
        fpc.set(contentViewController: contentVC)
        fpc.addPanel(toParent: self)
        fpc.layout = MyFloatingPanelLayout()
        let appearance = SurfaceAppearance()
        appearance.cornerRadius = 20.0
        fpc.surfaceView.appearance = appearance
        let standardViewGesture = UITapGestureRecognizer(target: self, action: #selector(standartViewTapped))
        contentVC.standardCarView.addGestureRecognizer(standardViewGesture)
    }

    private func showMapBox() {
        mapView = NavigationMapView()
        view.addSubview(mapView)
       // mapView.heightAnchor.constraint(equalToConstant: view.frame.size.height / 1.8).isActive = true
        mapView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        mapView.tintColor = .darkGray
        mapView.showsUserLocation = true
        let center = CLLocationCoordinate2D(latitude: AddressInformation.s_lat, longitude: AddressInformation.s_lon)
        mapView.setCenter(center, zoomLevel: 16, direction: 0, animated: false)
        view.addSubview(mapView)
        mapView.delegate = self
        drawPolyLine()
       // addAnnatation()
    }
    
    func updatePriceView() {
        print("PRICE")
        viewModel.getPriceTaxi { [weak self] in
            guard let self = self else { return }
            let price = "\(String(describing: self.viewModel.priceData.first?.estimated_fare))"
            self.contentVC.standardCarView.pricaNumberLabel.text = "\(self.viewModel.priceData.first?.estimated_fare ?? 1000) ₸"
            self.contentVC.comfortCarView.pricaNumberLabel.text = "\(self.viewModel.priceData.last?.estimated_fare ?? 1000) ₸"
            
            self.delegate?.parsePrice(standart: "\(self.viewModel.priceData.first?.estimated_fare ?? 1000) ₸",
                                      comfort: "\(self.viewModel.priceData.last?.estimated_fare ?? 1000) ₸")
            
            print(price)
            DetailItems.price = self.viewModel.priceData.first?.estimated_fare ?? 0
            print("PRICE")
        }
    }
    
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        
        let startPoint = MGLPointAnnotation()
        startPoint.coordinate = CLLocationCoordinate2D(latitude: AddressInformation.s_lat, longitude: AddressInformation.s_lon)
            
        let shapeSource = MGLShapeSource(identifier: "marker-source", shape: startPoint, options: nil)
        let shapeLayer = MGLSymbolStyleLayer(identifier: "marker-style", source: shapeSource)
        if let image = UIImage(named: "ic_pin") {
        style.setImage(image, forName: "firstID")
        }
        shapeLayer.iconImageName = NSExpression(forConstantValue: "firstID")
        style.addSource(shapeSource)
        style.addLayer(shapeLayer)
        
        
        let finishPoint = MGLPointAnnotation()
        finishPoint.coordinate = CLLocationCoordinate2D(latitude: AddressInformation.d_lat, longitude: AddressInformation.d_lon)
        
        let shapeFinish = MGLShapeSource(identifier: "finishID", shape: finishPoint, options: nil)
        let finishLayer = MGLSymbolStyleLayer(identifier: "finishStyle", source: shapeFinish)
        
        if let image = UIImage(named: "finishPoint") {
            style.setImage(image, forName: "lastID")
        }
        
        
    
        let sw = CLLocationCoordinate2D(latitude: AddressInformation.s_lat, longitude: AddressInformation.s_lon)
        let ne = CLLocationCoordinate2D(latitude: AddressInformation.d_lat, longitude: AddressInformation.d_lon)
        
        let bounds = MGLCoordinateBounds(sw: sw, ne: ne)
        mapView.setVisibleCoordinateBounds(bounds, edgePadding: .init(top: 60, left: 60, bottom: sizeScreen / 1.8, right: 60), animated: true, completionHandler: nil)
        
        finishLayer.iconImageName = NSExpression(forConstantValue: "lastID")
        style.addSource(shapeFinish)
        style.addLayer(finishLayer)
    }

    private func addAnnatation() {
        mapView.addSubview(marker)
        marker.anchor(top: nil, leading: nil, bottom: nil, trailing: nil)
        marker.centerXAnchor.constraint(equalTo: mapView.centerXAnchor).isActive = true
        marker.centerYAnchor.constraint(equalTo: mapView.centerYAnchor, constant: -12).isActive = true
        marker.shadowView()
    }
    
    /// Direction
    private func setupMarker() {
        locationManage.desiredAccuracy = kCLLocationAccuracyBest
        locationManage.delegate = self
        locationManage.requestWhenInUseAuthorization()
        locationManage.startUpdatingLocation()
    }
    
    func getDistance(){
        guard let distance = route?.distance else { return }
        print("Distance is", distance)
       // distanceLabel.text = "Distance:".localized() + " \(distance) " + "m to shop"
    }
    
    @objc fileprivate func handleMainPage() {
        let navigationController = UINavigationController(rootViewController: ContainerVC())
        navigationController.navigationBar.isHidden = true
        navigationController.modalTransitionStyle = .crossDissolve
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
       // self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func progressShow() {
        let inValid = UserDefaults.standard.string(forKey: ProgressValue.valid)
        if inValid != "" {
            showProgress()
        }
    }
    
    func handleSearchTaxi() {
        contentVC.checkState = { val in
            if val {
                let navigationController = UINavigationController(rootViewController: CheckTaxiViewController(viewModel: MainViewModel(dataManager: DataManager())))
                navigationController.modalTransitionStyle = .crossDissolve
                navigationController.modalPresentationStyle = .fullScreen
                self.present(navigationController, animated: true, completion: nil)
                print("FIRSTADDRESS\(AddressInformation.s_lat)")
                print("FIRSTADDRESS\(AddressInformation.s_lon)")
                print("S_ADDRESS\(AddressInformation.s_address)")
                print("D_ADDRESS\(AddressInformation.d_address)")
                print("SECONDADDRESS\(AddressInformation.d_lat)")
                print("SECONDADDRESS\(AddressInformation.d_lon)")
            }
        }
    }
    
    deinit {
        print("deinit called")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
