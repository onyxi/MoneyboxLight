//
//  AccountTableViewCell.swift
//  Moneybox-Light
//
//  Created by Pete Holdsworth on 18/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

import UIKit

protocol AccountTableViewCellDelegate: class {
    func didTapAccountCell(_ sender: AccountTableViewCell)
}

class AccountTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var backingView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var valueLabel: UILabel!
    @IBOutlet private weak var moneyboxLabel: UILabel!
    
    weak var delegate: AccountTableViewCellDelegate?
    
    var account: Account? {
        didSet {
            guard let account = account else { return }
            titleLabel.text = account.name
            valueLabel.text = localisableString(forKey: "user_accounts_screen_account_cell_value_title") + String(format: "%.2f", account.value)
            moneyboxLabel.text = localisableString(forKey: "user_accounts_screen_account_cell_moneybox_title") + String(format: "%.2f", account.moneybox)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backingView.layer.cornerRadius = 8
    }
    
    func didTapAccountCell() {
        delegate?.didTapAccountCell(self)
    }
    
}

// MARK: Handle touches...
extension AccountTableViewCell {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        animateTapped()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        animateReleased()
        didTapAccountCell()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        animateReleased()
    }
    
    private func animateTapped() {
        let scaleTransform = CGAffineTransform(scaleX: 0.97, y: 0.97)
        UIView.animate(withDuration: 0.05) {
            self.backingView.alpha = 0.7
            self.transform = scaleTransform
        }
    }
    
    private func animateReleased() {
        let scaleTransform = CGAffineTransform(scaleX: 1, y: 1)
        UIView.animate(withDuration: 0.05) {
            self.backingView.alpha = 1.0
            self.transform = scaleTransform
        }
    }
}

