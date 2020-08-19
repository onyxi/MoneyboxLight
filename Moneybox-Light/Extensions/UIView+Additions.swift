//
//  UIView+Additions.swift
//  Moneybox-Light
//
//  Created by Pete Holdsworth on 19/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

import UIKit

extension UIView {
  func addConstrained(subview: UIView) {
    addSubview(subview)
    subview.translatesAutoresizingMaskIntoConstraints = false
    subview.topAnchor.constraint(equalTo: topAnchor).isActive = true
    subview.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    subview.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    subview.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
  }
}
