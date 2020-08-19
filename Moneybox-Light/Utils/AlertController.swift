//
//  AlertController.swift
//  Moneybox-Light
//
//  Created by Pete Holdsworth on 19/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

import UIKit

class AlertController: UIAlertController {
    
    static func alert(with configuration: AlertConfiguration) -> AlertController {
        let alert = AlertController(title: configuration.title, message: configuration.message, preferredStyle: .alert)
        guard let actions = configuration.actions else { return alert }
        for action in actions {
            let alertAction = UIAlertAction(title: action.title, style: actionStyle(for: action.type)) { _ in
                guard let completion = action.completion else { return }
                completion()
            }
            alert.addAction(alertAction)
        }
        return alert
    }

    fileprivate static func actionStyle(for buttonType: AlertConfiguration.ActionType) -> UIAlertAction.Style {
        switch buttonType {
        case.normal:
            return .default
        case .cancel:
            return .cancel
        case.destructive:
            return .destructive
        }
    }
    
}

// MARK: AlertConfiguration

struct AlertConfiguration {
    
    let title: String
    let message: String?
    let actions: [Action]?
    
    init(title: String, message: String?, actions: [Action]?) {
        self.title = title
        self.message = message
        self.actions = actions
    }
    
    enum ActionType { case normal, cancel, destructive}
    
    struct Action {
        let title: String
        let type: ActionType
        let completion: (() -> ())?
        
        init (title: String, type: ActionType, completion: (() -> ())?) {
            self.title = title
            self.type = type
            self.completion = completion
        }
    }
}

extension AlertConfiguration: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.title == rhs.title &&
            lhs.message == rhs.message &&
            lhs.actions == rhs.actions
    }
}

extension AlertConfiguration.Action: Equatable {
    static func == (lhs: AlertConfiguration.Action, rhs: AlertConfiguration.Action) -> Bool {
        return lhs.title == rhs.title &&
            lhs.type == rhs.type
    }
}
