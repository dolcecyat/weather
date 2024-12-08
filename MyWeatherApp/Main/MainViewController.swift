//
//  ViewController.swift
//  MyWeatherApp
//
//  Created by Анатолий Коробских on 28.11.2024.
//

import UIKit

private enum Constants {
    static let imageNameForLeftBarButtonItem = "gearshape.fill"
    static let imageNameForRightBarButtonItem = "location.fill"
    static let mapButtonLabel = "Карта осадков"
    static let monthWeatherButtonLabel = "Прогноз на месяц →"
}

protocol MainViewProtocol: AnyObject {
    var presenter: MainPresenterProtocol? { get set }
    func reloadData()
}

class MainViewController: UIViewController {
    var presenter: MainPresenterProtocol?

    //MARK: - UI properties
     
    private var scrollView = UIScrollView()
    private var topCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private var bottomCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private var mapButton = UIButton()
    private var summaryView = SummaryView()
    private var monthButton = UIButton()
    private var searchBar = UISearchBar()
    
    // MARK: - Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: - Setup
    
    private func setup() {
        MainModuleBuilder.build(self)
        setupNavBar()
        setCollectionViews()
        setDelegates()
        addingViews()
        makeConstaraints()
        setUpUI()
        setUpActions()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.resignFirstResponder()
    }
    
    private func setDelegates() {
        searchBar.delegate = self
        topCollectionView.delegate = self
        topCollectionView.dataSource = self
        bottomCollectionView.delegate = self
        bottomCollectionView.dataSource = self

    }
    // MARK: - SetUp UI
    
    private func setupNavBar() {
        navigationController?.navigationBar.barTintColor =  UIColor(cgColor: Colors.backgroundViewColor)
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = UIColor(cgColor: Colors.lighterBackgroundColor)
#warning ("при свайпе обратно не показывается --- теперь почему то работает????")
        navigationController?.hidesBarsOnSwipe = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Constants.imageNameForLeftBarButtonItem), style: .plain, target: self, action: #selector(openSettings))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Constants.imageNameForRightBarButtonItem), style: .plain, target: self, action: #selector(getLocation))
        navigationItem.titleView = searchBar
        searchBar.searchTextField.backgroundColor = UIColor(cgColor: Colors.lighterBackgroundColor)
        searchBar.sizeToFit()
    }

    func addingViews() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(mapButton)
        scrollView.addSubview(topCollectionView)
        scrollView.addSubview(summaryView)
        scrollView.addSubview(bottomCollectionView)
        scrollView.addSubview(monthButton)
    }
    
    func makeConstaraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        topCollectionView.translatesAutoresizingMaskIntoConstraints = false
        mapButton.translatesAutoresizingMaskIntoConstraints = false
        summaryView.translatesAutoresizingMaskIntoConstraints = false
        bottomCollectionView.translatesAutoresizingMaskIntoConstraints = false
        monthButton.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.frame = view.bounds
        scrollView.contentSize = CGSize(width:  view.frame.width, height: 2000)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            topCollectionView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 100),
            topCollectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
//            TopCollectionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            topCollectionView.heightAnchor.constraint(equalToConstant: 500),
            topCollectionView.widthAnchor.constraint(equalToConstant: 393),

            mapButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            mapButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            mapButton.widthAnchor.constraint(equalToConstant: 80),
            mapButton.heightAnchor.constraint(equalToConstant: 80),
        
            summaryView.topAnchor.constraint(equalTo: topCollectionView.bottomAnchor, constant: 20),
            summaryView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
