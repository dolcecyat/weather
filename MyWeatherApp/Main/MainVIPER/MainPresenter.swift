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
    func openSettingViewController()
    func locationButtonPressed()
    func getWeatherData(_ city: String)
    func sendWeatherData()
    func getNumberOfSectionTopCV() -> Int
    func getNumberOfSectionBottomCV() -> Int
    func getNumberOfItemsInSection()-> Int
    func getTodaysHourTempInfoCollectionViewCellInfo(indexPath: IndexPath) -> MainCellModel
    func getFirstWeatherInfoCVCellInfo(indexPath: IndexPath) -> MainCellModel
    func getTodaysWeatherInfoCVCellInfo(indexPath: IndexPath) -> MainCellModel
    func getActivityCVCellInfo(indexPath: IndexPath) -> MainCellModel
    func getXDaysCVCellInfo(indexPath: IndexPath) -> MainCellModel
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
        view?.reloadData()
    }
    func openSettingViewController() {
        router?.openSettingViewController()
    }
    
    func locationButtonPressed() {
        interactor?.getLocationWeatherData()
    }
    
    func getWeatherData(_ city: String) {
        interactor?.getWeatherData(city)
    }
    // MARK: - UICollectionVieDataSource
    func getNumberOfSectionTopCV() -> Int {
        interactor?.getNumberOfSectionTopCV() ?? .zero
    }
    func getNumberOfSectionBottomCV() -> Int {
        interactor?.getNumberOfSectionBottomCV() ?? .zero
    }

    func getNumberOfItemsInSection() -> Int {
        interactor?.getNumberOfItemsInSection() ?? 2
       
    }
    // MARK: - Cells Info
    
    func getFirstWeatherInfoCVCellInfo(indexPath: IndexPath) -> MainCellModel {
        return interactor?.getFirstWeatherInfoCVCellInfo(indexPath: indexPath) ?? MainCellModel()
    }
    
    func getTodaysWeatherInfoCVCellInfo(indexPath: IndexPath) -> MainCellModel {
        return interactor?.getTodaysWeatherInfoCVCellInfo(indexPath: indexPath) ?? MainCellModel()
    }
    
    func getTodaysHourTempInfoCollectionViewCellInfo(indexPath: IndexPath) -> MainCellModel {
        return interactor?.getTodaysHourTempInfoCollectionViewCellInfo(indexPath: indexPath) ?? MainCellModel()
    }
    
    func getActivityCVCellInfo(indexPath: IndexPath) -> MainCellModel {
        return interactor?.getActivityCVCellInfo(indexPath: indexPath) ?? MainCellModel()
    }
    
    func getXDaysCVCellInfo(indexPath: IndexPath) -> MainCellModel {
        return interactor?.getXDaysCVCellInfo(indexPath: indexPath) ?? MainCellModel()
    }
}

