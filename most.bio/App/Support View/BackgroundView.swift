//
//  BackgroundView.swift
//  most.bio
//
//  Created by Kirill Varshamov on 05.09.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import UIKit

class BackgroundView: UIView {

    var path: UIBezierPath!
    
    override init(frame: CGRect) {
        super.init(frame: frame)        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func draw(_ rect: CGRect) {
        path = UIBezierPath()
        
        // Top
        // 1
        path.move(to: CGPoint(x: 0.0, y: 0.0))
        path.addLine(to: CGPoint(x: self.frame.width, y: 0.0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height * 0.1724137931))
        path.addLine(to: CGPoint(x: 0.0, y: self.frame.height * 0.1724137931))
        path.close()
        UIColor.bigLightPurpleElements.setFill()
        path.fill()
        
        // 2
        path = UIBezierPath()
        path.move(to: CGPoint(x: -44.0, y: 96.0))
        path.addLine(to: CGPoint(x: -44.0 + 128.0, y: 96.0))
        path.addLine(to: CGPoint(x: -44.0 + 128.0, y: 96.0 + 267.0 / 2))
        path.addCurve(to: CGPoint(x: -44.0, y: 96.0 + 267.0),
                      controlPoint1: CGPoint(x: -44.0 + 128.0, y: 96.0 + 267.0 / 2),
                      controlPoint2: CGPoint(x: -44.0 + 128.0, y: 96.0 + 267.0)
        )
        path.close()
        UIColor.bigLightPurpleElements.setFill()
        path.fill()
        
        // 3
        path = UIBezierPath(rect: CGRect(x: 72, y: 138, width: 116, height: 97))
        UIColor.bigLightPurpleElements.setFill()
        path.fill()
        
        // 4
        path = UIBezierPath(ovalIn: CGRect(x: 84, y: 140, width: 200, height: 200))
        UIColor.backgroundPurple.setFill()
        path.fill()

        // Bottom
        // 5
        path = UIBezierPath(rect: CGRect(x: 315, y: 729, width: 60, height: 83))
        UIColor.bigLightPurpleElements.setFill()
        path.fill()
        
        // 6
        path = UIBezierPath()
        path.move(to: CGPoint(x: 42.0 + 291.0, y: 729.0))
        path.addLine(to: CGPoint(x: 42.0 + 291.0 / 2 + 10, y: 729.0))
        path.addCurve(to: CGPoint(x: 42.0, y: 729.0 + 181.0),
                      controlPoint1: CGPoint(x: 42.0 + 291.0 / 2 + 10, y: 729.0),
                      controlPoint2: CGPoint(x: 42.0, y: 729.0)
        )
        path.addLine(to: CGPoint(x: 42.0 + 291.0, y: 729.0 + 181.0))
        path.close()
        UIColor.bigLightPurpleElements.setFill()
        path.fill()
    }
}
