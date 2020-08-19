//
//  IndividualAccountContract.swift
//  Moneybox-Light
//
//  Created by Pete Holdsworth on 18/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

import Foundation

protocol IndividualAccountPresenterContract: class {
    func viewReady(_ view: IndividualAccountViewContract)
    func backTapped()
    func paymentButtonTapped()
}

protocol IndividualAccountViewContract: class {
    func showLoading(_ shouldShowLoading: Bool)
    func setScreenTitle(_ text: String)
    func setPlanValueTitle(_ text: String)
    func setPlanValue(_ text: String)
    func setMoneyboxValue(_ text: String)
    func setPaymentButtonTitle(_ text: String)
    func returnToPreviousScreen()
    func showLoginScreen()
    func showAlert(_ configuration: AlertConfiguration)
}
