//
//  SettingsViewController.swift
//  MyWeatherApp
//
//  Created by Анатолий Коробских on 28.11.2024.
//

import Foundation
import UIKit

private enum Constants{
    static let navigationBarTitle = "Настройки"
}

protocol SettingsViewProtocol: AnyObject{
    var presenter: SettingsPresenterProtocol? { get set }
}

class SettingsViewController: UIViewController {
    var presenter: SettingsPresenterProtocol?
    
    // MARK: UI properties
    private var scrollView = UIScrollView()
    private var contentView = UIView()
    private var parView = WindView()
    private var modeView = UIView()
    private var designView = UIView()
    private var helpInfoTableView = UITableView()
    
    // MARK: - Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    private func setup() {
        SettingsModuleBuilder.build(self)
        setupNavBar()
//        setDelegates()
        addingViews()
        makeConstaraints()
        setUpUI()
//        setUpActions()
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.barTintColor = SettingsColors.backgroundViewColor
        navigationController?.navigationBar.tintColor = SettingsColors.textColor
        navigationItem.title = Constants.navigationBarTitle
    }

    private func addingViews() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(parView)
    }
    
    private func makeConstaraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        parView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            parView.topAnchor.constraint(equalTo: contentView.topAnchor),
            parView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            parView.widthAnchor.constraint(equalToConstant: 393),
            ])
        
    }
    private func setUpUI() {
        self.view.backgroundColor = SettingsColors.backgroundViewColor

    }

    
}

extension SettingsViewController: SettingsViewProtocol {
    
}
