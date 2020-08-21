//
//  LoginTextField.swift
//  Moneybox-Light
//
//  Created by Pete Holdsworth on 18/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

import UIKit

/// LoginTextField is a custom UITextField with rounded corners
class LoginTextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 2
    }

}