//            summaryView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            summaryView.heightAnchor.constraint(equalToConstant: 110),
            summaryView.widthAnchor.constraint(equalToConstant: 353),
            
            bottomCollectionView.topAnchor.constraint(equalTo: summaryView.bottomAnchor, constant: 30),
            bottomCollectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            bottomCollectionView.heightAnchor.constraint(equalToConstant: 760),
            bottomCollectionView.widthAnchor.constraint(equalToConstant: 393),
            
            monthButton.topAnchor.constraint(equalTo: bottomCollectionView.bottomAnchor, constant: 15),
            monthButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            monthButton.heightAnchor.constraint(equalToConstant: 70),
            monthButton.widthAnchor.constraint(equalToConstant: 250),
            ])
    }
    
    private func setUpUI() {
        self.view.backgroundColor = UIColor(cgColor: Colors.backgroundViewColor)
        topCollectionView.backgroundColor = .clear
        topCollectionView.bounces = false
      
        bottomCollectionView.backgroundColor = .clear
        bottomCollectionView.bounces = false
        bottomCollectionView.isScrollEnabled = false
        
        mapButton.setTitle(Constants.mapButtonLabel, for: .normal)
        mapButton.titleLabel?.font = .systemFont(ofSize: 17)
        mapButton.titleLabel?.numberOfLines = 2
        mapButton.titleLabel?.textAlignment = .center
        mapButton.setTitleColor(UIColor(cgColor: Colors.lighterTextColor), for: .normal)
        mapButton.backgroundColor = UIColor(cgColor: Colors.lighterBackgroundColor)
        mapButton.layer.cornerRadius = 40
        
        monthButton.setTitle(Constants.monthWeatherButtonLabel, for: .normal)
        monthButton.titleLabel?.font = .systemFont(ofSize: 18)
        monthButton.titleLabel?.textAlignment = .center
        monthButton.setTitleColor(UIColor(cgColor: Colors.lighterTextColor), for: .normal)
        monthButton.backgroundColor = UIColor(cgColor: Colors.lighterBackgroundColor)
        monthButton.layer.cornerRadius = 35
    }
    
    func setCollectionViews() {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        let firstLO = createFirstLayout()
        firstLO.configuration = config
        topCollectionView = UICollectionView(frame: .zero, collectionViewLayout: firstLO)
        topCollectionView.register(FirstWeatherInfoCVCell.self, forCellWithReuseIdentifier: FirstWeatherInfoCVCell.identifier)
        topCollectionView.register(TodaysWeatherInfoCVCell.self, forCellWithReuseIdentifier: TodaysWeatherInfoCVCell.identifier)
        topCollectionView.register(TodaysHourTempInfoCVCell.self, forCellWithReuseIdentifier: TodaysHourTempInfoCVCell.identifier)
        
        let secondLd = createSecondLayout()
        secondLd.configuration = config
        bottomCollectionView = UICollectionView(frame: .zero, collectionViewLayout: secondLd)
        bottomCollectionView.register(ActivityCVCell.self, forCellWithReuseIdentifier: ActivityCVCell.identifier)
        bottomCollectionView.register(XDaysCVCell.self, forCellWithReuseIdentifier: XDaysCVCell.identifier)
    }
  
    // MARK: - NavigationBarButton actions
    
    @objc private func openSettings() {
        
    }
    
    @objc private func getLocation() {
        presenter?.locationButtonPressed()
    }

    // MARK: - Button actions
    
    private func setUpActions() {
        mapButton.addTarget(self, action: #selector(map), for: .touchUpInside)
        monthButton.addTarget(self, action: #selector(monthWeather), for: .touchUpInside)
    }
    
    @objc private func map() {

    }
    @objc private func monthWeather() {

    }
}

// MARK: - CollectionView Layout
extension MainViewController {
    
}

// MARK: -
extension MainViewController: MainViewProtocol {
    
    func reloadData() {
        topCollectionView.reloadData()
        bottomCollectionView.reloadData()
    }
}

extension MainViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        var secNumber = 0
        if collectionView == topCollectionView {
            secNumber = presenter?.getNumberOfSectionTopCV() ?? 0
        } else if collectionView == bottomCollectionView {
            secNumber = presenter?.getNumberOfSectionBottomCV() ?? 0
        }
        return secNumber
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var numberOfRows: Int = 0
        if collectionView == topCollectionView {
            if section == 0 {
                numberOfRows = 6
            } else {
                numberOfRows = 24}
        } else if collectionView == bottomCollectionView {
            if section == 0 {
                numberOfRows = 5
            } else {
                numberOfRows = 10}
        }
        return numberOfRows
        /*    presenter?.getNumberOfItemsInSection() ??*//* 2*/
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cellFor  = UICollectionViewCell()
        if collectionView == topCollectionView {
            let sec = SectionsData.MainFirstCollectionView.allCases.first (where: { $0.sectionNumber == indexPath.section })
            switch sec {
            case .TodaysDetailInfo:
                switch indexPath.item {
                case 0:
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FirstWeatherInfoCVCell.identifier, for: indexPath) as? FirstWeatherInfoCVCell,let modelForCell =   presenter?.getFirstWeatherInfoCVCellInfo(indexPath: indexPath)  else { return UICollectionViewCell() }
                    cell.configure(model: modelForCell)
                    cellFor = cell
                default:
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodaysWeatherInfoCVCell.identifier, for: indexPath) as? TodaysWeatherInfoCVCell,let modelForCell =   presenter?.getTodaysWeatherInfoCVCellInfo(indexPath: indexPath)  else { return UICollectionViewCell() }
                    cell.configure(model: modelForCell)
                    cellFor = cell
                }
            case .HourInfo:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodaysHourTempInfoCVCell.identifier, for: indexPath) as? TodaysHourTempInfoCVCell,let modelForCell =   presenter?.getTodaysHourTempInfoCollectionViewCellInfo(indexPath: indexPath)  else { return UICollectionViewCell() }
                cell.configure(model: modelForCell)
                cellFor = cell
            case .none:
                print("1")
            }
        } else if collectionView == bottomCollectionView {
            let sec = SectionsData.MainSecondCollectionView.allCases.first (where: { $0.sectionNumber == indexPath.section })
            switch sec {
            case .ActivityInfo:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActivityCVCell.identifier, for: indexPath) as? ActivityCVCell,let modelForCell =   presenter?.getActivityCVCellInfo(indexPath: indexPath)  else { return UICollectionViewCell() }
                cell.configure(model: modelForCell)
                cellFor = cell
            case.XDayInfo:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: XDaysCVCell.identifier, for: indexPath) as? XDaysCVCell,let modelForCell =   presenter?.getXDaysCVCellInfo(indexPath: indexPath)  else { return UICollectionViewCell() }
                cell.configure(model: modelForCell)
                cellFor = cell
            case .none:
                print("2")
            }
        }
        return cellFor
    }
}
// MARK: - SearchBar Delegate
extension MainViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 2 {
        }
    }
}
