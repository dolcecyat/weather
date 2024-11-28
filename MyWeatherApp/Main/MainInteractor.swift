//
//  MainInteractor.swift
//  MyWeatherApp
//
//  Created by Анатолий Коробских on 28.11.2024.
//

import Foundation

protocol MainInteractorProtocol: AnyObject {
    var presenter: MainPresenterProtocol? { get set }
}

class MainInteractor: MainInteractorProtocol {
    weak var presenter: MainPresenterProtocol?
}
