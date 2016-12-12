//
//  View_Node.swift
//  TheBigPicture
//
//  Created by RadioactiveTEA on 2016. 11. 22..
//  Copyright © 2016년 RadioactiveTEA. All rights reserved.
//

import Foundation
import UIKit

class View_MindMapNode
{
    var model:Model_Node
    var button:UIButton
    var shapeLayer:CAShapeLayer
    
    init(model:Model_Node)
    {
        self.model = model
        
        self.button = UIButton()
        
        self.button.frame.size.width = 200
        self.button.frame.size.height = 30
        self.button.layer.cornerRadius = 20/3
        
        self.button.backgroundColor = UIColor(red:91/255, green:118/255, blue:136/255, alpha: 1)
        
        self.shapeLayer = CAShapeLayer()
        
        self.render()
    }
    
    func render()
    {
        var name:String = " "
        
        for comp in model.components
        {
            if let comp_name = comp as? Model_Component_Name
            {
                name = comp_name.name
            }
        }
        
        self.button.frame.origin.x = self.model.x
        self.button.frame.origin.y = self.model.y
        self.button.setTitle(name, for: UIControlState.normal)
        
        let path = UIBezierPath()
        
        for child in model.children
        {
            let start = CGPoint(x:self.model.x + 200, y:self.model.y+15)
            let end = CGPoint(x:child.x, y:child.y+15)
            
            let distx = (end.x - start.x) / 2
            
            let ctrl1 = CGPoint(x:self.model.x + 200 + distx, y:self.model.y+15)
            let ctrl2 = CGPoint(x:child.x-distx, y:child.y+15)
            
            path.move(to:start)
            path.addCurve(to:end, controlPoint1:ctrl1, controlPoint2:ctrl2)
            path.addCurve(to:start, controlPoint1:ctrl2, controlPoint2:ctrl1)
        }
        
        //design path in layer
        self.shapeLayer.path = path.cgPath
        self.shapeLayer.strokeColor = UIColor(red:55/255, green:73/255, blue:94/255, alpha: 1).cgColor
        self.shapeLayer.lineWidth = 2.0
    }
}
