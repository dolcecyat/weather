//
//  SettingsViewController.swift
//  MyWeatherApp
//
//  Created by Анатолий Коробских on 28.11.2024.
//

import Foundation
import UIKit

private enum Constants {
    static let navigationBarTitle = "Настройки"
}

protocol SettingsViewProtocol: AnyObject{
    var presenter: SettingsPresenterProtocol? { get set }
}

class SettingsViewController: UIViewController {
    var presenter: SettingsPresenterProtocol?
    
    // MARK: UI properties
    private var scrollView = UIScrollView()
    private var tempView = ParametersView()
    private var windView = WindView()
    private var pressureView = PressureView()
    private var modeView = ModeView()
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
        scrollView.addSubview(tempView)
        scrollView.addSubview(windView)
        scrollView.addSubview(pressureView)
        scrollView.addSubview(modeView)
    }
    
    private func makeConstaraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        tempView.translatesAutoresizingMaskIntoConstraints = false
        windView.translatesAutoresizingMaskIntoConstraints = false
        pressureView.translatesAutoresizingMaskIntoConstraints = false
        modeView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.frame = view.bounds
        scrollView.contentSize = CGSize(width:  view.frame.width, height: 1000)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tempView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            tempView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 10),
            tempView.widthAnchor.constraint(equalToConstant: 373),
            tempView.heightAnchor.constraint(equalToConstant: 110),
            
            windView.topAnchor.constraint(equalTo: tempView.bottomAnchor,constant: 20),
            windView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 10),
            windView.widthAnchor.constraint(equalToConstant: 373),
            windView.heightAnchor.constraint(equalToConstant: 115),
            
            pressureView.topAnchor.constraint(equalTo: windView.bottomAnchor,constant: 20),
            pressureView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 10),
            pressureView.widthAnchor.constraint(equalToConstant: 373),
            pressureView.heightAnchor.constraint(equalToConstant: 115),
            
            modeView.topAnchor.constraint(equalTo: pressureView.bottomAnchor,constant: 20),
            modeView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 10),
            modeView.widthAnchor.constraint(equalToConstant: 373),
            modeView.heightAnchor.constraint(equalToConstant: 115),
        ])
    }
    private func setUpUI() {
        self.view.backgroundColor = SettingsColors.backgroundViewColor
        tempView.roundCorners(view: tempView)
        windView.roundCorners(view: windView)
        pressureView.roundCorners(view: pressureView)
        modeView.roundCorners(view: modeView)
    }
}

extension SettingsViewController: SettingsViewProtocol {
    
}
