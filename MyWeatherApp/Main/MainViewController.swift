//
//  ViewController.swift
//  MyWeatherApp
//
//  Created by Анатолий Коробских on 28.11.2024.
//

import UIKit

protocol MainViewProtocol: AnyObject{
    var presenter: MainPresenterProtocol? { get set }
}

class MainViewController: UIViewController {
    var presenter: MainPresenterProtocol?
    
    
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
        MainModuleBuilder.build(self)
    }

}

extension MainViewController: MainViewProtocol {
    
}
