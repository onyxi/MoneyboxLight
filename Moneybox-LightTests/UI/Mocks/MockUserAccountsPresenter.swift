//
//  MockUserAccountsPresenter.swift
//  Moneybox-LightTests
//
//  Created by Pete Holdsworth on 20/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

@testable import Moneybox_Light

class MockUserAccountsPresenter: UserAccountsPresenterContract {
    
    var viewReady_calls = 0
    var viewReady_view: UserAccountsViewContract?
    func viewReady(_ view: UserAccountsViewContract) {
        viewReady_calls += 1
        viewReady_view = view
    }
    
    var viewAppeared_calls = 0
    func viewAppeared() {
        viewAppeared_calls += 1
    }
    
    var accountTapped_calls = 0
    var accountTapped_account: Account?
    func accountTapped(_ account: Account) {
        accountTapped_calls += 1
        accountTapped_account = account
    }
    
}
