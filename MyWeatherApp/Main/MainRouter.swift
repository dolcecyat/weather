//
//  MainRouter.swift
//  MyWeatherApp
//
//  Created by Анатолий Коробских on 28.11.2024.
//

import Foundation

protocol MainRouterProtocol: AnyObject{
    var presenter: MainPresenterProtocol? { get set }
}

class MainRouter: MainRouterProtocol {
    weak var presenter: MainPresenterProtocol?
}
