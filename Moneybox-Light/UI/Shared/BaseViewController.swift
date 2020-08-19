//
//  BaseViewController.swift
//  Moneybox-Light
//
//  Created by Pete Holdsworth on 18/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    private let loadingOverlayView = UIView()
    private let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingOverlayView.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        activityIndicator.color = UIColor.catalogueColor(named: "PrimaryDark")
        loadingOverlayView.addConstrained(subview: activityIndicator)
    }
    
    func showLoadingOverlay(_ shouldShowLoading: Bool) {
        if shouldShowLoading {
            activityIndicator.startAnimating()
            view.addConstrained(subview: loadingOverlayView)
        } else {
            loadingOverlayView.removeFromSuperview()
            activityIndicator.stopAnimating()
        }
    }
    
    func showLogin() {
        let loginPresenter = LoginPresenter(dao: DataAccessObjectImpl.shared)
        let loginViewController = LoginViewController(presenter: loginPresenter)
        navigationController?.present(loginViewController, animated: true, completion: nil)
    }
    
}



