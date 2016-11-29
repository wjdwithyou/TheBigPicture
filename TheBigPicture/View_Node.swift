//
//  View_Node.swift
//  TheBigPicture
//
//  Created by RadioactiveTEA on 2016. 11. 22..
//  Copyright © 2016년 RadioactiveTEA. All rights reserved.
//

import Foundation
import UIKit

class View_Node
{
    var model:Model_Node
    var button:UIButton
    
    init(model:Model_Node)
    {
        self.model = model
        
        self.button = UIButton()
        
        self.button.frame.size.width = 100
        self.button.frame.size.height = 20
        self.button.layer.cornerRadius = 5
        
        self.render()
    }
    
    func render()
    {
        self.button.frame.origin.x = self.model.x
        self.button.frame.origin.y = self.model.y
        self.button.backgroundColor = UIColor(red: 0.21, green: 0.37, blue: 0.45, alpha: 1)
    }
}