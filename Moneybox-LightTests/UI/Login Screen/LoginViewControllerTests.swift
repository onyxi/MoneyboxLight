//
//  LoginViewControllerTests.swift
//  Moneybox-LightTests
//
//  Created by Pete Holdsworth on 20/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

@testable import Moneybox_Light
import XCTest

class LoginViewControllerTests: XCTestCase {
    
    var mockLoginPresenter: MockLoginPresenter!
    var loginViewController: LoginViewController!
    
    override func setUp() {
        mockLoginPresenter = MockLoginPresenter()
        loginViewController = LoginViewController(presenter: mockLoginPresenter)
    }
    
    func test_viewDidLoad() {
        _ = loginViewController.view
        XCTAssertEqual(mockLoginPresenter.viewReady_calls, 1)
        XCTAssertTrue(mockLoginPresenter.viewReady_view === loginViewController)
    }
    
    func test_loginTapped() {
        loginViewController.loginTapped(self)
        XCTAssertEqual(mockLoginPresenter.loginTapped_calls, 1)
    }
    
    func test_showLoading() {
        loginViewController.isShowingLoading = false
        loginViewController.showLoading(true)
        XCTAssertEqual(loginViewController.isShowingLoading, true)
    }
    
    func test_getEmail() {
        let mockEmail = "mockEmail"
        _ = loginViewController.view
        loginViewController.emailTextField.text = mockEmail
        XCTAssertEqual(loginViewController.getEmail(), mockEmail)
    }
    
    func test_getPassword() {
        let mockPassword = "mockPassword"
        _ = loginViewController.view
        loginViewController.passwordTextField.text = mockPassword
        XCTAssertEqual(loginViewController.getPassword(), mockPassword)
    }
    
}
