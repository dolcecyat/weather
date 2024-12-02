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
    func getNumberOfSection() -> Int
    func getNumberOfItemsInSection()-> Int
    func getTodaysHourTempInfoCollectionViewCellInfo(indexPath: IndexPath) -> MainCellModel
}

class MainPresenter: MainPresenterProtocol{
    weak var view: MainViewProtocol?
    var router: MainRouterProtocol?
    var interactor: MainInteractorProtocol?
    
    init(router: MainRouterProtocol, interactor: MainInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
    // MARK: - WeatherData
    func sendWeatherData() {
        
    }
    
    func locationButtonPressed() {
        interactor?.getLocationWeatherData()
    }
    // MARK: - UICollectionVieDataSource
    func getNumberOfSection() -> Int {
        interactor?.getNumberOfSection()
    }
    
    func getNumberOfItemsInSection() -> Int {
        interactor?.getNumberOfItemsInSection() ?? 2
       
    }
    
    func getTodaysHourTempInfoCollectionViewCellInfo(indexPath: IndexPath) -> MainCellModel {
        return interactor?.getTodaysHourTempInfoCollectionViewCellInfo(indexPath: indexPath) ?? MainCellModel()
    }
}

