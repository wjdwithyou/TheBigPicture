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
    
    init(model:Model_Node)
    {
        self.model = model
        
        self.button = UIButton()
        
        self.button.frame.size.width = 200
        self.button.frame.size.height = 40
        self.button.layer.cornerRadius = 10
        
        self.button.backgroundColor = UIColor(red:91/255, green:118/255, blue:136/255, alpha: 1)
        
        self.render()
    }
    
    func render()
    {
        var name:String = ""
        
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
    }
}
