//
//  IndividualAccountViewControllerTests.swift
//  Moneybox-LightTests
//
//  Created by Pete Holdsworth on 20/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

@testable import Moneybox_Light
import XCTest

class IndividualAccountViewControllerTests: XCTestCase {
    
    var mockIndividualAccountPresenter: MockIndividualAccountPresenter!
    var individualAccountViewController: IndividualAccountViewController!
    
    override func setUp() {
        mockIndividualAccountPresenter = MockIndividualAccountPresenter()
        individualAccountViewController = IndividualAccountViewController(presenter: mockIndividualAccountPresenter)
    }
    
    func test_viewDidLoad() {
        _ = individualAccountViewController.view
        XCTAssertEqual(mockIndividualAccountPresenter.viewReady_calls, 1)
        XCTAssertTrue(mockIndividualAccountPresenter.viewReady_view === individualAccountViewController)
    }
    
    func test_backTapped() {
        _ = individualAccountViewController.view
        individualAccountViewController.backButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(mockIndividualAccountPresenter.backTapped_calls, 1)
    }
    
    func test_paymentButtonTapped() {
        _ = individualAccountViewController.view
        individualAccountViewController.paymentButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(mockIndividualAccountPresenter.paymentButtonTapped_calls, 1)
    }
    
    
    func test_showLoading() {
        individualAccountViewController.isShowingLoading = false
        individualAccountViewController.showLoading(true)
        XCTAssertEqual(individualAccountViewController.isShowingLoading, true)
    }
    
    func test_setScreenTitle() {
        let mockScreenTitle = "mockScreenTitle"
        _ = individualAccountViewController.view
        individualAccountViewController.setScreenTitle(mockScreenTitle)
        XCTAssertEqual(individualAccountViewController.screenTitleLabel.text, mockScreenTitle)
    }
    
    func test_setPlanValueTitle() {
        let mockPlanValueTitle = "mockPlanValueTitle"
        _ = individualAccountViewController.view
        individualAccountViewController.setPlanValueTitle(mockPlanValueTitle)
        XCTAssertEqual(individualAccountViewController.planTitleLabel.text, mockPlanValueTitle)
    }
    
    func test_setPlanValue() {
        let mockPlanValue = "mockPlanValue"
        _ = individualAccountViewController.view
        individualAccountViewController.setPlanValue(mockPlanValue)
        XCTAssertEqual(individualAccountViewController.planValueLabel.text, mockPlanValue)
    }
    
    func test_setMoneyboxValue() {
        let mockMoneyboxValue = "mockMoneyboxValue"
        _ = individualAccountViewController.view
        individualAccountViewController.setMoneyboxValue(mockMoneyboxValue)
        XCTAssertEqual(individualAccountViewController.moneyboxValueLabel.text, mockMoneyboxValue)
    }
    
    func test_setPaymentButtonTitle() {
        let mockButtontitle = "mockButtonTitle"
        _ = individualAccountViewController.view
        individualAccountViewController.setPaymentButtonTitle(mockButtontitle)
        XCTAssertEqual(individualAccountViewController.paymentButton.titleLabel?.text, mockButtontitle)
    }
    
}
