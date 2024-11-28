//
//  ViewController.swift
//  MyWeatherApp
//
//  Created by Анатолий Коробских on 28.11.2024.
//

import UIKit
enum Constants {
    static let imageNameForLeftBarButtonItem = "gearshape.fill"
}
protocol MainViewProtocol: AnyObject{
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
    }
    
    private func setupNavBar() {
        self.navigationController?.navigationBar.barTintColor = .clear
        self.navigationController?.navigationBar.tintColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Constants.imageNameForLeftBarButtonItem), style: .plain, target: self, action: #selector(openSettings))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "location.fill"), style: .plain, target: self, action: #selector(getLocation))
        navigationItem.titleView = searchBar
    }
    
    @objc private func openSettings() {
        
    }
    
    @objc private func getLocation() {
        
    }
    
    private func setDelegates() {
        searchBar.delegate = self
    }
}

private extension MainViewController {
    
}
extension MainViewController: UISearchBarDelegate {
}
