//
//  LoginContract.swift
//  Moneybox-Light
//
//  Created by Pete Holdsworth on 18/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

import Foundation

/// LoginPresenterContract is an interface for the Presenter object of the Login screen
protocol LoginPresenterContract: class {
    func viewReady(_ view: LoginViewContract)
    func loginTapped()
}

/// LoginViewContract is an interface for the View object of the Login screen
protocol LoginViewContract: class {
    func showLoading(_ shouldShowLoading: Bool)
    func getEmail() -> String
    func getPassword() -> String
    func dismissScreen()
    func showAlert(_ configuration: AlertConfiguration)
}
