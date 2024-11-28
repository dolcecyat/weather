//
//  SettingsViewController.swift
//  MyWeatherApp
//
//  Created by Анатолий Коробских on 28.11.2024.
//

import Foundation
import UIKit

protocol SettingsViewProtocol: AnyObject{
    var presenter: SettingsPresenterProtocol? { get set }
}

class SettingsViewController: UIViewController {
    var presenter: SettingsPresenterProtocol?
    
    
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
    }

}

extension SettingsViewController: SettingsViewProtocol {
    
}
