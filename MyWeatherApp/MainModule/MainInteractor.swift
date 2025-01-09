//
//  MainInteractor.swift
//  MyWeatherApp
//
//  Created by Анатолий Коробских on 28.11.2024.
//

import Foundation
import CoreLocation
import UIKit

private enum Constants {
    static let emptyModel = MainCellModel()
}

protocol MainInteractorProtocol: AnyObject {
    var presenter: MainPresenterProtocol? { get set }
    
    func getLocationWeatherData()
    func getWeatherData(_ city: String)
    func getNumberOfItemsInSection(collectionView: SectionsData.CollectionViews, section: Int) -> Int
    func getNumberOfSectionTopCV() -> Int
    func getNumberOfSectionBottomCV() -> Int
    func getTodaysHourTempInfoCollectionViewCellInfo(indexPath: IndexPath) -> MainCellModel
    func getTodaysWeatherInfoCVCellInfo(indexPath: IndexPath) -> MainCellModel
    func getActivityCVCellInfo(indexPath: IndexPath) -> MainCellModel
    func getXDaysCVCellInfo(indexPath: IndexPath) -> MainCellModel
}

class MainInteractor: NSObject, MainInteractorProtocol {
    
    let settingsManager = UDStrorageManager.shared
    var model = MainCellModel()
    var sectionsData = SectionsData()
    let locationManager = CLLocationManager()
    let dataManager = DataManager()
    var weaterManager = WeatherManager()
    var currentWeather: WeatherData?
    
    weak var presenter: MainPresenterProtocol?
    
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
    
    func getNumberOfItemsInSection(collectionView: SectionsData.CollectionViews, section: Int) -> Int {
        var numberOfRows: Int = 0
        switch collectionView {
        case .MainFirstCollectionView:
            if section == 0 {
                numberOfRows = 6
            } else {
                numberOfRows = sectionsData.hours.count
            }
        case .MainSecondCollectionView:
            if section == 0 {
                numberOfRows = SectionsData.Activity.allCases.count
            } else {
                numberOfRows = 7
            }
        }
        return numberOfRows
    }
    
    // MARK: - CellsData
    
    func getTodaysWeatherInfoCVCellInfo(indexPath: IndexPath) -> MainCellModel {
        if let currentWeather {
            let sec = SectionsData.TodaysInfoWeatherInfoCells.allCases.first (where: { $0.sectionNumber == indexPath.row })
            switch sec {
            case .mainInfo:
                model = Constants.emptyModel
                model.mainTemp = "\(getCtoFTemp(temp: currentWeather.fact.temp).description)°"
                model.mainInfo = dataManager.getConditionName(condition: currentWeather.fact.condition)
                model.detailInfo = "Ощущается как \(getCtoFTemp(temp:currentWeather.fact.feelsLike))°"
                model.conditionImage = dataManager.getConditionImage(condition: currentWeather.fact.condition)
                return model
            case .wind:
                model = Constants.emptyModel
                model.mainInfo = "Ветер \(getWindNumber(number: currentWeather.fact.windSpeed)) \(getSetting(key: SettingsData.Keys.windSettrings))"
                model.detailInfo = "Порывы до \(getWindNumber(number: currentWeather.fact.windGust)) \(getSetting(key: SettingsData.Keys.windSettrings))"
                model.conditionImage = UIImage(systemName: "arrow.2.circlepath")
                return model
            case .pressure:
                model = Constants.emptyModel
                model.mainInfo = "Давление \(currentWeather.fact.pressureMm)"
                model.detailInfo =  currentWeather.fact.pressurePa.description
                model.conditionImage = UIImage(systemName: "cloud.fill")
                return model
            case .humidity:
                model = Constants.emptyModel
                model.mainInfo = "Влажность \(currentWeather.fact.humidity)%"
                model.conditionImage = UIImage(systemName: "cloud.fill")
                return model
            case .water:
                model = Constants.emptyModel
                model.mainInfo = "Водопроницаемость \(currentWeather.fact.precStrength)"
                model.conditionImage = UIImage(systemName: "cloud.fill")
                return model
            case .UVIndex:
                model = Constants.emptyModel
                model.mainInfo = "UV индекс \(currentWeather.fact.uvIndex ?? 0)"
                model.conditionImage = UIImage(systemName: "cloud.fill")
                return model
            case .none:
                 print("error")
            }
        }
        return model
    }
    
    func getTodaysHourTempInfoCollectionViewCellInfo(indexPath: IndexPath) -> MainCellModel {
        model = Constants.emptyModel
        model.conditionImage = UIImage(systemName: "cloud.fill")
        model.time = sectionsData.hours[indexPath.row]
        model.mainTemp = "\(getCtoFTemp(temp:currentWeather?.forecasts[0].hours[indexPath.row].temp).description)°"
        return model
    }
    
    func getActivityCVCellInfo(indexPath: IndexPath) -> MainCellModel {
        model = Constants.emptyModel
        let actName = SectionsData.Activity.allCases.first(where: {$0.itemNumber == indexPath.row} )?.description
        let actImage = SectionsData.Activity.allCases.first(where: {$0.itemNumber == indexPath.row} )?.image
        model.activityImage = actImage
        model.activityName = actName
        return model
    }
    
    func getXDaysCVCellInfo(indexPath: IndexPath) -> MainCellModel {
        if let currentWeather {
            model = Constants.emptyModel
            model.dayTemp = "\( getCtoFTemp(temp:currentWeather.forecasts[indexPath.row].parts.day.tempMax).description)°"
            model.conditionImage = dataManager.getConditionImage(condition: currentWeather.forecasts[indexPath.row].parts.day.condition)
            model.nightTemp = "\( getCtoFTemp(temp:currentWeather.forecasts[indexPath.row].parts.night.tempMin).description)°"
            model.date = dataManager.getDate(from: currentWeather.forecasts[indexPath.row].date)
        }
        return model
    }
    
    private func getSetting(key: SettingsData.Keys) -> String {
        settingsManager.getSettings(key: key) ?? "0"
    }
    
    private func getWindNumber(number: Double?) -> String {
        guard let number else { return "" }
        let currennWindSet = settingsManager.getCurrentSettings(for: SettingsData.Keys.windSettrings)
        if currennWindSet == SettingsData.windGrade.kmh.rawValue {
            return number.msToKmh(ms: number)
        } else if currennWindSet == SettingsData.windGrade.milesh.rawValue {
            return number.msToMph(ms: number)
        } else if currennWindSet == SettingsData.windGrade.knots.rawValue {
            return number.msToknots(ms: number)
        } else {
            return String(format: "%.1f", number)
        }
    }
    private func getCtoFTemp(temp: Int?) -> Int {
        guard let temp else { return 0 }
        let currennTempSet = settingsManager.getCurrentSettings(for: SettingsData.Keys.tempSettrings)
        if currennTempSet == SettingsData.tempGrade.celsius.rawValue {
        return temp
        } else {
           return temp.ctof(intC: temp)
        }
    }
}

// MARK: - WeatherManagerDelegate
extension MainInteractor: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherData) {
        currentWeather = weather
        DispatchQueue.main.async { [weak self] in
            self?.presenter?.sendWeatherData()
        }
    }
    
    func getWeatherData(_ city: String) {
//        weaterManager.fetchWeather(cityName: city)
    }
    
    func getLocationWeatherData(){
        weaterManager.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func didFailWithError(error: any Error) {
        print(error)
    }
}

// MARK: - CLLocationManagerDelegate
extension MainInteractor: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weaterManager.fetchWeather(latitude:lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("error:: \(error.localizedDescription)")
       }
}
