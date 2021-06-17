//
//  ViewController.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 24.02.2021.
//

import UIKit

class SplashScreenViewController: UIViewController, SetupView {
        
    //MARK: - Properties
    public let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.currentPageIndicatorTintColor = .yassyOrange
        pc.pageIndicatorTintColor = .yassyLight
        pc.numberOfPages = count.count
        return pc
    }()
    
    private lazy var splashCollectionView: UICollectionView = {
        let layout         = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    static let isSmallDevice = UIScreen.main.bounds.height < 568.0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupView() {
        
        [splashCollectionView, pageControl].forEach {
            view.addSubview($0)
        }
        pageControl.anchor(top: nil, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pageControl.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: 110).isActive = true
        splashCollectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        
        configureView()
        setupAction()
        configureColelctionView()
    }

    func configureView() {
        view.backgroundColor = .white
        configureNavigationBar(isHidden: true, backgroundColor: .clear, title: "")
        splashCollectionView.backgroundColor = .white
        splashCollectionView.isPagingEnabled = true
        splashCollectionView.showsHorizontalScrollIndicator = false
    }
    
    func setupAction() {
        
    }
    
    private func configureColelctionView() {
        splashCollectionView.register(FirstCollectionViewCell.self, forCellWithReuseIdentifier: FIRST_PAGE)
        splashCollectionView.register(SecondCollectionViewCell.self, forCellWithReuseIdentifier: SECOND_PAGE)
        splashCollectionView.register(ThirdCollectionViewCell.self, forCellWithReuseIdentifier: THIRD_PAGE)
        splashCollectionView.delegate = self
        splashCollectionView.dataSource = self
    }
}

extension SplashScreenViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: SplashScreenViewController.isSmallDevice ? view.frame.size.height - 50 : view.frame.size.height - 100)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension SplashScreenViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.item {
        case 0:
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FIRST_PAGE, for: indexPath) as! FirstCollectionViewCell
            cell.nextPageButton.addTarget(self, action: #selector(handleSecondPage), for: .touchUpInside)
            return cell
        case 1:
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SECOND_PAGE, for: indexPath) as! SecondCollectionViewCell
               cell.nextPageButton.addTarget(self, action: #selector(handleThirdPage), for: .touchUpInside)
            return cell
        case 2:
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: THIRD_PAGE, for: indexPath) as! ThirdCollectionViewCell
               cell.nextPageButton.addTarget(self, action: #selector(handleRegistrationPage), for: .touchUpInside)
            return cell
        default:
            return collectionView.dequeueReusableCell(withReuseIdentifier: FIRST_PAGE, for: indexPath)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scroll = scrollView.contentOffset.x / view.frame.width
        pageControl.currentPage = Int(scroll)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //MARK: - Methods
    @objc fileprivate func handleSecondPage() {
        let indexPath = IndexPath(item: 1, section: 0)
        splashCollectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
        
    }
    
    @objc fileprivate func handleThirdPage() {
        let indexPath = IndexPath(item: 2, section: 0)
        splashCollectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
    }
    
    @objc fileprivate func handleRegistrationPage() {
        let vc = RegistrationViewController(dataManager: DataManager())
            UIView.animateKeyframes(withDuration: 0.4, delay: 0.5) {
                self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


