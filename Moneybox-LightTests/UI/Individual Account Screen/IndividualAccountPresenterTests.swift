//
//  IndividualAccountPresenterTests.swift
//  Moneybox-LightTests
//
//  Created by Pete Holdsworth on 20/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

@testable import Moneybox_Light
import XCTest

class IndividualAccountPresenterTests: XCTestCase {
    
    var mockIndividualAccountView: MockIndividualAccountView!
    var mockDAO: MockDAO!
    var individualAccountPresenter: IndividualAccountPresenter!
    
    let mockAccount = Account(productId: 1, name: "MockAccount", value: 1000.0, moneybox: 20.0)
    
    override func setUp() {
        mockIndividualAccountView = MockIndividualAccountView()
        mockDAO = MockDAO()
        individualAccountPresenter = IndividualAccountPresenter(account: mockAccount, dao: mockDAO)
    }
    
    func test_viewReady() {
        individualAccountPresenter.viewReady(mockIndividualAccountView)
        XCTAssertTrue(individualAccountPresenter.view === mockIndividualAccountView)
    }
    
    func test_backTapped() {
        individualAccountPresenter.view = mockIndividualAccountView
        individualAccountPresenter.backTapped()
        XCTAssertEqual(mockIndividualAccountView.returnToPreviousScreen_calls, 1)
    }
    
    func test_paymentButtonTapped() {
        individualAccountPresenter.view = mockIndividualAccountView
        individualAccountPresenter.paymentButtonTapped()
        XCTAssertEqual(mockIndividualAccountView.showLoading_calls, 1)
        XCTAssertEqual(mockIndividualAccountView.showLoading_shouldShowLoading, true)
        XCTAssertEqual(mockDAO.makeOneOffPayment_calls, 1)
        XCTAssertEqual(mockDAO.makeOneOffPayment_bearerToken, nil)
        XCTAssertEqual(mockDAO.makeOneOffPayment_account, mockAccount)
        XCTAssertEqual(mockDAO.makeOneOffPayment_amount, individualAccountPresenter.oneOffPaymentAmount)
        XCTAssertNotNil(mockDAO.makeOneOffPayment_completion)
    }
    
    func test_oneOffPaymentCompleted() {
        
        // if payment succeeds, the view should be updated to show new value
        individualAccountPresenter.view = mockIndividualAccountView
        let mockMoneybox = 20.0
        let mockPaymentResponse = PaymentResponse(moneybox: mockMoneybox)
        individualAccountPresenter.oneOffPaymentCompleted(.success(mockPaymentResponse))
        XCTAssertEqual(mockIndividualAccountView.showLoading_calls, 1)
        XCTAssertEqual(mockIndividualAccountView.showLoading_shouldShowLoading, false)
        XCTAssertEqual(individualAccountPresenter.currentMoneyboxValue, mockMoneybox)
        XCTAssertEqual(mockIndividualAccountView.setMoneyboxValue_calls, 1)
        XCTAssertEqual(mockIndividualAccountView.setMoneyboxValue_text, String(format: "£%.2f", mockMoneybox))
        
        // if payment fails because the user is unauthorized, the view should be notified to show login screen
        setUp()
        individualAccountPresenter.view = mockIndividualAccountView
        individualAccountPresenter.oneOffPaymentCompleted(.failure(.unauthorized))
        XCTAssertEqual(mockIndividualAccountView.showLoginScreen_calls, 1)
        
        // if login fails for other reasons, the view should be notified to show an appropriate alert
        setUp()
        individualAccountPresenter.view = mockIndividualAccountView
        individualAccountPresenter.oneOffPaymentCompleted(.failure(.serverError))
        XCTAssertEqual(mockIndividualAccountView.showAlert_calls, 1)
        let expectedAlertConfig = AlertConfiguration(
            title: "Oops!",
            message: "Something went wrong",
            actions: [
                AlertConfiguration.Action(title: "Cancel", type: .cancel, completion: nil),
                AlertConfiguration.Action(title: "Retry", type: .normal, completion: nil)]
        )
        XCTAssertEqual(mockIndividualAccountView.showAlert_configuration, expectedAlertConfig)
    }
    
    
}
