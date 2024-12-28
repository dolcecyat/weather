//
//  AuthRouter.swift
//  MyWeatherApp
//
//  Created by Алина Класс on 28.12.2024.
//

import Foundation

protocol AuthRouterProtocol: AnyObject {
    var presenter: AuthPresenterProtocol? { get set }
}

class AuthRouter: AuthRouterProtocol {
    weak var presenter: AuthPresenterProtocol?
}
