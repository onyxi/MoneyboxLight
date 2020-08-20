//
//  LoginViewController.swift
//  Moneybox-Light
//
//  Created by Pete Holdsworth on 18/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var emailTextField: LoginTextField!
    @IBOutlet weak var passwordTextField: LoginTextField!
    @IBOutlet weak var loginButton: LoginButton!

    private let presenter: LoginPresenterContract
    
    init(presenter: LoginPresenterContract) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.placeholder = localisableString(forKey: "login_screen_email_placeholder")
        emailTextField.delegate = self
        passwordTextField.placeholder = localisableString(forKey: "login_screen_password_placeholder")
        passwordTextField.delegate = self
        presenter.viewReady(self)
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        presenter.loginTapped()
    }
    
}

// MARK: LoginViewContract
extension LoginViewController: LoginViewContract {
    
    func showLoading(_ shouldShowLoading: Bool) {
        super.showLoadingOverlay(shouldShowLoading)
    }
    
    func getEmail() -> String {
        return emailTextField.text ?? ""
    }
    
    func getPassword() -> String {
        return passwordTextField.text ?? ""
    }
    
    func dismissScreen() {
        dismiss(animated: true, completion: nil)
    }
    
    func showAlert(_ configuration: AlertConfiguration) {
        let alert = AlertController.alert(with: configuration)
        present(alert, animated: true)
    }
    
}

// MARK: UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
}

    
