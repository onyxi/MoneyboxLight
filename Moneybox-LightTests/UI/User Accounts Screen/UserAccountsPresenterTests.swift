//
//  UserAccountsPresenterTests.swift
//  Moneybox-LightTests
//
//  Created by Pete Holdsworth on 20/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

@testable import Moneybox_Light
import XCTest

class UserAccountsPresenterTests: XCTestCase {
    
    var mockUserAccountsView: MockUserAccountsView!
    var mockDAO: MockDAO!
    var userAccountsPresenter: UserAccountsPresenter!
    
    override func setUp() {
        mockUserAccountsView = MockUserAccountsView()
        mockDAO = MockDAO()
        userAccountsPresenter = UserAccountsPresenter(dao: mockDAO)
    }
    
    func test_viewReady() {
        let mockName = "mockName"
        mockDAO.getUser_userToReturn = User(name: mockName)
        userAccountsPresenter.viewReady(mockUserAccountsView)
        XCTAssertTrue(userAccountsPresenter.view === mockUserAccountsView)
        XCTAssertEqual(mockDAO.getUser_calls, 1)
        XCTAssertEqual(mockUserAccountsView.setGreeting_calls, 1)
        XCTAssertEqual(mockUserAccountsView.setGreeting_text, "Hello " + mockName + "!")
    }
    
    func test_viewAppeared() {
        userAccountsPresenter.view = mockUserAccountsView
        userAccountsPresenter.viewAppeared()
        XCTAssertEqual(mockUserAccountsView.showLoading_calls, 1)
        XCTAssertEqual(mockUserAccountsView.showLoading_shouldShowLoading, true)
        XCTAssertEqual(mockDAO.getAccounts_calls, 1)
        XCTAssertEqual(mockDAO.getAccounts_bearerToken, nil)
        XCTAssertNotNil(mockDAO.getAccounts_completion)
    }
    
    func test_fetchAccountsCompleted() {
        let mockProductResponse1 = ProductResponse(investorProductId: 1, planValue: 1000.0, moneybox: 10.0, product: Product(id: 1, name: "mockProduct1"))
        let mockProductResponse2 = ProductResponse(investorProductId: 2, planValue: 2000.0, moneybox: 20.0, product: Product(id: 2, name: "mockProduct2"))
        
        // if accounts fetched successfully, the view should be updated to show new value
        userAccountsPresenter.view = mockUserAccountsView
        let mockAccountsResponse = AccountsResponse(totalPlanValue: 3000.0, productResponses: [mockProductResponse1, mockProductResponse2])
        userAccountsPresenter.fetchAccountsCompleted(.success(mockAccountsResponse))
        XCTAssertEqual(mockUserAccountsView.setTotalTitle_calls, 1)
        XCTAssertEqual(mockUserAccountsView.setTotalTitle_text, "Current Plan Value")
        XCTAssertEqual(mockUserAccountsView.setTotal_calls, 1)
        XCTAssertEqual(mockUserAccountsView.setTotal_text, "£3000.00")
        XCTAssertEqual(mockUserAccountsView.setAccounts_calls, 1)
        let expectedAccounts = [
            Account(productId: 1, name: "mockProduct1", value: 1000.00, moneybox: 10.0),
            Account(productId: 2, name: "mockProduct2", value: 2000.00, moneybox: 20.0)
        ]
        XCTAssertEqual(mockUserAccountsView.setAccounts_accounts, expectedAccounts)
        
        // if ccounts fetch fails because the user is unauthorized, the view should be notified to show login screen
        setUp()
        userAccountsPresenter.view = mockUserAccountsView
        userAccountsPresenter.fetchAccountsCompleted(.failure(.unauthorized))
        XCTAssertEqual(mockUserAccountsView.showLoginScreen_calls, 1)
        
        // if login fails for other reasons, the view should be notified to show an appropriate alert
        setUp()
        userAccountsPresenter.view = mockUserAccountsView
        userAccountsPresenter.fetchAccountsCompleted(.failure(.serverError))
        XCTAssertEqual(mockUserAccountsView.showAlert_calls, 1)
        let expectedAlertConfig = AlertConfiguration(
            title: "Oops!",
            message: "Something went wrong",
            actions: [
                AlertConfiguration.Action(title: "Cancel", type: .cancel, completion: nil),
                AlertConfiguration.Action(title: "Retry", type: .normal, completion: nil)]
        )
        XCTAssertEqual(mockUserAccountsView.showAlert_configuration, expectedAlertConfig)
    }
    
}
