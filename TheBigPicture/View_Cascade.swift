//
//  ViewController.swift
//  TheBigPicture
//
//  Created by RadioactiveTEA on 2016. 11. 1..
//  Copyright © 2016년 RadioactiveTEA. All rights reserved.
//

import UIKit

class View_Cascade: UIView
{
    var map_view_node:[Int:View_CascadeNode]
    
    override init(frame: CGRect)
    {
        self.map_view_node = [:]
        super.init(frame:frame)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        self.map_view_node = [:]
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    func initialize()
    {
        self.backgroundColor = UIColor(white:0.9, alpha: 1)
        
        self.render()
    }
    
    func render()
    {
        self.arrange_cascade(pos: CGPoint(x:10, y:30), node: s_node_container.root_node!)
        
        for node in s_node_container.map_node
        {
            if self.map_view_node[node.value.id] == nil
            {
                let new_view_node = View_CascadeNode(model:node.value)
                
                self.map_view_node[node.value.id] = new_view_node
                self.addSubview(new_view_node.button)
            }
            else
            {
                self.map_view_node[node.value.id]?.model = node.value
            }
            
            self.map_view_node[node.value.id]?.render()
        }
    }
    
    func arrange_cascade(pos:CGPoint, node:Model_Node) -> CGFloat
    {
        let stride_x:CGFloat = 50
        let node_height:CGFloat = 40
        var child_y:CGFloat = node_height + 10
        
        for child in node.children
        {
            var child_pos = CGPoint(x:0, y:0)
            
            child_pos.x = pos.x + stride_x
            child_pos.y = pos.y + child_y
            
            child_y += self.arrange_cascade(pos:child_pos, node:s_node_container.get_node(node_id:child.id))
        }
        
        node.x = pos.x
        node.y = pos.y
    
        return child_y
    }


}

