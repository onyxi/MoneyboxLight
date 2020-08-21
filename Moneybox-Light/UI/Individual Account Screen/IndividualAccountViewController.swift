//
//  IndividualAccountViewController.swift
//  Moneybox-Light
//
//  Created by Pete Holdsworth on 18/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

import UIKit

class IndividualAccountViewController: BaseViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var screenTitleLabel: UILabel!
    @IBOutlet weak var planTitleLabel: UILabel!
    @IBOutlet weak var planValueLabel: UILabel!
    @IBOutlet weak var moneyboxBackingView: UIView!
    @IBOutlet weak var moneyBoxTitleLabel: UILabel!
    @IBOutlet weak var moneyboxValueLabel: UILabel!
    @IBOutlet weak var paymentButton: PaymentButton!

    let presenter: IndividualAccountPresenterContract
    
    init(presenter: IndividualAccountPresenterContract) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavView()
        configureplanSection()
        configuremoneyboxSection()
        presenter.viewReady(self)
    }
    
    /// Notifies the Presenter object when the back button is tapped
    @IBAction func backTapped(_ sender: Any) {
        presenter.backTapped()
    }
    
    /// Notifies the Presenter object when the payment button is tapped
    @IBAction func paymentButtonTapped(_ sender: Any) {
        presenter.paymentButtonTapped()
    }
    
    // Private...
    
    private func configureNavView() {
        backButton.setTitle("< " + localisableString(forKey: "individual_account_screen_back_button_title"), for: .normal)
    }
    
    private func configureplanSection() {
        planTitleLabel.text = localisableString(forKey: "individual_account_screen_plan_value_title")
        planValueLabel.text = ""
    }
    
    private func configuremoneyboxSection() {
        moneyboxBackingView.layer.cornerRadius = moneyboxBackingView.bounds.width / 8
        moneyBoxTitleLabel.text = localisableString(forKey: "individual_account_screen_plan_moneybox_title")
        moneyboxValueLabel.text = ""
    }
    
}

// MARK: IndividualAccountViewContract
extension IndividualAccountViewController: IndividualAccountViewContract {
    
    /**
     Displays (or hides) a full screen loading overlay view with activity indicator
    - Parameter shouldShowLoading: flag to indicate if the loading view should be shown or hidden
    */
    func showLoading(_ shouldShowLoading: Bool) {
        super.showLoadingOverlay(shouldShowLoading)
    }
    
    /**
     Sets the text of the screen title label
     - Parameter text: the text to be displayed
    */
    func setScreenTitle(_ text: String) {
        screenTitleLabel.text = text
    }
    
    /**
     Sets the text of the plan value title label
     - Parameter text: the text to be displayed
    */
    func setPlanValueTitle(_ text: String) {
        planTitleLabel.text = text
    }
    
    /**
     Sets the text of the plan value label
     - Parameter text: the text to be displayed
    */
    func setPlanValue(_ text: String) {
        planValueLabel.text = text
    }
    
    /**
     Sets the text of the Moneybox value label
     - Parameter text: the text to be displayed
    */
    func setMoneyboxValue(_ text: String) {
        moneyboxValueLabel.text = text
    }
    
    /**
     Sets the title text of the payment button
     - Parameter text: the text to be displayed
    */
    func setPaymentButtonTitle(_ text: String) {
        paymentButton.setTitle(text, for: .normal)
    }
    
    /// Navigates the user back to the preivous screen
    func returnToPreviousScreen() {
        navigationController?.popViewController(animated: true)
    }
    
    /// Shows the login screen
    func showLoginScreen() {
        super.showLogin()
    }
    
    /**
     Displays an alert with the given configuration
    - Parameter configuration: the configuration used to build the alert
    */
    func showAlert(_ configuration: AlertConfiguration) {
        let alert = AlertController.alert(with: configuration)
        present(alert, animated: true)
    }
    
}
