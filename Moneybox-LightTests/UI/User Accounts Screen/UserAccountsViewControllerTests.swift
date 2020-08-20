//
//  UserAccountsViewControllerTests.swift
//  Moneybox-LightTests
//
//  Created by Pete Holdsworth on 20/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

@testable import Moneybox_Light
import XCTest

class UserAccountsViewControllerTests: XCTestCase {
    
    var mockUserAccountsPresenter: MockUserAccountsPresenter!
    var userAccountsViewController: UserAccountsViewController!
    
    override func setUp() {
        mockUserAccountsPresenter = MockUserAccountsPresenter()
        userAccountsViewController = UserAccountsViewController(presenter: mockUserAccountsPresenter)
    }
    
    func test_viewDidLoad() {
        _ = userAccountsViewController.view
        XCTAssertEqual(mockUserAccountsPresenter.viewReady_calls, 1)
        XCTAssertTrue(mockUserAccountsPresenter.viewReady_view === userAccountsViewController)
    }
    
    func test_viewDidAppear() {
        userAccountsViewController.viewDidAppear(false)
        XCTAssertEqual(mockUserAccountsPresenter.viewAppeared_calls, 1)
    }
    
    func test_showLoading() {
        userAccountsViewController.isShowingLoading = false
        userAccountsViewController.showLoading(true)
        XCTAssertEqual(userAccountsViewController.isShowingLoading, true)
    }
    
    func test_setGreeting() {
        let mockGreeting = "mockGreeting"
        _ = userAccountsViewController.view
        userAccountsViewController.setGreeting(mockGreeting)
        XCTAssertEqual(userAccountsViewController.greetingLabel.text, mockGreeting)
    }
    
    func test_setTotalTitle() {
        let mockTotalTitle = "mockTotalTitle"
        _ = userAccountsViewController.view
        userAccountsViewController.setTotalTitle(mockTotalTitle)
        XCTAssertEqual(userAccountsViewController.totalTitleLabel.text, mockTotalTitle)
    }
    
    func test_setTotal() {
        let mockTotal = "mockTotal"
        _ = userAccountsViewController.view
        userAccountsViewController.setTotal(mockTotal)
        XCTAssertEqual(userAccountsViewController.totalLabel.text, mockTotal)
    }
    
    func test_setAccountsListTitle() {
        let mockAccountsListTitle = "mockAccountsListTitle"
        _ = userAccountsViewController.view
        userAccountsViewController.setAccountsListTitle(mockAccountsListTitle)
        XCTAssertEqual(userAccountsViewController.accountsListTitleLabel.text, mockAccountsListTitle)
    }
    
    func test_setAccounts() {
        let mockAccounts = [
            Account(productId: 1, name: "mockAccount1", value: 1000.0, moneybox: 10.0),
            Account(productId: 2, name: "mockAccount2", value: 2000.0, moneybox: 20.0),
            Account(productId: 3, name: "mockAccount3", value: 3000.0, moneybox: 30.0)]
        _ = userAccountsViewController.view
        userAccountsViewController.setAccounts(mockAccounts)
        XCTAssertEqual(userAccountsViewController.accounts, mockAccounts)
    }
    
    func test_didTapAccountCell() {
        let mockAccount = Account(productId: 1, name: "mockAccount1", value: 1000.0, moneybox: 10.0)
        let mockAccountCell = AccountTableViewCell.loadFromNib()
        mockAccountCell.account = mockAccount
        userAccountsViewController.didTapAccountCell(mockAccountCell)
        XCTAssertEqual(mockUserAccountsPresenter.accountTapped_calls, 1)
        XCTAssertEqual(mockUserAccountsPresenter.accountTapped_account, mockAccount)
    }
    
}
