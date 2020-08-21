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
    
    /**
    - Parameter presenter: the associated Presenter for the login screen
    */
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
    
    /// Notifies the Presenter object when the login button is tapped
    @IBAction func loginTapped(_ sender: Any) {
        presenter.loginTapped()
    }
    
}

// MARK: LoginViewContract
extension LoginViewController: LoginViewContract {
    
    /**
     Displays (or hides) a full screen loading overlay view with activity indicator
    - Parameter shouldShowLoading: flag to indicate if the loading view should be shown or hidden
    */
    func showLoading(_ shouldShowLoading: Bool) {
        super.showLoadingOverlay(shouldShowLoading)
    }
    
    /**
     Gets the current text entered in the Email text field
    - Returns: the text of the Email text field
    */
    func getEmail() -> String {
        return emailTextField.text ?? ""
    }
    /**
     Gets the current text entered in the Password text field
    - Returns: the text of the Password text field
    */
    func getPassword() -> String {
        return passwordTextField.text ?? ""
    }
    
    /// Dismiss the login screen
    func dismissScreen() {
        dismiss(animated: true, completion: nil)
    }
    
    /**
     Displays an alert with the given configuration
    - Parameter configuration: the configuration used to build the alert
    */
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

    
