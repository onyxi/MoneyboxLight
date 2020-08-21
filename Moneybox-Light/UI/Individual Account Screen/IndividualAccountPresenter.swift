//
//  IndividualAccountPresenter.swift
//  Moneybox-Light
//
//  Created by Pete Holdsworth on 18/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

import Foundation

class IndividualAccountPresenter {
    
    private let account: Account
    private let dao: DataAccessObject
    
    weak var view: IndividualAccountViewContract?
    
    private(set) var currentMoneyboxValue: Double
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
    
    /// Attempts to make a one-off payment to the moneybox for the viewed account
    fileprivate func makeOneOffPayment() {
        view?.showLoading(true)
        dao.makeOneOffPayment(account: account, amount: oneOffPaymentAmount, completion: oneOffPaymentCompleted)
    }
    
    /**
     Handles completion of a one-off-payment attempt
    - Parameter result: the result of the one-off-payment attempt
    */
    func oneOffPaymentCompleted(_ result: PaymentResult) {
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
                    self?.makeOneOffPayment()
                })
        ])
    }
    
}

// MARK: IndividualAccountPresenterContract
extension IndividualAccountPresenter: IndividualAccountPresenterContract {
    
    /**
     called when the screen's View object is ready to be used
    - Parameter view: screen's associated View object
    */
    func viewReady(_ view: IndividualAccountViewContract) {
        self.view = view
        updateView()
    }
    
    /// Notifes the screen's View object to navigate to the previous sreen when the 'back' button is tapped
    func backTapped() {
        view?.returnToPreviousScreen()
    }
    
    /// Attempts to make a one-off payment to the moneybox for the viewed account when the payment buttojn is tapped
    func paymentButtonTapped() {
        makeOneOffPayment()
    }
    
}
