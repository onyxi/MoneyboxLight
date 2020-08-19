//
//  UserAccountsPresenter.swift
//  Moneybox-Light
//
//  Created by Pete Holdsworth on 18/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

import Foundation

class UserAccountsPresenter {
    
    let dao: DataAccessObject
    
    weak var view: UserAccountsViewContract?
    
    init(dao: DataAccessObject) {
        self.dao = dao
    }
    
    func updateGreeting() {
        if let name = dao.getUser()?.name {
            view?.setGreeting(localisableString(forKey: "user_accounts_screen_greeting_prefix") + name)
        }
    }
    
    func fetchAccounts() {
        view?.showLoading(true)
        dao.getAccounts(completion: fetchAccountsCompleted)
    }
    
    fileprivate func fetchAccountsCompleted(_ result: AccountsResult) {
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
            view.setTotalTitle(localisableString(forKey: "individual_account_screen_plan_value_title"))
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
    
    private func dataServiceAlertConfiguration() -> AlertConfiguration {
        return AlertConfiguration(
            title: "Oops!",
            message: "Something went wrong",
            actions: [
                AlertConfiguration.Action(title: "Cancel", type: .cancel, completion: nil),
                AlertConfiguration.Action(title: "Retry", type: .normal, completion: { [weak self] in
                    self?.fetchAccounts()
                })
        ])
        
    }
    
}

// MARK: UserAccountsPresenterContract
extension UserAccountsPresenter: UserAccountsPresenterContract {
    
    func viewReady(_ view: UserAccountsViewContract) {
        self.view = view
        updateGreeting()
    }
    
    func viewAppeared() {
        updateGreeting()
        fetchAccounts()
    }
    
    func accountTapped(_ account: Account) {
        view?.goToAccountDetailsScreen(account)
    }
}

