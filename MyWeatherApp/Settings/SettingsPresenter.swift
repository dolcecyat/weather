//
//  SettingsPresenter.swift
//  MyWeatherApp
//
//  Created by Анатолий Коробских on 28.11.2024.
//

import Foundation

protocol SettingsChangeDelegate: AnyObject {
    func didChangeSettings(value: String,key: SettingsData.Keys)
    func getCurrentSettings(for key: SettingsData.Keys) -> String
}

protocol SettingsPresenterProtocol: AnyObject {
    var view: SettingsViewProtocol? { get set }
    var router: SettingsRouterProtocol? { get set}
    var interactor: SettingsInteractorProtocol? { get set }
}

class SettingsPresenter: SettingsPresenterProtocol, SettingsChangeDelegate {
    
    weak var view: SettingsViewProtocol?
    var router: SettingsRouterProtocol?
    var interactor: SettingsInteractorProtocol?
    
    init(router: SettingsRouterProtocol, interactor: SettingsInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
    func didChangeSettings(value: String, key: SettingsData.Keys) {
        interactor?.didChangeSettings(value: value, key: key)
        print("try save")
    }
    
    func getCurrentSettings(for key: SettingsData.Keys) -> String {
        return interactor?.getCurrentSettings(for: key) ?? "1"
    }
}
//extension SettingsPresenter: SettingsDelegate {
//    // возможно можно сделать отдельный менеджер
//    func didChangeSettings(value: String, key: SettingsData.Keys){
//        interactor?.didChangeSettings(value: value, key: key)
//    }
//    
//    func getCurrentSettings(for key: SettingsData.Keys) -> String {
//        return interactor?.getCurrentSettings(for: key) ?? "0"
//    }
//}

