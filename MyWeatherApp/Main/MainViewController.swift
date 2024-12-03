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
}

protocol MainViewProtocol: AnyObject {
    var presenter: MainPresenterProtocol? { get set }
}

class MainViewController: UIViewController {
    var presenter: MainPresenterProtocol?

    //MARK: - UI properties
    
    private var TopCollectionView = UICollectionView()
    private var BottomCollectionView = UICollectionView()
    private var scrollView = UIScrollView()
    private var contentView = UIView()
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
        setDelegates()
        setUpUI()
        addingViews()
        makeConstaraints()
        setCollectionViews()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.resignFirstResponder()
    }
    
    private func setDelegates() {
        searchBar.delegate = self
        TopCollectionView.delegate = self
        TopCollectionView.dataSource = self
        BottomCollectionView.delegate = self
        BottomCollectionView.dataSource = self
    }
    // MARK: - SetUp UI
    
    private func setupNavBar() {
        navigationController?.navigationBar.barTintColor =  UIColor(cgColor: Constants.backgroundViewColor)
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = UIColor(cgColor: Constants.backgroundSearchBarColor)
        navigationController?.hidesBarsOnSwipe = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Constants.imageNameForLeftBarButtonItem), style: .plain, target: self, action: #selector(openSettings))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "location.fill"), style: .plain, target: self, action: #selector(getLocation))
        navigationItem.titleView = searchBar
        searchBar.searchTextField.backgroundColor = UIColor(cgColor: Constants.backgroundSearchBarColor)
        searchBar.sizeToFit()
    }

    func addingViews() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(TopCollectionView)
        scrollView.addSubview(BottomCollectionView)
    }
    
    func makeConstaraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        TopCollectionView.translatesAutoresizingMaskIntoConstraints = false
        BottomCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.frame = view.bounds
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+1000)
        
        NSLayoutConstraint.activate([
            TopCollectionView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 100),
            TopCollectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            
            BottomCollectionView.topAnchor.constraint(equalTo: TopCollectionView.bottomAnchor, constant: 100),
            TopCollectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor)
            ])
    }
    
    private func setUpUI() {
        self.view.backgroundColor = UIColor(cgColor: Constants.backgroundViewColor)
        TopCollectionView.backgroundColor = .clear
        TopCollectionView.bounces = false
    }
    func setCollectionViews() {
        let cVLayout = UICollectionViewLayout()
        TopCollectionView.collectionViewLayout = cVLayout
        TopCollectionView.register(FirstWeatherInfoCVCell.self, forCellWithReuseIdentifier: FirstWeatherInfoCVCell.identifier)
        TopCollectionView.register(TodaysWeatherInfoCVCell.self, forCellWithReuseIdentifier: TodaysWeatherInfoCVCell.identifier)
        TopCollectionView.register(TodaysHourTempInfoCVCell.self, forCellWithReuseIdentifier: TodaysHourTempInfoCVCell.identifier)
        
        BottomCollectionView.collectionViewLayout = cVLayout
        BottomCollectionView.register(ActivityCVCell.self, forCellWithReuseIdentifier: ActivityCVCell.identifier)
        BottomCollectionView.register(XDaysCVCell.self, forCellWithReuseIdentifier: XDaysCVCell.identifier)
    }
    
    // MARK: - NfvigationBarButton actions
    
    @objc private func openSettings() {
        
    }
    
    @objc private func getLocation() {
        presenter?.locationButtonPressed()
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
        presenter?.getNumberOfSection() ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.getNumberOfItemsInSection() ?? 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cellFor  = UICollectionViewCell()
        if collectionView == TopCollectionView {
            let sec = SectionsData.MainFirstCollectionView.allCases.first (where: { $0.sectionNumber == indexPath.section })
            switch sec {
            case .TodaysDetailInfo:
                if indexPath.row == 1 {
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FirstWeatherInfoCVCell.identifier, for: indexPath) as? FirstWeatherInfoCVCell,let modelForCell =   presenter?.getTodaysHourTempInfoCollectionViewCellInfo(indexPath: indexPath)  else { return UICollectionViewCell() }
                    cell.configure(model: modelForCell)
                    cellFor = cell
                } else {
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodaysWeatherInfoCVCell.identifier, for: indexPath) as? TodaysWeatherInfoCVCell,let modelForCell =   presenter?.getTodaysHourTempInfoCollectionViewCellInfo(indexPath: indexPath)  else { return UICollectionViewCell() }
                    cell.configure(model: modelForCell)
                    cellFor = cell }
            case .HourInfo:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodaysHourTempInfoCVCell.identifier, for: indexPath) as? TodaysHourTempInfoCVCell,let modelForCell =   presenter?.getTodaysHourTempInfoCollectionViewCellInfo(indexPath: indexPath)  else { return UICollectionViewCell() }
                cell.configure(model: modelForCell)
                cellFor = cell
            case .none: 
                print("1")
            }
            
        } else if collectionView == BottomCollectionView {
            let sec = SectionsData.MainSecondCollectionView.allCases.first (where: { $0.sectionNumber == indexPath.section })
            switch sec {
            case .ActivityInfo:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActivityCVCell.identifier, for: indexPath) as? ActivityCVCell,let modelForCell =   presenter?.getTodaysHourTempInfoCollectionViewCellInfo(indexPath: indexPath)  else { return UICollectionViewCell() }
                cell.configure(model: modelForCell)
                cellFor = cell
            case.XDayInfo:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: XDaysCVCell.identifier, for: indexPath) as? XDaysCVCell,let modelForCell =   presenter?.getTodaysHourTempInfoCollectionViewCellInfo(indexPath: indexPath)  else { return UICollectionViewCell() }
                cell.configure(model: modelForCell)
                cellFor = cell
            case .none:
                (print("2"))
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
