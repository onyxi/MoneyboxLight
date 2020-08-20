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
    
    @IBAction func backTapped(_ sender: Any) {
        presenter.backTapped()
    }
    
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
    
    func showLoading(_ shouldShowLoading: Bool) {
        super.showLoadingOverlay(shouldShowLoading)
    }
    
    func setScreenTitle(_ text: String) {
        screenTitleLabel.text = text
    }
    
    func setPlanValueTitle(_ text: String) {
        planTitleLabel.text = text
    }
    
    func setPlanValue(_ text: String) {
        planValueLabel.text = text
    }
    
    func setMoneyboxValue(_ text: String) {
        moneyboxValueLabel.text = text
    }
    
    func setPaymentButtonTitle(_ text: String) {
        paymentButton.setTitle(text, for: .normal)
    }
    
    func returnToPreviousScreen() {
        navigationController?.popViewController(animated: true)
    }
    
    func showLoginScreen() {
        super.showLogin()
    }
    
    func showAlert(_ configuration: AlertConfiguration) {
        let alert = AlertController.alert(with: configuration)
        present(alert, animated: true)
    }
    
}
