//
//  ViewController.swift
//  MyWeatherApp
//
//  Created by Анатолий Коробских on 28.11.2024.
//

import UIKit

private enum Constants {
    static let imageNameForLeftBarButtonItem = "gearshape.fill"
    static let backgroundViewColor = CGColor(red: 0.21, green: 0.37, blue: 0.48, alpha: 1)
    static let backgroundSearchBarColor = CGColor(red: 0.41, green: 0.61, blue: 0.74, alpha: 1)
    static let temperatureTextColor = CGColor(red: 0.89, green: 0.93, blue: 0.95, alpha: 1)
}

protocol MainViewProtocol: AnyObject {
    var presenter: MainPresenterProtocol? { get set }
}

class MainViewController: UIViewController {
    var presenter: MainPresenterProtocol?

    //MARK: - UI properties
    private var scrollView = UIScrollView()
    private var TopCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
//    private var BottomCollectionView = UICollectionView()
    private var mapButton = UIButton()
    private var summaryView = SummaryView()
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
        TopCollectionView.delegate = self
        TopCollectionView.dataSource = self

    }
    // MARK: - SetUp UI
    
    private func setupNavBar() {
        navigationController?.navigationBar.barTintColor =  UIColor(cgColor: Constants.backgroundViewColor)
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = UIColor(cgColor: Constants.backgroundSearchBarColor)
#warning ("при свайпе обратно не показывается")
//        navigationController?.hidesBarsOnSwipe = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Constants.imageNameForLeftBarButtonItem), style: .plain, target: self, action: #selector(openSettings))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "location.fill"), style: .plain, target: self, action: #selector(getLocation))
        navigationItem.titleView = searchBar
        searchBar.searchTextField.backgroundColor = UIColor(cgColor: Constants.backgroundSearchBarColor)
        searchBar.sizeToFit()
    }

    func addingViews() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(TopCollectionView)
        scrollView.addSubview(mapButton)
        scrollView.addSubview(summaryView)
    }
    
    func makeConstaraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        TopCollectionView.translatesAutoresizingMaskIntoConstraints = false
        mapButton.translatesAutoresizingMaskIntoConstraints = false
        summaryView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.frame = view.bounds
        scrollView.contentSize = CGSize(width:  view.frame.width, height: 2000)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            TopCollectionView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 100),
            TopCollectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            TopCollectionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            TopCollectionView.heightAnchor.constraint(equalToConstant: 500),
            TopCollectionView.widthAnchor.constraint(equalToConstant: 393),
            
            mapButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            mapButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            mapButton.widthAnchor.constraint(equalToConstant: 80),
            mapButton.heightAnchor.constraint(equalToConstant: 80),
        
            summaryView.topAnchor.constraint(equalTo: TopCollectionView.bottomAnchor, constant: 30),
            summaryView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            summaryView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
//            summaryView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 400),
            summaryView.heightAnchor.constraint(equalToConstant: 110),
            summaryView.widthAnchor.constraint(equalToConstant: 353)
            ])
    }
    
    private func setUpUI() {
        self.view.backgroundColor = UIColor(cgColor: Constants.backgroundViewColor)
        TopCollectionView.backgroundColor = .clear
        TopCollectionView.bounces = false
        
        mapButton.setTitle("Карта осадков", for: .normal)
        mapButton.titleLabel?.numberOfLines = 2
        mapButton.titleLabel?.font = .systemFont(ofSize: 17)
        mapButton.titleLabel?.textAlignment = .center
        mapButton.setTitleColor(UIColor(cgColor: Constants.temperatureTextColor), for: .normal)
        mapButton.backgroundColor = UIColor(cgColor: Constants.backgroundSearchBarColor)
        mapButton.layer.cornerRadius = 40
    }
    func setCollectionViews() {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        let firstLO = createFirstLayout()
        firstLO.configuration = config
        TopCollectionView = UICollectionView(frame: .zero, collectionViewLayout: firstLO)
        TopCollectionView.register(FirstWeatherInfoCVCell.self, forCellWithReuseIdentifier: FirstWeatherInfoCVCell.identifier)
        TopCollectionView.register(TodaysWeatherInfoCVCell.self, forCellWithReuseIdentifier: TodaysWeatherInfoCVCell.identifier)
        TopCollectionView.register(TodaysHourTempInfoCVCell.self, forCellWithReuseIdentifier: TodaysHourTempInfoCVCell.identifier)
        

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
    }
    
    @objc private func map() {

    }
}

// MARK: - CollectionView Layout
extension MainViewController {
    
}

// MARK: -
extension MainViewController: MainViewProtocol {
    
}

extension MainViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
      /*  presenter?.getNumberOfSection() ??*/ 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 6
        }else {return 24}
        
    /*    presenter?.getNumberOfItemsInSection() ??*//* 2*/
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cellFor  = UICollectionViewCell()
        if collectionView == TopCollectionView {
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
            
        } else {
            
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
