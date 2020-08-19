//
//  UIColor+Additions.swift
//  Moneybox-Light
//
//  Created by Pete Holdsworth on 19/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

import UIKit

extension UIColor {
  
  /// Returns an optional UIColor from an assets catalogue
  static func catalogueColor(named: String) -> UIColor? {
    if #available(iOS 11.0, *) {
      return UIColor(named: named)
    }
    return nil
  }

}
