//
//  UserAccountsContract.swift
//  Moneybox-Light
//
//  Created by Pete Holdsworth on 18/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

import Foundation

/// UserAccountsPresenterContract is an interface for the Presenter object of the User Accounts screen
protocol UserAccountsPresenterContract: class {
    func viewReady(_ view: UserAccountsViewContract)
    func viewAppeared()
    func accountTapped(_ account: Account)
}

/// UserAccountsViewContract is an interface for the View object of the User Accounts screen
protocol UserAccountsViewContract: class {
    func showLoading(_ shouldShowLoading: Bool)
    func setGreeting(_ text: String)
    func setTotalTitle(_ text: String)
    func setTotal(_ text: String)
    func setAccountsListTitle(_ text: String)
    func setAccounts(_ accounts: [Account])
    func goToAccountDetailsScreen(_ account: Account)
    func showLoginScreen()
    func showAlert(_ configuration: AlertConfiguration)
}

