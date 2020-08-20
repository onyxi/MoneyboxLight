//
//  UserAccountsViewController.swift
//  Moneybox-Light
//
//  Created by Pete Holdsworth on 18/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

import UIKit

class UserAccountsViewController: BaseViewController {

    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var totalTitleLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var accountsListTitleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var accounts = [Account]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    fileprivate let presenter: UserAccountsPresenterContract
    
    init(presenter: UserAccountsPresenterContract) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSummarySection()
        configureTableView()
        presenter.viewReady(self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter.viewAppeared()
    }
    
    // MARK: Private
    
    private func configureSummarySection() {
        greetingLabel.text = ""
        totalTitleLabel.text = ""
        totalLabel.text = ""
    }
    
    private func configureTableView() {
        accountsListTitleLabel.text = localisableString(forKey: "user_accounts_screen_accounts_list_title")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.delaysContentTouches = false
        tableView.register(UINib(nibName: "AccountTableViewCell", bundle: nil),
        forCellReuseIdentifier: "AccountTableViewCell")
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension UserAccountsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.isEmpty ? 0 : accounts.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return UITableViewCell() // transparent cell for padding
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AccountTableViewCell", for: indexPath) as? AccountTableViewCell else {
            return UITableViewCell()
        }
        
        let account = accounts[indexPath.row - 1]
        
        cell.account = account
        
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 8 // transparent cell for padding
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}

// MARK: UserAccountsViewContract
extension UserAccountsViewController: UserAccountsViewContract {
    
    func showLoading(_ shouldShowLoading: Bool) {
        super.showLoadingOverlay(shouldShowLoading)
    }
    
    func setGreeting(_ text: String) {
        greetingLabel.text = text
    }
    
    func setTotalTitle(_ text: String) {
        totalTitleLabel.text = text
    }
    
    func setTotal(_ text: String) {
        totalLabel.text = text
    }
    
    func setAccountsListTitle(_ text: String) {
        accountsListTitleLabel.text = text
    }
    
    func setAccounts(_ accounts: [Account]) {
        self.accounts = accounts
    }
    
    func goToAccountDetailsScreen(_ account: Account) {
        let individualAccountPresenter = IndividualAccountPresenter(account: account, dao: DataAccessObjectImpl())
        let individualAccountViewController = IndividualAccountViewController(presenter: individualAccountPresenter)
        navigationController?.pushViewController(individualAccountViewController, animated: true)
    }
    
    func showLoginScreen() {
        super.showLogin()
    }
    
    func showAlert(_ configuration: AlertConfiguration) {
        let alert = AlertController.alert(with: configuration)
        present(alert, animated: true)
    }
    
}

// MARK: AccountTableViewCellDelegate
extension UserAccountsViewController: AccountTableViewCellDelegate {
    
    func didTapAccountCell(_ sender: AccountTableViewCell) {
        guard let account = sender.account else { return }
        presenter.accountTapped(account)
    }
    
}
