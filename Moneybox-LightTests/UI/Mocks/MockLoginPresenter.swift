//
//  MockLoginPresenter.swift
//  Moneybox-LightTests
//
//  Created by Pete Holdsworth on 20/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

@testable import Moneybox_Light

class MockLoginPresenter: LoginPresenterContract {
    
    var viewReady_calls = 0
    var viewReady_view: LoginViewContract?
    func viewReady(_ view: LoginViewContract) {
        viewReady_calls += 1
        viewReady_view = view
    }
    
    var loginTapped_calls = 0
    func loginTapped() {
        loginTapped_calls += 1
    }
    
}
