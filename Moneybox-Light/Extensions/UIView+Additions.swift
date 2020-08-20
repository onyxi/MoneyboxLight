//
//  UIView+Additions.swift
//  Moneybox-Light
//
//  Created by Pete Holdsworth on 19/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

import UIKit

extension UIView {
    
    static func loadFromNib(_ nibNameOrNil: String? = nil, bundle: Bundle? = nil) -> Self {
        let nibName = nibNameOrNil ?? self.className
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! Self
    }
    
    fileprivate static var className: String {
        let className = "\(self)"
        let components = className.split{$0 == "."}.map ( String.init )
        return components.last!
    }
    
    /// Pins a given view to another view - constrained to the leading, trailing, top and bottom anchors
    func addConstrained(subview: UIView) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.topAnchor.constraint(equalTo: topAnchor).isActive = true
        subview.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        subview.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        subview.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
