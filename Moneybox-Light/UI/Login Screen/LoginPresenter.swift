//
//  LoginPresenter.swift
//  Moneybox-Light
//
//  Created by Pete Holdsworth on 18/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

import Foundation

class LoginPresenter {
    
    let dao: DataAccessObject

    weak var view: LoginViewContract?
    
    init(dao: DataAccessObject) {
        self.dao = dao
    }
    
    fileprivate func login() {
        guard let view = view else { return }
        view.showLoading(true)
        dao.login(username: view.getEmail(), password: view.getPassword(), completion: loginCompleted)
    }
    
    fileprivate func loginCompleted(_ result: LoginResult) {
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
    
    private func loginFailureAlertConfiguration() -> AlertConfiguration {
        return AlertConfiguration(
            title: "Oops!",
            message: "Something went wrong",
            actions: [
                AlertConfiguration.Action(title: "Cancel", type: .cancel, completion: nil),
                AlertConfiguration.Action(title: "Retry", type: .normal, completion: { [weak self] in
                    self?.login()
                })
        ])
    }
    
}

// MARK: LoginPresenterContract
extension LoginPresenter: LoginPresenterContract {
    
    func viewReady(_ view: LoginViewContract) {
        self.view = view
    }
    
    func loginTapped() {
        login()
    }
    
}
