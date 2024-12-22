//
//  MainRouter.swift
//  MyWeatherApp
//
//  Created by Анатолий Коробских on 28.11.2024.
//

import Foundation

protocol MainRouterProtocol: AnyObject{
    var presenter: MainPresenterProtocol? { get set }
    func openSettingViewController()
}

class MainRouter: MainRouterProtocol {
    weak var presenter: MainPresenterProtocol?
    
    func openSettingViewController() {
        let VCToOpen = SettingsViewController()
        VCToOpen.closure = { [weak self] value in
            self?.presenter?.sendWeatherData()
        }
        presenter?.view?.navigationController?.pushViewController(VCToOpen, animated: true)
    }
}

