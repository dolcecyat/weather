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
    static let backgroundSearchBarColor = CGColor(red: 0.30, green: 0.54, blue: 0.69, alpha: 1)
}

protocol MainViewProtocol: AnyObject {
    var presenter: MainPresenterProtocol? { get set }
}

class MainViewController: UIViewController, MainViewProtocol {
    var presenter: MainPresenterProtocol?

    //MARK: - UI properties
    
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

    }
    
    private func setUpUI() {
        self.view.backgroundColor = UIColor(cgColor: Constants.backgroundViewColor)
    }
    
    private func setupNavBar() {
        
        navigationController?.navigationBar.barTintColor = .clear
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Constants.imageNameForLeftBarButtonItem), style: .plain, target: self, action: #selector(openSettings))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "location.fill"), style: .plain, target: self, action: #selector(getLocation))
        navigationItem.titleView = searchBar
        searchBar.searchTextField.backgroundColor = UIColor(cgColor: Constants.backgroundSearchBarColor)
        searchBar.sizeToFit()
    }
    
    @objc private func openSettings() {
        
    }
    
    @objc private func getLocation() {
        presenter?.locationButtonPressed()
    }
    
    private func setDelegates() {
        searchBar.delegate = self
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.resignFirstResponder()
    }
}

private extension MainViewController {
    
}
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
