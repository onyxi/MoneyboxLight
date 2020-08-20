//
//  MockLoginView.swift
//  Moneybox-LightTests
//
//  Created by Pete Holdsworth on 20/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

@testable import Moneybox_Light

class MockLoginView: LoginViewContract {
    
    var showLoading_calls = 0
    var showLoading_calls_shouldShowLoading: Bool?
    func showLoading(_ shouldShowLoading: Bool) {
        showLoading_calls += 1
        showLoading_calls_shouldShowLoading = shouldShowLoading
    }
    
    var getEmail_calls = 0
    var getEmail_stringToReturn: String?
    func getEmail() -> String {
        getEmail_calls += 1
        return getEmail_stringToReturn ?? ""
    }
    
    var getPassword_calls = 0
    var getPassword_stringToReturn: String?
    func getPassword() -> String {
        getPassword_calls += 1
        return getPassword_stringToReturn ?? ""
    }
    
    var dismissScreen_calls = 0
    func dismissScreen() {
        dismissScreen_calls += 1
    }
    
    var showAlert_calls = 0
    var showAlert_configuration: AlertConfiguration?
    func showAlert(_ configuration: AlertConfiguration) {
        showAlert_calls += 1
        showAlert_configuration = configuration
    }
    
}
    
