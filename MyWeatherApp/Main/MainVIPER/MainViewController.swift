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

protocol MainViewProtocol: UIViewController {
    var presenter: MainPresenterProtocol? { get set }
    func updateData()
}

class MainViewController: UIViewController {
    var presenter: MainPresenterProtocol?

    //MARK: - UI properties
     
    private var contentView = UIView()
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
        makeConstraints()
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
        navigationController?.navigationBar.barTintColor =  UIColor(cgColor: MainColors.backgroundViewColor)
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = UIColor(cgColor: MainColors.lighterBackgroundColor)
//        navigationController?.hidesBarsOnSwipe = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Constants.imageNameForLeftBarButtonItem), style: .plain, target: self, action: #selector(openSettings))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Constants.imageNameForRightBarButtonItem), style: .plain, target: self, action: #selector(getLocation))
        navigationItem.titleView = searchBar
        searchBar.searchTextField.backgroundColor = UIColor(cgColor: MainColors.lighterBackgroundColor)
        searchBar.sizeToFit()
    }

    func addingViews() {
        self.view.addSubview(scrollView)
//        contentView.addSubview(scrollView)
        scrollView.addSubview(mapButton)
        scrollView.addSubview(topCollectionView)
        scrollView.addSubview(summaryView)
        scrollView.addSubview(bottomCollectionView)
        scrollView.addSubview(monthButton)
    }
    
    func makeConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        mapButton.translatesAutoresizingMaskIntoConstraints = false
        topCollectionView.translatesAutoresizingMaskIntoConstraints = false
        summaryView.translatesAutoresizingMaskIntoConstraints = false
        bottomCollectionView.translatesAutoresizingMaskIntoConstraints = false
        monthButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Ограничения для scrollView
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            mapButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            mapButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            mapButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -300),
            mapButton.heightAnchor.constraint(equalToConstant: 80),
            
            // Пример для topCollectionView
            topCollectionView.topAnchor.constraint(equalTo: mapButton.bottomAnchor, constant: 20),
            topCollectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            topCollectionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: 10),
            topCollectionView.heightAnchor.constraint(equalToConstant: 500),
            
            // Пример для summaryView
            summaryView.topAnchor.constraint(equalTo: topCollectionView.bottomAnchor, constant: 20),
            summaryView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            summaryView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            summaryView.heightAnchor.constraint(equalToConstant: 110),
            
            // Пример для bottomCollectionView
            bottomCollectionView.topAnchor.constraint(equalTo: summaryView.bottomAnchor, constant: 20),
            bottomCollectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            bottomCollectionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: 10),
            bottomCollectionView.heightAnchor.constraint(equalToConstant: 690),
            
            // Последний элемент привязан к scrollView.bottomAnchor
            monthButton.topAnchor.constraint(equalTo: bottomCollectionView.bottomAnchor, constant: 20),
            monthButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            monthButton.heightAnchor.constraint(equalToConstant: 70),
            monthButton.widthAnchor.constraint(equalToConstant: 250),
            monthButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
        ])
    }
    
    private func setUpUI() {
        self.view.backgroundColor = UIColor(cgColor: MainColors.backgroundViewColor)
        topCollectionView.backgroundColor = .clear
        topCollectionView.bounces = false
      
        bottomCollectionView.backgroundColor = .clear
        bottomCollectionView.bounces = false
        bottomCollectionView.isScrollEnabled = false
        
        mapButton.setTitle(Constants.mapButtonLabel, for: .normal)
        mapButton.titleLabel?.font = .systemFont(ofSize: 17)
        mapButton.titleLabel?.numberOfLines = 2
        mapButton.titleLabel?.textAlignment = .center
        mapButton.setTitleColor(UIColor(cgColor: MainColors.lighterTextColor), for: .normal)
        mapButton.backgroundColor = UIColor(cgColor: MainColors.lighterBackgroundColor)
        mapButton.layer.cornerRadius = 40
        
        monthButton.setTitle(Constants.monthWeatherButtonLabel, for: .normal)
        monthButton.titleLabel?.font = .systemFont(ofSize: 18)
        monthButton.titleLabel?.textAlignment = .center
        monthButton.setTitleColor(UIColor(cgColor: MainColors.lighterTextColor), for: .normal)
        monthButton.backgroundColor = UIColor(cgColor: MainColors.lighterBackgroundColor)
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
        presenter?.openSettingViewController()
    }
    
    @objc private func getLocation() {
        presenter?.locationButtonPressed()
    }

    // MARK: - Button actions
    
    private func setUpActions() {
        mapButton.addTarget(self, action: #selector(openMap), for: .touchUpInside)
        monthButton.addTarget(self, action: #selector(monthWeather), for: .touchUpInside)
    }
    
    @objc private func openMap() {

    }
    @objc private func monthWeather() {

    }
}

// MARK: - CollectionView Layout
extension MainViewController {
    
}

// MARK: -
extension MainViewController: MainViewProtocol {
    
    func updateData() {
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
            let sec = SectionsData.MainFirstCollectionView.allCases.first (where: { $0.sectionNumber == section })
            switch sec {
            case .TodaysDetailInfo:
                numberOfRows = presenter?.getNumberOfItemsInSection(collectionView: SectionsData.CollectionViews.MainFirstCollectionView, section: 0) ?? 1
            default :
                numberOfRows = presenter?.getNumberOfItemsInSection(collectionView: SectionsData.CollectionViews.MainFirstCollectionView, section: 1) ?? 1
            }
        } else if collectionView == bottomCollectionView {
            let sec = SectionsData.MainSecondCollectionView.allCases.first (where: { $0.sectionNumber == section })
            switch sec {
            case .ActivityInfo:
                numberOfRows = presenter?.getNumberOfItemsInSection(collectionView: SectionsData.CollectionViews.MainSecondCollectionView, section: 0) ?? 1
            default :
                numberOfRows = presenter?.getNumberOfItemsInSection(collectionView: SectionsData.CollectionViews.MainSecondCollectionView, section: 1) ?? 1
            }
        }
        return numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cellFor  = UICollectionViewCell()
        if collectionView == topCollectionView {
            let sec = SectionsData.MainFirstCollectionView.allCases.first (where: { $0.sectionNumber == indexPath.section })
            switch sec {
            case .TodaysDetailInfo:
                switch indexPath.item {
                case 0:
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FirstWeatherInfoCVCell.identifier, for: indexPath) as? FirstWeatherInfoCVCell, let modelForCell =   presenter?.getTodaysWeatherInfoCVCellInfo(indexPath: indexPath)  else { return UICollectionViewCell() }
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
        if let city = searchBar.searchTextField.text {
            presenter?.getWeatherData(city)
        }
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
  
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let city = searchBar.searchTextField.text {
            presenter?.getWeatherData(city)
        }
        searchBar.text = ""
    }
}
