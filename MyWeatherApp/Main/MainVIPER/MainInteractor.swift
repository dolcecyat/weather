//
//  MainInteractor.swift
//  MyWeatherApp
//
//  Created by Анатолий Коробских on 28.11.2024.
//

import Foundation
import CoreLocation
import UIKit

protocol MainInteractorProtocol: AnyObject {
    var presenter: MainPresenterProtocol? { get set }
    func getLocationWeatherData()
    func getWeatherData(_ city: String)
    func getNumberOfItemsInSection() -> Int
    func getNumberOfSectionTopCV() -> Int
    func getNumberOfSectionBottomCV() -> Int
    func getTodaysHourTempInfoCollectionViewCellInfo(indexPath: IndexPath) -> MainCellModel
    func getFirstWeatherInfoCVCellInfo(indexPath: IndexPath) -> MainCellModel
    func getTodaysWeatherInfoCVCellInfo(indexPath: IndexPath) -> MainCellModel
    func getActivityCVCellInfo(indexPath: IndexPath) -> MainCellModel
    func getXDaysCVCellInfo(indexPath: IndexPath) -> MainCellModel
}

class MainInteractor: NSObject, MainInteractorProtocol {
    
    var model = MainCellModel()
    var sectionsData = SectionsData()
    let locationManager = CLLocationManager()
    var weaterManager = WeatherManager()
    var currentWeather = WeatherModel(conditionId: 200, cityName: "", temperature: 1)
    
    weak var presenter: MainPresenterProtocol?
    var delegate: WeatherManagerDelegate?
    
    override init() {
        super.init()
        setDelegates()
    }
    
    func setDelegates() {
        weaterManager.delegate = self
    }
    
    func getNumberOfSectionTopCV() -> Int {
        SectionsData.MainFirstCollectionView.allCases.count
    }
    
    func getNumberOfSectionBottomCV() -> Int {
        SectionsData.MainSecondCollectionView.allCases.count
    }
    
    func getNumberOfItemsInSection() -> Int {
        return sectionsData.hours.count
    }
    
    // MARK: - CellsData
    
    func getFirstWeatherInfoCVCellInfo(indexPath: IndexPath) -> MainCellModel {
        model.mainTemp = "4"/*String(currentWeather.temperature)*/
        model.mainInfo = "Aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
        model.detailInfo = "Aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
        model.image = UIImage(systemName: "cloud.fill")
        return model
    }
    
    func getTodaysWeatherInfoCVCellInfo(indexPath: IndexPath) -> MainCellModel {
        model.image = UIImage(systemName: "cloud.fill")
        model.mainInfo = "Aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
        model.detailInfo = "Aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
        return model
    }
    
    func getTodaysHourTempInfoCollectionViewCellInfo(indexPath: IndexPath) -> MainCellModel {
        model.image = UIImage(systemName: "cloud.fill")
        model.time = sectionsData.hours[indexPath.row]
        model.mainTemp = "2°"
        return model
    }
    
    func getActivityCVCellInfo(indexPath: IndexPath) -> MainCellModel {
        let actName = SectionsData.Activity.allCases.first(where: {$0.itemNumber == indexPath.row} )?.description
        let actImage = SectionsData.Activity.allCases.first(where: {$0.itemNumber == indexPath.row} )?.image
        model.activityImage = actImage
        model.activityName = actName
        return model
    }
    
    func getXDaysCVCellInfo(indexPath: IndexPath) -> MainCellModel {
        model.dayTemp = currentWeather.tempString
        model.image = UIImage(systemName: "cloud.fill")
        model.nightTemp = "4"
        model.date = "2 декабря"
        return model
    }
}

// MARK: - WeatherManagerDelegate
extension MainInteractor: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        currentWeather = weather
        print(weather)
        DispatchQueue.main.async { [weak self] in
            self?.presenter?.sendWeatherData()
        }
    }
    
    func didFailWithError(error: any Error) {
        print(error)
    }
    
    func getWeatherData(_ city: String) {
        weaterManager.fetchWeather(cityName: city)
    }
    
    func getLocationWeatherData(){
        weaterManager.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
}

// MARK: - CLLocationManagerDelegate
extension MainInteractor: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weaterManager.fetchWeather(latitude:lat, longitute: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("error:: \(error.localizedDescription)")
       }
}
