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
}

class MainInteractor: NSObject, MainInteractorProtocol, WeatherManagerDelegate {
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
