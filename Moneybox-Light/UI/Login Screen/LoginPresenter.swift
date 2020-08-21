//
//  LoginPresenter.swift
//  Moneybox-Light
//
//  Created by Pete Holdsworth on 18/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

import Foundation

class LoginPresenter {
    
    private let dao: DataAccessObject

    weak var view: LoginViewContract?
    
    init(dao: DataAccessObject) {
        self.dao = dao
    }
    
    /// Attempts login with the server
    fileprivate func login() {
        guard let view = view else { return }
        view.showLoading(true)
        dao.login(username: view.getEmail(), password: view.getPassword(), completion: loginCompleted)
    }
    
    /**
     Handles completion of a login attempt
    - Parameter result: the result of the login attempt
    */
    func loginCompleted(_ result: LoginResult) {
        view?.showLoading(false)
        switch result {
        case .success(let loginResponse):
            dao.saveUser(user: loginResponse.user)
            dao.saveSession(session: loginResponse.session)
            view?.dismissScreen()
        case .failure:
            view?.showAlert(loginFailureAlertConfiguration())
        }
    }
    
    /**
     Provides an alert configuration for generic error state
    - Returns: alert configuration for generic error state
    */
    private func loginFailureAlertConfiguration() -> AlertConfiguration {
        return AlertConfiguration(
            title: localisableString(forKey: "alert_generic_error_title"),
            message: localisableString(forKey: "alert_generic_error_message"),
            actions: [
                AlertConfiguration.Action(title: localisableString(forKey: "alert_cancel_button"), type: .cancel, completion: nil),
                AlertConfiguration.Action(title: localisableString(forKey: "alert_retry_button"), type: .normal, completion: { [weak self] in
                    self?.login()
                })
        ])
    }
    
}

// MARK: LoginPresenterContract
extension LoginPresenter: LoginPresenterContract {
    
    /**
     called when the screen's View object is ready to be used
    - Parameter view: sreen's associated View object
    */
    func viewReady(_ view: LoginViewContract) {
        self.view = view
    }

    /// Handles taps of the login button in the View object
    func loginTapped() {
        login()
    }
    
}
