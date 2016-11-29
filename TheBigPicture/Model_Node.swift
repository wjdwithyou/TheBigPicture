//
//  mode_node.swift
//  TheBigPicture
//
//  Created by mac on 2016. 11. 1..
//  Copyright © 2016년 RadioactiveTEA. All rights reserved.
//

import Foundation
import UIKit

class Model_Node
{
    var id:Int
    var parent_id:Int
    var components:Array<Model_Component>
    var children:Array<Model_Node>
    var x:CGFloat
    var y:CGFloat
    
    init(id:Int,parent_id:Int)
    {
        self.id = id
        self.parent_id = parent_id
        self.components = []
        self.children = []
        self.x = 0
        self.y = 0
    }
    
    func addChild(child:Model_Node) -> Void
    {
        children.append(child)
    }
    
    func addComponent(element:Model_Component) -> Void
    {
        components.append(element)
    }
    
    func removeComponent(element:Model_Component) -> Void
    {
    }
}
