//
//  MainPresenter.swift
//  MyWeatherApp
//
//  Created by Анатолий Коробских on 28.11.2024.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    var view: MainViewProtocol? { get set }
    var router: MainRouterProtocol? { get set}
    var interactor: MainInteractorProtocol? { get set }
    func locationButtonPressed()
    func sendWeatherData()
}

class MainPresenter: MainPresenterProtocol{
    weak var view: MainViewProtocol?
    var router: MainRouterProtocol?
    var interactor: MainInteractorProtocol?
    
    init(router: MainRouterProtocol, interactor: MainInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    func sendWeatherData() {
        
    }
    
    func locationButtonPressed() {
        interactor?.getLocationWeatherData()
    }
}

