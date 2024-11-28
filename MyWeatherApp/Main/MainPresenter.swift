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
    var interactior: MainInteractorProtocol? { get set }
}

class MainPresenter: MainPresenterProtocol{
    weak var view: MainViewProtocol?
    var router: MainRouterProtocol?
    var interactior: MainInteractorProtocol?
    
    init(router: MainRouterProtocol, interactior: MainInteractorProtocol) {
        self.router = router
        self.interactior = interactior
    }
}

