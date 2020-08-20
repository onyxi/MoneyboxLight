//
//  MockIndividualAccountView.swift
//  Moneybox-LightTests
//
//  Created by Pete Holdsworth on 20/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

@testable import Moneybox_Light

class MockIndividualAccountView: IndividualAccountViewContract {
    
    var showLoading_calls = 0
    var showLoading_shouldShowLoading: Bool?
    func showLoading(_ shouldShowLoading: Bool) {
        showLoading_calls += 1
        showLoading_shouldShowLoading = shouldShowLoading
    }
    
    var setScreenTitle_calls = 0
    var setScreenTitle_text: String?
    func setScreenTitle(_ text: String) {
        setScreenTitle_calls += 1
        setScreenTitle_text = text
    }
    
    var setPlanValueTitle_calls = 0
    var setPlanValueTitle_text: String?
    func setPlanValueTitle(_ text: String) {
        setPlanValueTitle_calls += 1
        setPlanValueTitle_text = text
    }
    
    var setPlanValue_calls = 0
    var setPlanValue_text: String?
    func setPlanValue(_ text: String) {
        setPlanValue_calls += 1
        setPlanValue_text = text
    }
    
    var setMoneyboxValue_calls = 0
    var setMoneyboxValue_text: String?
    func setMoneyboxValue(_ text: String) {
        setMoneyboxValue_calls += 1
        setMoneyboxValue_text = text
    }
    
    var setPaymentButtonTitle_calls = 0
    var setPaymentButtonTitle_text: String?
    func setPaymentButtonTitle(_ text: String) {
        setPaymentButtonTitle_calls += 1
        setPaymentButtonTitle_text = text
    }
    
    var returnToPreviousScreen_calls = 0
    func returnToPreviousScreen() {
        returnToPreviousScreen_calls += 1
    }
    
    var showLoginScreen_calls = 0
    func showLoginScreen() {
        showLoginScreen_calls += 1
    }
    
    var showAlert_calls = 0
    var showAlert_configuration: AlertConfiguration?
    func showAlert(_ configuration: AlertConfiguration) {
        showAlert_calls += 1
        showAlert_configuration = configuration
    }
    
    
}
