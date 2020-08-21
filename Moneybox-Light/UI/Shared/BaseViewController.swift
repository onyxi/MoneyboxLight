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
    var isShowingLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingOverlayView.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        activityIndicator.color = UIColor.catalogueColor(named: "PrimaryDark")
        loadingOverlayView.addConstrained(subview: activityIndicator)
        hideKeyboardWhenTappedAround()
    }
    
    /**
     Displays (or hides) a full screen loading overlay view with activity indicator
    - Parameter shouldShowLoading: flag to indicate if the loading view should be shown or hidden
    */
    func showLoadingOverlay(_ shouldShowLoading: Bool) {
        if shouldShowLoading {
            activityIndicator.startAnimating()
            view.addConstrained(subview: loadingOverlayView)
        } else {
            loadingOverlayView.removeFromSuperview()
            activityIndicator.stopAnimating()
        }
        isShowingLoading = shouldShowLoading
    }
    
    /// Shows the login screen
    func showLogin() {
        let loginPresenter = LoginPresenter(dao: DataAccessObjectImpl())
        let loginViewController = LoginViewController(presenter: loginPresenter)
        navigationController?.present(loginViewController, animated: true, completion: nil)
    }
    
    /// Dismisses the soft keyboard if anywhere on the screen (other than the keyboard) is tapped
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    /// Dismisses the soft keyboard if shown
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
