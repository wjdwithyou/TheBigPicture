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

class Model_NodeContainer
{
    var map_node:[Int:Model_Node]
    var root_node:Model_Node?
    
    init()
    {
        self.map_node = [:]
        self.root_node = nil
    }
    
    func create_node(node_id:Int, parent_id:Int)
    {
        let node = Model_Node(id:node_id, parent_id:parent_id)
    
        if parent_id == -1
        {
            self.root_node = node
        }
    
        self.map_node[node_id] = node;
    }
}
