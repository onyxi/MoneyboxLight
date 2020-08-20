//
//  LoginPresenterTests.swift
//  Moneybox-LightTests
//
//  Created by Pete Holdsworth on 20/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

@testable import Moneybox_Light
import XCTest

class LoginPresenterTests: XCTestCase {
 
    var mockLoginView: MockLoginView!
    var mockDAO: MockDAO!
    var loginPresenter: LoginPresenter!
    
    override func setUp() {
        mockLoginView = MockLoginView()
        mockDAO = MockDAO()
        loginPresenter = LoginPresenter(dao: mockDAO)
    }
    
    func test_viewReady() {
        loginPresenter.viewReady(mockLoginView)
        XCTAssertTrue(loginPresenter.view === mockLoginView)
    }
    
    func test_loginTapped() {
        let mockEmail = "mockEmail"
        let mockPassword = "mockPassword"
        mockLoginView.getEmail_stringToReturn = mockEmail
        mockLoginView.getPassword_stringToReturn = mockPassword
        loginPresenter.view = mockLoginView
        loginPresenter.loginTapped()
        XCTAssertEqual(mockLoginView.showLoading_calls, 1)
        XCTAssertEqual(mockLoginView.showLoading_calls_shouldShowLoading, true)
        XCTAssertEqual(mockLoginView.getEmail_calls, 1)
        XCTAssertEqual(mockLoginView.getPassword_calls, 1)
        XCTAssertEqual(mockDAO.login_calls, 1)
        XCTAssertEqual(mockDAO.login_username, mockEmail)
        XCTAssertEqual(mockDAO.login_password, mockPassword)
        XCTAssertNotNil(mockDAO.login_completion)
    }
    
    func test_loginCompleted() {
        let mockUser = User(name: "mockName")
        let mockSession = Session(bearerToken: "mockBearerToken")
        let mockLoginResponse = LoginResponse(user: mockUser, session: mockSession)
        
        // if login succeeds, User and Session data should be stored and the view dismissed
        loginPresenter.view = mockLoginView
        var loginResult = LoginResult.success(mockLoginResponse)
        loginPresenter.loginCompleted(loginResult)
        XCTAssertEqual(mockDAO.saveUser_calls, 1)
        XCTAssertEqual(mockDAO.saveUser_user, mockUser)
        XCTAssertEqual(mockDAO.saveSession_calls, 1)
        XCTAssertEqual(mockDAO.saveSession_session, mockSession)
        XCTAssertEqual(mockLoginView.dismissScreen_calls, 1)
        
        // if login fails, the view should be notified to show an appropriate alert
        setUp()
        loginPresenter.view = mockLoginView
        loginResult = LoginResult.failure(.serverError)
        loginPresenter.loginCompleted(loginResult)
        XCTAssertEqual(mockDAO.saveUser_calls, 0)
        XCTAssertEqual(mockDAO.saveSession_calls, 0)
        XCTAssertEqual(mockLoginView.dismissScreen_calls, 0)
        XCTAssertEqual(mockLoginView.showAlert_calls, 1)
        let expectedAlertConfig = AlertConfiguration(
            title: "Oops!",
            message: "Something went wrong",
            actions: [
                AlertConfiguration.Action(title: "Cancel", type: .cancel, completion: nil),
                AlertConfiguration.Action(title: "Retry", type: .normal, completion: nil)]
        )
        XCTAssertEqual(mockLoginView.showAlert_configuration, expectedAlertConfig)
    }
}

