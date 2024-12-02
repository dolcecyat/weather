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
    
    private var collectionView = UICollectionView()
    var scrollView = UIScrollView()
    var contentView = UIView()
    var searchBar = UISearchBar()
    
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
        setCollectionView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.resignFirstResponder()
    }
    
    private func setDelegates() {
        searchBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
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
        scrollView.addSubview(collectionView)
    }
    
    func makeConstaraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.frame = view.bounds
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+1000)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 100),
            collectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor)
            ])
    }
    
    private func setUpUI() {
        self.view.backgroundColor = UIColor(cgColor: Constants.backgroundViewColor)
        collectionView.backgroundColor = .clear
        collectionView.bounces = false
    }
    func setCollectionView(){
        collectionView.register(TodaysHourTempInfoCollectionViewCell.self, forCellWithReuseIdentifier: TodaysHourTempInfoCollectionViewCell.identifier)
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
        
//        switch indexPath.section {
       
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodaysHourTempInfoCollectionViewCell.identifier, for: indexPath) as? TodaysHourTempInfoCollectionViewCell,let modelForCell =   presenter?.getTodaysHourTempInfoCollectionViewCellInfo(indexPath: indexPath)  else { return UICollectionViewCell() }
        cell.configure(model: modelForCell)
        return cell
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
