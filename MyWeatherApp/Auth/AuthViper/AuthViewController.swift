//
//  AuthViewController.swift
//  MyWeatherApp
//
//  Created by Алина Класс on 28.12.2024.
//

import Foundation
import UIKit

protocol AuthViewProtocol: AnyObject {
    var presenter: AuthPresenterProtocol? { get set }
}

class AuthViewController: UIViewController, AuthViewProtocol {
    var presenter: AuthPresenterProtocol?

    let toppPddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
    let bottomPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))

    private let loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Login"
        textField.textColor = .black
        textField.layer.cornerRadius = 10
        textField.backgroundColor = .lightGray
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.autocapitalizationType = .none
        return textField
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.textColor = .black
        textField.layer.cornerRadius = 10
        textField.backgroundColor = .lightGray
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.autocapitalizationType = .none
        return textField
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        return button
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        return button
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AuthModuleBuilder.build(self)
        setup()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        passwordTextField.resignFirstResponder()
        loginTextField.resignFirstResponder()
    }
    private func setup() {
        addViews()
        setDelegates()
        setConstraints()
        setUI()
        setUpActions()
    }
    
    private func setDelegates() {
        loginTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func addViews() {
        self.view.addSubview(loginTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(loginButton)
        self.view.addSubview(signUpButton)
    }
    
    private func setConstraints() {
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            loginTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            loginTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 20),
            passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            signUpButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
    private func setUI() {
        view.backgroundColor = .white
        
        loginTextField.leftView = toppPddingView
        loginTextField.leftViewMode = .always
        passwordTextField.leftView = bottomPaddingView
        passwordTextField.leftViewMode = .always
    }
    
    private func setUpActions() {
        loginButton.addTarget(self, action: #selector(logInButtonPressed), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)

    }
    
    @objc private func logInButtonPressed() {
        presenter?.logInButtonPressed(login: loginTextField.text ?? "" ,password: passwordTextField.text ?? "")
    }
    
    @objc private func signUpButtonPressed() {
        presenter?.signUpButtonPressed()
    }
}

extension AuthViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
