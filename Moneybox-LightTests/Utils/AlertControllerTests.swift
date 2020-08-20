//
//  AlertControllerTests.swift
//  Moneybox-LightTests
//
//  Created by Pete Holdsworth on 20/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

@testable import Moneybox_Light
import XCTest

class AlertControllerTests: XCTestCase {
    
    let mockTitle = "Some Title"
    let mockMessage = "Some Message"
    
    let actionTitle1 = "ActionTitle1"
    let actionTitle2 = "ActionTitle2"
    let actionTitle3 = "ActionTitle3"
    
    lazy var mockAction1 = AlertConfiguration.Action(title: actionTitle1, type: .cancel, completion: nil)
    lazy var mockAction2 = AlertConfiguration.Action(title: actionTitle2, type: .normal, completion: nil)
    lazy var mockAction3 = AlertConfiguration.Action(title: actionTitle3, type: .destructive, completion: nil)
    var mockAlertConfiguration: AlertConfiguration!
 
    override func setUp() {
        mockAlertConfiguration = AlertConfiguration(title: mockTitle, message: mockMessage, actions: [mockAction1, mockAction2, mockAction3])
    }
    
    func test_alert() {
        // when created with AlertConfiguration...
        let alert = AlertController.alert(with: mockAlertConfiguration)
        // AlertController should be constructed correctly...
        XCTAssertEqual(alert.title, mockTitle)
        XCTAssertEqual(alert.message, mockMessage)
        XCTAssertEqual(alert.actions.count, 3)
        XCTAssertEqual(alert.actions[0].title, actionTitle1)
        XCTAssertEqual(alert.actions[0].style, .cancel)
        XCTAssertEqual(alert.actions[1].title, actionTitle2)
        XCTAssertEqual(alert.actions[1].style, .default)
        XCTAssertEqual(alert.actions[2].title, actionTitle3)
        XCTAssertEqual(alert.actions[2].style, .destructive)
    }
    
}
