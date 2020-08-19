//
//  IndividualAccountPresenter.swift
//  Moneybox-Light
//
//  Created by Pete Holdsworth on 18/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

import Foundation

class IndividualAccountPresenter {
    
    let account: Account
    let dao: DataAccessObject
    
    weak var view: IndividualAccountViewContract?
    
    var currentMoneyboxValue: Double
    let oneOffPaymentAmount = 10
    
    init(account: Account, dao: DataAccessObject) {
        self.account = account
        self.dao = dao
        currentMoneyboxValue = account.moneybox
    }

    fileprivate func updateView() {
        view?.setScreenTitle(account.name)
        view?.setPlanValue(localisableString(forKey: "individual_account_screen_plan_value_prefix") + String(format: "%.2f", account.value))
        view?.setMoneyboxValue(localisableString(forKey: "individual_account_screen_plan_moneybox_prefix") + String(format: "%.2f", currentMoneyboxValue))
        view?.setPaymentButtonTitle(localisableString(forKey: "individual_account_screen_payment_button_title_prefix") + String(oneOffPaymentAmount))
    }
    
    fileprivate func makeOneOffPayment() {
        view?.showLoading(true)
        dao.makeOneOffPayment(account: account, amount: oneOffPaymentAmount, completion: oneOffPaymentCompleted)
    }
    
    fileprivate func oneOffPaymentCompleted(_ result: PaymentResult) {
        view?.showLoading(false)
        switch result {
        case .success(let paymentResponse):
            currentMoneyboxValue = paymentResponse.moneybox
            updateView()
        case .failure(let dataServiceError):
            if dataServiceError == .unauthorized {
                view?.showLoginScreen()
            } else {
                view?.showAlert(self.dataServiceAlertConfiguration())
            }
        }
    }
    
    private func dataServiceAlertConfiguration() -> AlertConfiguration {
        return AlertConfiguration(
            title: "Oops!",
            message: "Something went wrong",
            actions: [
                AlertConfiguration.Action(title: "Cancel", type: .cancel, completion: nil),
                AlertConfiguration.Action(title: "Retry", type: .normal, completion: { [weak self] in
                    self?.makeOneOffPayment()
                })
        ])
    }
    
}

// MARK: IndividualAccountPresenterContract
extension IndividualAccountPresenter: IndividualAccountPresenterContract {
    
    func viewReady(_ view: IndividualAccountViewContract) {
        self.view = view
        updateView()
    }
    
    func backTapped() {
        view?.returnToPreviousScreen()
    }
    
    func paymentButtonTapped() {
        makeOneOffPayment()
    }
    
}
