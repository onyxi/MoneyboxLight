//
//  UserAccountsPresenter.swift
//  Moneybox-Light
//
//  Created by Pete Holdsworth on 18/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

import Foundation

class UserAccountsPresenter {
    
    private let dao: DataAccessObject
    
    weak var view: UserAccountsViewContract?
    
    init(dao: DataAccessObject) {
        self.dao = dao
    }
    
    /// Updates the greeting in the View's summary section
    fileprivate func updateGreeting() {
        if let name = dao.getUser()?.name {
            view?.setGreeting(localisableString(forKey: "user_accounts_screen_greeting_prefix") + name + "!")
        }
    }
    
    /// Attempts to fetch the user's account info from the server
    fileprivate func fetchAccounts() {
        view?.showLoading(true)
        dao.getAccounts(completion: fetchAccountsCompleted)
    }
    
    /**
     Handles completion of a accounts-fetch attempt
    - Parameter result: the result of the accounts-fetch attempt
    */
    func fetchAccountsCompleted(_ result: AccountsResult) {
        guard let view = view else { return }
        view.showLoading(false)
        switch result {
        case .failure(let dataServiceError):
            if dataServiceError == .unauthorized {
                view.setGreeting("")
                view.setTotal("")
                view.setAccounts([])
                view.showLoginScreen()
            } else {
                view.showAlert(self.dataServiceAlertConfiguration())
            }
        case .success(let accountsResponse):
            view.setTotalTitle(localisableString(forKey: "user_accounts_screen_accounts_total_title"))
            let totalPlanValue = accountsResponse.totalPlanValue
            view.setTotal(localisableString(forKey: "user_accounts_screen_accounts_total_prefix") + String(format: "%.2f", totalPlanValue))
            let accounts = accountsResponse.productResponses.map { productResponse -> Account in
                return Account(
                    productId: productResponse.investorProductId,
                    name: productResponse.product.name,
                    value: productResponse.planValue,
                    moneybox: productResponse.moneybox)
            }
            view.setAccounts(accounts)
        }
    }
    
    /**
     Provides an alert configuration for generic error state
    - Returns: alert configuration for generic error state
    */
    private func dataServiceAlertConfiguration() -> AlertConfiguration {
        return AlertConfiguration(
            title: localisableString(forKey: "alert_generic_error_title"),
            message: localisableString(forKey: "alert_generic_error_message"),
            actions: [
                AlertConfiguration.Action(title: localisableString(forKey: "alert_cancel_button"), type: .cancel, completion: nil),
                AlertConfiguration.Action(title: localisableString(forKey: "alert_retry_button"), type: .normal, completion: { [weak self] in
                    self?.fetchAccounts()
                })
        ])
        
    }
    
}

// MARK: UserAccountsPresenterContract
extension UserAccountsPresenter: UserAccountsPresenterContract {
    
    /**
     called when the screen's View object is ready to be used
    - Parameter view: screen's associated View object
    */
    func viewReady(_ view: UserAccountsViewContract) {
        self.view = view
        updateGreeting()
    }
    
    /// Attempts to update the View's greeting message and fetch account details each time the View appears on screen
    func viewAppeared() {
        updateGreeting()
        fetchAccounts()
    }
    
    /**
     Notifies the view to go to the individual account screen for a given account when tapped
    - Parameter account: the account that was tapped
    */
    func accountTapped(_ account: Account) {
        view?.goToAccountDetailsScreen(account)
    }
}

