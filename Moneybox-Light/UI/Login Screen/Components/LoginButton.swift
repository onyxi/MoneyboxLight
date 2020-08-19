//
//  LoginButton.swift
//  Moneybox-Light
//
//  Created by Pete Holdsworth on 18/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

import UIKit

class LoginButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        setTitle(localisableString(forKey: "login_screen_button_title"), for: .normal)
        layer.cornerRadius = 10
    }

}
