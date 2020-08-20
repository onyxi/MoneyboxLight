//
//  MockUserAccountsView.swift
//  Moneybox-LightTests
//
//  Created by Pete Holdsworth on 20/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

@testable import Moneybox_Light

class MockUserAccountsView: UserAccountsViewContract {
    
    var showLoading_calls = 0
    var showLoading_shouldShowLoading: Bool?
    func showLoading(_ shouldShowLoading: Bool) {
        showLoading_calls += 1
        showLoading_shouldShowLoading = shouldShowLoading
    }
    
    var setGreeting_calls = 0
    var setGreeting_text: String?
    func setGreeting(_ text: String) {
        setGreeting_calls += 1
        setGreeting_text = text
    }
    
    var setTotalTitle_calls = 0
    var setTotalTitle_text: String?
    func setTotalTitle(_ text: String) {
        setTotalTitle_calls += 1
        setTotalTitle_text = text
    }
    
    var setTotal_calls = 0
    var setTotal_text: String?
    func setTotal(_ text: String) {
        setTotal_calls += 1
        setTotal_text = text
    }
    
    var setAccountsListTitle_calls = 0
    var setAccountsListTitle_text: String?
    func setAccountsListTitle(_ text: String) {
        setAccountsListTitle_calls += 1
        setAccountsListTitle_text = text
    }
    
    var setAccounts_calls = 0
    var setAccounts_accounts: [Account]?
    func setAccounts(_ accounts: [Account]) {
        setAccounts_calls += 1
        setAccounts_accounts = accounts
    }
    
    var goToAccountDetailsScreen_calls = 0
    var goToAccountDetailsScreen_account: Account?
    func goToAccountDetailsScreen(_ account: Account) {
        goToAccountDetailsScreen_calls += 1
        goToAccountDetailsScreen_account = account
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
