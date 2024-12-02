//
//  MainInteractor.swift
//  MyWeatherApp
//
//  Created by Анатолий Коробских on 28.11.2024.
//

import Foundation
import CoreLocation

protocol MainInteractorProtocol: AnyObject {
    var presenter: MainPresenterProtocol? { get set }
    func getLocationWeatherData()
    func getNumberOfItemsInSection() -> Int
    func getTodaysHourTempInfoCollectionViewCellInfo(indexPath: IndexPath) -> MainCellModel
    func getNumberOfSection() -> Int
}

class MainInteractor: NSObject, MainInteractorProtocol {
    
    var model = MainCellModel()
    var sectionsData = SectionsData()
    let locationManager = CLLocationManager()
    var weaterManager = WeatherManager()
    
    weak var presenter: MainPresenterProtocol?
    var delegate: WeatherManagerDelegate?
    
    override init() {
        super.init()
        setDelegates()
    }
    
    func setDelegates() {
        weaterManager.delegate = self
    }
    
    func getNumberOfSection() -> Int {
        SectionsData.MainSections.allCases.count
    }
    
    func getNumberOfItemsInSection() -> Int {
        return sectionsData.hours.count
    }
    func getTodaysHourTempInfoCollectionViewCellInfo(indexPath: IndexPath) -> MainCellModel {
        model.time = sectionsData.hours[indexPath.row]
        model.mainTemp = "2"
        return model
    }
}

// MARK: - WeatherManagerDelegate
extension MainInteractor: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        print(weather)
        presenter?.sendWeatherData()
    }
    
    func didFailWithError(error: any Error) {
        print(error)
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
