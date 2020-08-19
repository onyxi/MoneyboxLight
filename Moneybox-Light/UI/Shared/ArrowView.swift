//
//  ArrowView.swift
//  Moneybox-Light
//
//  Created by Pete Holdsworth on 18/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

import UIKit

class ArrowView: UIView {

    enum Direction { case right, left }
    
    var direction = Direction.right {
        didSet {
            switch direction {
            case .left:
                transform = CGAffineTransform(scaleX: -1, y: 1)
            case .right:
                transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }
    
    var path: UIBezierPath?

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        let startPoint = CGPoint(x: bounds.maxX * 0.3, y: bounds.maxY * 0.2)
        let tipPoint = CGPoint(x: bounds.maxX * 0.7, y: bounds.maxY * 0.5)
        let endPoint = CGPoint(x: bounds.maxX * 0.3, y: bounds.maxY * 0.8)
        
        path = UIBezierPath()
        
        path?.move(to: startPoint)
        path?.addLine(to: tipPoint)
        path?.addLine(to: endPoint)
        
        UIColor.catalogueColor(named: "PrimaryDark")?.setStroke()
        path?.lineWidth = 5
        path?.lineCapStyle = .round
        path?.lineJoinStyle = .round
        path?.stroke()
    
    }

}
