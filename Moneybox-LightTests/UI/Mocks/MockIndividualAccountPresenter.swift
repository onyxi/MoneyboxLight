//
//  MockIndividualAccountPresenter.swift
//  Moneybox-LightTests
//
//  Created by Pete Holdsworth on 20/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

@testable import Moneybox_Light

class MockIndividualAccountPresenter: IndividualAccountPresenterContract {
    
    var viewReady_calls = 0
    var viewReady_view: IndividualAccountViewContract?
    func viewReady(_ view: IndividualAccountViewContract) {
        viewReady_calls += 1
        viewReady_view = view
    }
    
    var backTapped_calls = 0
    func backTapped() {
        backTapped_calls += 1
    }
    
    var paymentButtonTapped_calls = 0
    func paymentButtonTapped() {
        paymentButtonTapped_calls += 1
    }

}
